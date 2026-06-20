import 'package:ermeo_api_client/ermeo_api_client.dart';
import 'package:dio/dio.dart';

import 'session_service.dart';

/// Attaches JWT access tokens and retries once after refresh on 401.
class AuthInterceptor extends Interceptor {
  AuthInterceptor({
    required this._sessionService,
    required this._baseUrl,
    this._connectTimeout = const Duration(seconds: 15),
    this._receiveTimeout = const Duration(seconds: 30),
    this._refreshDio,
    this._retryDio,
  });

  final SessionService _sessionService;
  final String _baseUrl;
  final Duration _connectTimeout;
  final Duration _receiveTimeout;
  final Dio? _refreshDio;
  final Dio? _retryDio;

  static const _retryKey = 'auth_retry';

  Future<({String accessToken, String refreshToken})?>? _refreshInFlight;

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final token = _sessionService.readAccessToken();
    if (token != null && token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    handler.next(options);
  }

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    final response = err.response;
    final alreadyRetried = err.requestOptions.extra[_retryKey] == true;

    if (response?.statusCode != 401 || alreadyRetried) {
      handler.next(err);
      return;
    }

    final refreshed = await _refreshTokens();
    if (refreshed == null) {
      handler.next(err);
      return;
    }

    final dio = _retryDio ?? err.requestOptions.extra['dio'] as Dio?;
    if (dio == null) {
      handler.next(err);
      return;
    }

    final options = err.requestOptions;
    options.extra[_retryKey] = true;
    options.headers['Authorization'] = 'Bearer ${refreshed.accessToken}';

    try {
      final retryResponse = await dio.fetch<dynamic>(options);
      handler.resolve(retryResponse);
    } on DioException catch (retryError) {
      handler.next(retryError);
    }
  }

  Future<({String accessToken, String refreshToken})?> _refreshTokens() async {
    if (_refreshInFlight != null) {
      return _refreshInFlight;
    }

    final refreshToken = _sessionService.readRefreshToken();
    if (refreshToken == null || refreshToken.isEmpty) {
      return null;
    }

    _refreshInFlight = _performRefresh(refreshToken);
    try {
      return await _refreshInFlight;
    } finally {
      _refreshInFlight = null;
    }
  }

  Future<({String accessToken, String refreshToken})?> _performRefresh(
    String refreshToken,
  ) async {
    final dio = _refreshDio ?? _createRefreshDio();

    try {
      final response = await AuthApi(dio).refreshAuth(
        RefreshRequest(refreshToken: refreshToken),
      );
      final tokens = response.data!;

      await _sessionService.updateTokens(
        accessToken: tokens.accessToken,
        refreshToken: tokens.refreshToken,
      );

      return (
        accessToken: tokens.accessToken,
        refreshToken: tokens.refreshToken,
      );
    } on DioException {
      await _sessionService.clearSession();
      return null;
    }
  }

  Dio _createRefreshDio() {
    return Dio(
      BaseOptions(
        baseUrl: _baseUrl,
        connectTimeout: _connectTimeout,
        receiveTimeout: _receiveTimeout,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );
  }
}
