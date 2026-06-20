import 'package:ermeo_api/ermeo_api.dart' as api;
import 'package:ermeo_secure_storage/ermeo_secure_storage.dart';
import 'package:flutter/foundation.dart';

import 'package:ermeo_mobile/core/session/session_state.dart';

class AppSessionService extends ChangeNotifier implements api.SessionService {
  AppSessionService({required this._tokenStorage});

  final TokenSecureStorage _tokenStorage;

  SessionStatus _status = SessionStatus.unknown;

  String? _accessToken;

  String? _refreshToken;

  Listenable get listenable => this;

  SessionStatus get status => _status;

  bool get isAuthenticated => _status == SessionStatus.authenticated;

  @override
  String? readAccessToken() => _accessToken;

  @override
  String? readRefreshToken() => _refreshToken;

  Future<void> restore() async {
    final tokens = await _tokenStorage.readTokens();
    if (tokens == null) {
      await clearSession();
      return;
    }

    await _persistTokens(
      accessToken: tokens.accessToken,
      refreshToken: tokens.refreshToken,
    );
  }

  Future<void> setSession({
    required String accessToken,
    required String refreshToken,
  }) async {
    await _persistTokens(accessToken: accessToken, refreshToken: refreshToken);
  }

  @override
  Future<void> updateTokens({
    required String accessToken,
    required String refreshToken,
  }) async {
    await _persistTokens(accessToken: accessToken, refreshToken: refreshToken);
  }

  @override
  Future<void> clearSession() async {
    _accessToken = null;
    _refreshToken = null;
    await _tokenStorage.clearTokens();
    _setStatus(SessionStatus.unauthenticated);
  }

  Future<void> _persistTokens({
    required String accessToken,
    required String refreshToken,
  }) async {
    _accessToken = accessToken;
    _refreshToken = refreshToken;
    await _tokenStorage.writeTokens(
      SessionTokens(accessToken: accessToken, refreshToken: refreshToken),
    );
    _setStatus(SessionStatus.authenticated);
  }

  void _setStatus(SessionStatus status) {
    if (_status == status) {
      return;
    }
    _status = status;
    notifyListeners();
  }
}
