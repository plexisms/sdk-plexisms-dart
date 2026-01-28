import '../client.dart';

class Messages {
  final Client _client;

  Messages(this._client);

  Future<dynamic> create({
    required String to,
    required String body,
    String? senderId,
    String smsType = 'transactional',
  }) async {
    final data = {'phone_number': to, 'message': body, 'sms_type': smsType};
    if (senderId != null) {
      data['sender_id'] = senderId;
    }

    return _client.request('POST', '/api/sms/send/', data: data);
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

  Future<dynamic> get(dynamic messageId) async {
    return _client.request('GET', '/api/sms/$messageId/status/');
  }
}
