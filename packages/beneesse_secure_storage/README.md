# beneesse_secure_storage

Focused secure persistence for authentication session tokens.

## Public API

- `TokenSecureStorage` provides:
  - `readTokens()`
  - `writeTokens(SessionTokens tokens)`
  - `clearTokens()`
- `SessionTokens` stores `accessToken` and `refreshToken`.

## Usage

```dart
import 'package:beneesse_secure_storage/beneesse_secure_storage.dart';

final storage = FlutterTokenSecureStorage();

await storage.writeTokens(
  const SessionTokens(
    accessToken: 'access-token',
    refreshToken: 'refresh-token',
  ),
);
```
