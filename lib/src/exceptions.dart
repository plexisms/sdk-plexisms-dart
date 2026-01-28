class PlexismsError implements Exception {
  final String message;
  final int? statusCode;

  PlexismsError(this.message, {this.statusCode});

  @override
  String toString() => 'PlexismsError: $message${statusCode != null ? ' (Status: $statusCode)' : ''}';
}

class AuthenticationError extends PlexismsError {
  AuthenticationError(String message) : super(message, statusCode: 401);
}

class BalanceError extends PlexismsError {
  BalanceError(String message) : super(message, statusCode: 402);
}

class ValidationError extends PlexismsError {
  ValidationError(String message) : super(message, statusCode: 400);
}

class APIError extends PlexismsError {
  APIError(String message, {int? statusCode}) : super(message, statusCode: statusCode);
}
