import 'dart:async';

import 'package:beneesse_api/beneesse_api.dart';
import 'package:beneesse_secure_storage/beneesse_secure_storage.dart';
import 'package:flutter/foundation.dart';

import 'session_state.dart';

abstract class SessionService {
  Listenable get listenable;

  SessionStatus get status;

  bool get isAuthenticated;

  String? readAccessToken();

  Future<void> restore();

  Future<void> setSession({
    required String accessToken,
    required String refreshToken,
  });

  Future<void> clearSession();

  void onTokensUpdated(String accessToken, String refreshToken);

  Future<({String accessToken, String refreshToken})?> refreshTokens();
}

class SessionServiceImpl extends ChangeNotifier implements SessionService {
  SessionServiceImpl({
    required TokenSecureStorage tokenStorage,
    required String baseUrl,
  })  : _tokenStorage = tokenStorage,
        _baseUrl = baseUrl;

  final TokenSecureStorage _tokenStorage;
  final String _baseUrl;

  @override
  Listenable get listenable => this;

  SessionStatus _status = SessionStatus.unknown;
  String? _accessToken;
  String? _refreshToken;
  BeneesseApiClient? _refreshClient;

  @override
  SessionStatus get status => _status;

  @override
  bool get isAuthenticated => _status == SessionStatus.authenticated;

  @override
  String? readAccessToken() => _accessToken;

  @override
  Future<void> restore() async {
    final tokens = await _tokenStorage.readTokens();
    if (tokens == null) {
      await clearSession();
      return;
    }

    _accessToken = tokens.accessToken;
    _refreshToken = tokens.refreshToken;
    _setStatus(SessionStatus.authenticated);
  }

  @override
  Future<void> setSession({
    required String accessToken,
    required String refreshToken,
  }) async {
    _accessToken = accessToken;
    _refreshToken = refreshToken;
    await _tokenStorage.writeTokens(
      SessionTokens(
        accessToken: accessToken,
        refreshToken: refreshToken,
      ),
    );
    _setStatus(SessionStatus.authenticated);
  }

  @override
  Future<void> clearSession() async {
    _accessToken = null;
    _refreshToken = null;
    await _tokenStorage.clearTokens();
    _setStatus(SessionStatus.unauthenticated);
  }

  @override
  void onTokensUpdated(String accessToken, String refreshToken) {
    _accessToken = accessToken;
    _refreshToken = refreshToken;
    unawaited(
      _tokenStorage.writeTokens(
        SessionTokens(
          accessToken: accessToken,
          refreshToken: refreshToken,
        ),
      ),
    );
    _setStatus(SessionStatus.authenticated);
  }

  @override
  Future<({String accessToken, String refreshToken})?> refreshTokens() async {
    final currentRefresh = _refreshToken;
    if (currentRefresh == null || currentRefresh.isEmpty) {
      return null;
    }

    final refreshClient = _refreshClient ??= BeneesseApiClient(baseUrl: _baseUrl);

    try {
      final response = await refreshClient.run(
        () => refreshClient.auth
            .refreshAuth(RefreshRequest(refreshToken: currentRefresh))
            .then((r) => r.data!),
      );

      await setSession(
        accessToken: response.accessToken,
        refreshToken: response.refreshToken,
      );

      return (
        accessToken: response.accessToken,
        refreshToken: response.refreshToken,
      );
    } on ApiException {
      await clearSession();
      return null;
    }
  }

  void _setStatus(SessionStatus status) {
    if (_status == status) {
      return;
    }
    _status = status;
    notifyListeners();
  }
}
