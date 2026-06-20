import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'session_tokens.dart';

const _accessTokenKey = 'auth.access_token';
const _refreshTokenKey = 'auth.refresh_token';

abstract class TokenSecureStorage {
  Future<SessionTokens?> readTokens();

  Future<void> writeTokens(SessionTokens tokens);

  Future<void> clearTokens();
}

class InMemoryTokenSecureStorage implements TokenSecureStorage {
  InMemoryTokenSecureStorage();

  SessionTokens? _tokens;

  @override
  Future<SessionTokens?> readTokens() async => _tokens;

  @override
  Future<void> writeTokens(SessionTokens tokens) async => _tokens = tokens;

  @override
  Future<void> clearTokens() async => _tokens = null;
}

class FlutterTokenSecureStorage implements TokenSecureStorage {
  FlutterTokenSecureStorage({FlutterSecureStorage? storage})
    : _storage = storage ?? const FlutterSecureStorage();

  final FlutterSecureStorage _storage;

  @override
  Future<SessionTokens?> readTokens() async {
    final accessToken = await _storage.read(key: _accessTokenKey);
    final refreshToken = await _storage.read(key: _refreshTokenKey);

    if (accessToken == null || refreshToken == null) {
      return null;
    }

    return SessionTokens(accessToken: accessToken, refreshToken: refreshToken);
  }

  @override
  Future<void> writeTokens(SessionTokens tokens) async {
    await _storage.write(key: _accessTokenKey, value: tokens.accessToken);
    await _storage.write(key: _refreshTokenKey, value: tokens.refreshToken);
  }

  @override
  Future<void> clearTokens() async {
    await _storage.delete(key: _accessTokenKey);
    await _storage.delete(key: _refreshTokenKey);
  }
}
