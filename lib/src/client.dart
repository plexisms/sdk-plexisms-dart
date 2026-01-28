import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'exceptions.dart';
import 'resources/messages.dart';
import 'resources/otp.dart';
import 'resources/account.dart';

class Client {
  static const String defaultBaseUrl = "https://server.plexisms.com";

  final String apiKey;
  final String baseUrl;
  final http.Client _httpClient;

  late final Messages messages;
  late final OTP otp;
  late final Account account;

  Client(String? apiKey, {String? baseUrl, http.Client? httpClient})
      : apiKey = apiKey ?? Platform.environment['PLEXISMS_API_KEY'] ?? '',
        baseUrl = (baseUrl ?? Platform.environment['PLEXISMS_BASE_URL'] ?? defaultBaseUrl).replaceAll(RegExp(r'/$'), ''),
        _httpClient = httpClient ?? http.Client() {
    if (this.apiKey.isEmpty) {
      throw AuthenticationError("API Key is required. Pass it to the constructor or set PLEXISMS_API_KEY environment variable.");
    }
    
    messages = Messages(this);
    otp = OTP(this);
    account = Account(this);
  }

  Future<dynamic> request(String method, String endpoint, {Map<String, dynamic>? data, Map<String, dynamic>? params}) async {
    final url = Uri.parse('$baseUrl$endpoint').replace(queryParameters: params);
    final headers = {
      'Authorization': 'Token $apiKey',
      'Content-Type': 'application/json',
      'User-Agent': 'plexisms-dart/0.0.1',
    };

    http.Response response;
    try {
      if (method == 'GET') {
        response = await _httpClient.get(url, headers: headers);
      } else if (method == 'POST') {
        response = await _httpClient.post(url, headers: headers, body: data != null ? jsonEncode(data) : null);
      } else {
        throw APIError('Unsupported HTTP method: $method');
      }
    } catch (e) {
      throw APIError('Connection failed: $e');
    }

    if (response.statusCode >= 400) {
      _handleError(response);
    }

    if (response.body.isEmpty) {
      return {};
    }

    try {
      return jsonDecode(response.body);
    } catch (e) {
      return {};
    }
  }

  void _handleError(http.Response response) {
    String errorMessage;
    try {
      final errorData = jsonDecode(response.body);
      errorMessage = errorData['error'] ?? errorData['detail'] ?? response.body;
    } catch (_) {
      errorMessage = response.body;
    }

    if (response.statusCode == 401) {
      throw AuthenticationError("Unauthorized: $errorMessage");
    } else if (response.statusCode == 402) {
      throw BalanceError("Insufficient funds: $errorMessage");
    } else if (response.statusCode == 400) {
      throw ValidationError("Bad Request: $errorMessage");
    } else if (response.statusCode == 403) {
      throw AuthenticationError("Forbidden: $errorMessage");
    } else if (response.statusCode == 422) {
      throw ValidationError("Validation Error: $errorMessage");
    } else if (response.statusCode >= 500) {
      throw APIError("Server Error (${response.statusCode}): $errorMessage", statusCode: response.statusCode);
    } else {
      throw APIError("API Error (${response.statusCode}): $errorMessage", statusCode: response.statusCode);
    }
  }
}
