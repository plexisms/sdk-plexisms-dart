# Plexisms Dart SDK

A Dart client for the [PlexiSMS API](https://plexisms.com).

## Features

-   Send SMS messages (individual and bulk)
-   Check your account balance
-   Verify phone numbers with OTP

## Getting started

Add the dependency to your `pubspec.yaml`:

```yaml
dependencies:
  plexisms: ^0.0.1
```

Or install it via command line:

```bash
dart pub add plexisms
```

## Usage

### Initialization

```dart
import 'dart:io';
import 'package:plexisms/plexisms.dart';

void main() async {
  // Initialize with API Key directly
  final client = Client('YOUR_API_KEY');

  // Or use environment variable PLEXISMS_API_KEY
  // final client = Client(Platform.environment['PLEXISMS_API_KEY']);
}
```

### Sending SMS

```dart
try {
  SmsResponse response = await client.messages.create(
    to: '+243970000000',
    body: 'Hello from PlexiSMS! 🚀',
    senderId: 'MyApp',
  );

  print('Message ID: ${response.messageId}');
  print('Status: ${response.status}');
} on PlexismsError catch (e) {
  print('Error: ${e.message}');
}
```

### Checking Balance

```dart
try {
  BalanceResponse balance = await client.account.balance();
  print('Balance: ${balance.balance} ${balance.currency}');
} catch (e) {
  print(e);
}
```

### Sending OTP

```dart
try {
  OtpResponse response = await client.otp.send(to: '+243970000000');
  print('Verification ID: ${response.verificationId}');
} catch (e) {
  print(e);
}
```

## Error Handling

The SDK throws specific exceptions for different error conditions:

-   `AuthenticationError`: Invalid API key or permissions (HTTP 401/403).
-   `BalanceError`: Insufficient funds (HTTP 402).
-   `ValidationError`: Invalid input data (HTTP 400/422).
-   `APIError`: Generic API errors or server issues (HTTP 500+).
