class SmsResponse {
  final String? messageId;
  final String? status;
  final String? to;
  final String? message;
  final String? error;

  SmsResponse({
    this.messageId,
    this.status,
    this.to,
    this.message,
    this.error,
  });

  factory SmsResponse.fromJson(Map<String, dynamic> json) {
    return SmsResponse(
      messageId: json['message_id'] as String?,
      status: json['status'] as String?,
      to: json['phone_number'] as String?,
      message: json['message'] as String?,
      error: json['error'] as String?,
    );
  }

  @override
  String toString() {
    return 'SmsResponse(messageId: $messageId, status: $status, to: $to)';
  }
}

class BalanceResponse {
  final double balance;
  final String currency;

  BalanceResponse({required this.balance, required this.currency});

  factory BalanceResponse.fromJson(Map<String, dynamic> json) {
    return BalanceResponse(
      balance:
          (json['balance'] is num) ? (json['balance'] as num).toDouble() : 0.0,
      currency: json['currency'] as String? ?? 'USD',
    );
  }

  @override
  String toString() => 'BalanceResponse(balance: $balance $currency)';
}

class OtpResponse {
  final String? verificationId;
  final String? status;
  final String? message;

  OtpResponse({this.verificationId, this.status, this.message});

  factory OtpResponse.fromJson(Map<String, dynamic> json) {
    return OtpResponse(
      verificationId: json['verification_id'] as String?,
      status: json['status'] as String?,
      message: json['message'] as String?,
    );
  }

  @override
  String toString() =>
      'OtpResponse(verificationId: $verificationId, status: $status)';
}
