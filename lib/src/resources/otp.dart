import '../client.dart';
import '../models.dart';

class OTP {
  final Client _client;

  OTP(this._client);

  Future<OtpResponse> send(
      {required String to, String brand = "PlexiSMS"}) async {
    final data = {
      'phone_number': to,
      'brand': brand,
    };
    final response =
        await _client.request('POST', '/api/sms/send-otp/', data: data);
    return OtpResponse.fromJson(response);
  }

  Future<OtpResponse> verify(
      {required String verificationId, required String code}) async {
    final data = {
      'verification_id': verificationId,
      'otp_code': code,
    };
    final response =
        await _client.request('POST', '/api/sms/verify-otp/', data: data);
    return OtpResponse.fromJson(response);
  }
}
