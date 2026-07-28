import 'package:ermeo_api/ermeo_api.dart' as api;
import 'package:ermeo_secure_storage/ermeo_secure_storage.dart';
import 'package:flutter/foundation.dart';

import 'package:ermeo_mobile/core/session/session_state.dart';
import 'package:ermeo_mobile/features/auth/models/auth_role.dart';

class AppSessionService extends ChangeNotifier implements api.SessionService {
  AppSessionService({required this._tokenStorage});

  final TokenSecureStorage _tokenStorage;

  SessionStatus _status = SessionStatus.unknown;

  String? _accessToken;

  String? _refreshToken;

  AuthRole? _role;

  bool _profileLoaded = false;

  Listenable get listenable => this;

  SessionStatus get status => _status;

  bool get isAuthenticated => _status == SessionStatus.authenticated;

  /// True when tokens exist but the user has not chosen a role yet.
  bool get needsOnboarding =>
      isAuthenticated && _profileLoaded && _role == null;

  bool get hasCompletedOnboarding =>
      isAuthenticated && _profileLoaded && _role != null;

  AuthRole? get role => _role;

  bool get isProfileLoaded => _profileLoaded;

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

  void setProfile({required AuthRole? role}) {
    _role = role;
    _profileLoaded = true;
    notifyListeners();
  }

  void clearProfile() {
    _role = null;
    _profileLoaded = false;
    notifyListeners();
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
    _role = null;
    _profileLoaded = false;
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
