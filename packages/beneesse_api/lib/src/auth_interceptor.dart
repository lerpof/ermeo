import 'package:dio/dio.dart';

typedef AccessTokenReader = String? Function();
typedef AccessTokenWriter = void Function(String accessToken, String refreshToken);
typedef RefreshTokensCallback = Future<({String accessToken, String refreshToken})?>
    Function();

/// Attaches JWT access tokens and retries once after refresh on 401.
class AuthInterceptor extends Interceptor {
  AuthInterceptor({
    required AccessTokenReader readAccessToken,
    required AccessTokenWriter writeTokens,
    required RefreshTokensCallback refreshTokens,
    Dio? refreshDio,
  })  : _readAccessToken = readAccessToken,
        _writeTokens = writeTokens,
        _refreshTokens = refreshTokens,
        _refreshDio = refreshDio;

  final AccessTokenReader _readAccessToken;
  final AccessTokenWriter _writeTokens;
  final RefreshTokensCallback _refreshTokens;
  final Dio? _refreshDio;

  static const _retryKey = 'auth_retry';

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final token = _readAccessToken();
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

    _writeTokens(refreshed.accessToken, refreshed.refreshToken);

    final dio = _refreshDio ?? err.requestOptions.extra['dio'] as Dio?;
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
}
