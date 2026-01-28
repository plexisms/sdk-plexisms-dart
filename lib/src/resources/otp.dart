import '../client.dart';

class OTP {
  final Client _client;

  OTP(this._client);

  Future<dynamic> send({required String to, String brand = "PlexiSMS"}) async {
    final data = {'phone_number': to, 'brand': brand};
    return _client.request('POST', '/api/sms/send-otp/', data: data);
  }

  Future<dynamic> verify({
    required String verificationId,
    required String code,
  }) async {
    final data = {'verification_id': verificationId, 'otp_code': code};
    return _client.request('POST', '/api/sms/verify-otp/', data: data);
  }
}
