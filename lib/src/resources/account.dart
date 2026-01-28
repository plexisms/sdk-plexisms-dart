import '../client.dart';

class Account {
  final Client _client;

  Account(this._client);

  Future<dynamic> balance() async {
    return _client.request('GET', '/api/sms/balance/');
  }
}
