import 'package:beneesse_api/beneesse_api.dart';

import 'session_notifier.dart';

/// Application-wide dependency placeholders.
///
/// Wire real token storage and base URL during app bootstrap.
class ServiceLocator {
  ServiceLocator._();

  static final ServiceLocator instance = ServiceLocator._();

  late final BeneesseApiClient apiClient;
  final SessionNotifier sessionNotifier = SessionNotifier();

  bool _initialized = false;
  String? _accessToken;
  String? _refreshToken;

  bool get isAuthenticated =>
      _accessToken != null && _accessToken!.isNotEmpty;

  void setSession({
    required String accessToken,
    required String refreshToken,
  }) {
    _accessToken = accessToken;
    _refreshToken = refreshToken;
    sessionNotifier.notifySessionChanged();
  }

  void clearSession() {
    _accessToken = null;
    _refreshToken = null;
    sessionNotifier.notifySessionChanged();
  }

  void init({
    required String baseUrl,
    String? accessToken,
    String? refreshToken,
    void Function(String access, String refresh)? onTokensUpdated,
  }) {
    _accessToken = accessToken;
    _refreshToken = refreshToken;

    if (_initialized) {
      return;
    }
    _initialized = true;

    apiClient = BeneesseApiClient(
      baseUrl: baseUrl,
      accessTokenReader: () => _accessToken,
      accessTokenWriter: (access, refresh) {
        _accessToken = access;
        _refreshToken = refresh;
        onTokensUpdated?.call(access, refresh);
        sessionNotifier.notifySessionChanged();
      },
      refreshTokens: () async {
        final currentRefresh = _refreshToken;
        if (currentRefresh == null || currentRefresh.isEmpty) {
          return null;
        }
        try {
          final response = await apiClient.run(
            () => apiClient.auth
                .refreshAuth(RefreshRequest(refreshToken: currentRefresh))
                .then((r) => r.data!),
          );
          return (
            accessToken: response.accessToken,
            refreshToken: response.refreshToken,
          );
        } on ApiException {
          return null;
        }
      },
    );
  }
}
