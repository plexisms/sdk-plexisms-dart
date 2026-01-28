import '../client.dart';
import '../models.dart';

class Messages {
  final Client _client;

  Messages(this._client);

  Future<SmsResponse> create({
    required String to,
    required String body,
    String? senderId,
    String smsType = 'transactional',
  }) async {
    final data = {'phone_number': to, 'message': body, 'sms_type': smsType};
    if (senderId != null) {
      data['sender_id'] = senderId;
    }

    final response =
        await _client.request('POST', '/api/sms/send/', data: data);
    return SmsResponse.fromJson(response);
  }

  Future<dynamic> createBulk({
    required List<String> phoneNumbers,
    required String body,
    String? senderId,
    String smsType = 'transactional',
  }) async {
    final data = {
      'phone_numbers': phoneNumbers,
      'message': body,
      'sms_type': smsType,
    };
    if (senderId != null) {
      data['sender_id'] = senderId;
    }

    return _client.request('POST', '/api/sms/send-bulk/', data: data);
  }

  Future<SmsResponse> get(dynamic messageId) async {
    final response =
        await _client.request('GET', '/api/sms/$messageId/status/');
    return SmsResponse.fromJson(response);
  }
}
