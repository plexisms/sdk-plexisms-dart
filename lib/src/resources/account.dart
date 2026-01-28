import '../client.dart';
import '../models.dart';

class Account {
  final Client _client;

  Account(this._client);

  Future<BalanceResponse> balance() async {
    final response = await _client.request('GET', '/api/sms/balance/');
    return BalanceResponse.fromJson(response);
  }
}
