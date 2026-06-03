/// Token storage contract for [AuthInterceptor] and [BeneesseApiClient].
abstract class SessionService {
  String? readAccessToken();

  String? readRefreshToken();

  Future<void> updateTokens({
    required String accessToken,
    required String refreshToken,
  });

  Future<void> clearSession();
}
