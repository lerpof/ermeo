import 'package:beneesse_api/beneesse_api.dart';

/// Application-wide dependency placeholders.
///
/// Wire real token storage and base URL during app bootstrap.
class ServiceLocator {
  ServiceLocator._();

  static final ServiceLocator instance = ServiceLocator._();

  late final BeneesseApiClient apiClient;

  String? _accessToken;
  String? _refreshToken;

  void init({
    required String baseUrl,
    String? accessToken,
    String? refreshToken,
    void Function(String access, String refresh)? onTokensUpdated,
  }) {
    _accessToken = accessToken;
    _refreshToken = refreshToken;

    apiClient = BeneesseApiClient(
      baseUrl: baseUrl,
      accessTokenReader: () => _accessToken,
      accessTokenWriter: (access, refresh) {
        _accessToken = access;
        _refreshToken = refresh;
        onTokensUpdated?.call(access, refresh);
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
