# plexisms

A Dart client for the PlexiSMS API.

This package provides a convenient way to interact with the PlexiSMS API from Dart applications.

## Features

- Send SMS messages
- Check your account balance
- Verify phone numbers with OTP

## Getting started

To use this package, you will need a PlexiSMS API key. You can get one by signing up for an account at [plexisms.com](https://plexisms.com).

## Usage

```dart
import 'package:plexisms/plexisms.dart';

void main() async {
  final client = PlexiSMS(apiKey: 'YOUR_API_KEY');

  try {
    final balance = await client.account.getBalance();
    print('Your account balance is: \$$balance');
  } on PlexiSMSException catch (e) {
    print(e.message);
  }
}
```

## Additional information

For more information, see the [PlexiSMS API documentation](https://plexisms.com/docs).
