import 'package:beneesse_api/beneesse_api.dart';
import 'package:dio/dio.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:test/test.dart';

class _FakeSessionService implements SessionService {
  String? accessToken;
  String? refreshToken;
  var updateTokensCalls = 0;
  var clearSessionCalls = 0;

  @override
  String? readAccessToken() => accessToken;

  @override
  String? readRefreshToken() => refreshToken;

  @override
  Future<void> updateTokens({
    required String accessToken,
    required String refreshToken,
  }) async {
    updateTokensCalls++;
    this.accessToken = accessToken;
    this.refreshToken = refreshToken;
  }

  @override
  Future<void> clearSession() async {
    clearSessionCalls++;
    accessToken = null;
    refreshToken = null;
  }
}

class _RecordingErrorHandler extends ErrorInterceptorHandler {
  bool forwarded = false;
  bool resolved = false;
  Response<dynamic>? resolvedResponse;

  @override
  void next(DioException err) {
    forwarded = true;
  }

  @override
  void resolve(Response<dynamic> response) {
    resolved = true;
    resolvedResponse = response;
    super.resolve(response);
  }
}

void main() {
  group('AuthInterceptor', () {
    late Dio mainDio;
    late DioAdapter mainAdapter;
    late Dio refreshDio;
    late DioAdapter refreshAdapter;
    late _FakeSessionService session;

    setUp(() {
      mainDio = Dio(BaseOptions(baseUrl: 'https://api.test'));
      mainAdapter = DioAdapter(dio: mainDio);
      refreshDio = Dio(BaseOptions(baseUrl: 'https://api.test'));
      refreshAdapter = DioAdapter(dio: refreshDio);
      session = _FakeSessionService()
        ..accessToken = 'old-access'
        ..refreshToken = 'old-refresh';

      mainDio.interceptors.add(
        AuthInterceptor(
          sessionService: session,
          baseUrl: 'https://api.test',
          refreshDio: refreshDio,
          retryDio: mainDio,
        ),
      );
    });

    test('attaches Authorization header when token present', () async {
      String? capturedAuth;
      mainDio.interceptors.add(
        InterceptorsWrapper(
          onRequest: (options, handler) {
            capturedAuth = options.headers['Authorization'] as String?;
            handler.next(options);
          },
        ),
      );

      mainAdapter.onGet(
        '/protected',
        (server) => server.reply(200, {'ok': true}),
        data: null,
      );

      await mainDio.get<Map<String, dynamic>>('/protected');

      expect(capturedAuth, 'Bearer old-access');
    });

    test('retries once after 401 when refresh succeeds', () async {
      refreshAdapter.onPost(
        '/auth/refresh',
        (server) => server.reply(200, {
          'accessToken': 'new-access',
          'refreshToken': 'new-refresh',
          'tokenType': 'bearer',
          'expiresIn': 3600,
        }),
        data: {'refreshToken': 'old-refresh'},
      );

      mainAdapter.onGet(
        '/protected',
        (server) => server.reply(200, {'ok': true}),
        data: null,
      );

      final interceptor = mainDio.interceptors
          .whereType<AuthInterceptor>()
          .first;
      final options = RequestOptions(
        path: '/protected',
        baseUrl: 'https://api.test',
        method: 'GET',
      );

      final handler = _RecordingErrorHandler();
      await interceptor.onError(
        DioException(
          requestOptions: options,
          response: Response(
            requestOptions: options,
            statusCode: 401,
            data: {'code': 'unauthorized', 'message': 'Expired'},
          ),
          type: DioExceptionType.badResponse,
        ),
        handler,
      );

      expect(handler.resolved, isTrue);
      expect(handler.resolvedResponse?.statusCode, 200);
      expect(session.updateTokensCalls, 1);
      expect(session.accessToken, 'new-access');
      expect(session.refreshToken, 'new-refresh');
      expect(session.clearSessionCalls, 0);
    });

    test('clears session when refresh fails', () async {
      refreshAdapter.onPost(
        '/auth/refresh',
        (server) => server.reply(401, {
          'code': 'unauthorized',
          'message': 'Invalid refresh',
        }),
        data: {'refreshToken': 'old-refresh'},
      );

      final interceptor = mainDio.interceptors
          .whereType<AuthInterceptor>()
          .first;
      final options = RequestOptions(path: '/protected');
      final handler = _RecordingErrorHandler();

      await interceptor.onError(
        DioException(
          requestOptions: options,
          response: Response(requestOptions: options, statusCode: 401),
          type: DioExceptionType.badResponse,
        ),
        handler,
      );

      expect(handler.forwarded, isTrue);
      expect(handler.resolved, isFalse);
      expect(session.clearSessionCalls, 1);
      expect(session.updateTokensCalls, 0);
    });

    test('forwards error when refresh token is missing', () async {
      session.refreshToken = null;

      final interceptor = mainDio.interceptors
          .whereType<AuthInterceptor>()
          .first;
      final options = RequestOptions(path: '/protected');
      final handler = _RecordingErrorHandler();

      await interceptor.onError(
        DioException(
          requestOptions: options,
          response: Response(requestOptions: options, statusCode: 401),
          type: DioExceptionType.badResponse,
        ),
        handler,
      );

      expect(handler.forwarded, isTrue);
      expect(handler.resolved, isFalse);
      expect(session.clearSessionCalls, 0);
      expect(session.updateTokensCalls, 0);
    });

    test('forwards error when already retried', () async {
      final interceptor = mainDio.interceptors
          .whereType<AuthInterceptor>()
          .first;
      final options = RequestOptions(path: '/protected')
        ..extra['auth_retry'] = true;
      final handler = _RecordingErrorHandler();

      await interceptor.onError(
        DioException(
          requestOptions: options,
          response: Response(requestOptions: options, statusCode: 401),
          type: DioExceptionType.badResponse,
        ),
        handler,
      );

      expect(handler.forwarded, isTrue);
      expect(session.updateTokensCalls, 0);
    });

    test('clears session when default refresh dio cannot reach server', () async {
      final interceptorOnly = Dio(BaseOptions(baseUrl: 'https://api.test'));
      final localSession = _FakeSessionService()
        ..accessToken = 'access'
        ..refreshToken = 'refresh';

      interceptorOnly.interceptors.add(
        AuthInterceptor(
          sessionService: localSession,
          baseUrl: 'https://api.test',
        ),
      );

      final interceptor = interceptorOnly.interceptors
          .whereType<AuthInterceptor>()
          .first;
      final handler = _RecordingErrorHandler();

      await interceptor.onError(
        DioException(
          requestOptions: RequestOptions(path: '/protected'),
          response: Response(
            requestOptions: RequestOptions(path: '/protected'),
            statusCode: 401,
          ),
          type: DioExceptionType.badResponse,
        ),
        handler,
      );

      expect(localSession.clearSessionCalls, 1);
      expect(handler.forwarded, isTrue);
    });

    test('forwards retry error when retried request fails', () async {
      refreshAdapter.onPost(
        '/auth/refresh',
        (server) => server.reply(200, {
          'accessToken': 'new-access',
          'refreshToken': 'new-refresh',
          'tokenType': 'bearer',
          'expiresIn': 3600,
        }),
        data: {'refreshToken': 'old-refresh'},
      );

      mainAdapter.onGet(
        '/protected',
        (server) => server.reply(500, {'code': 'error', 'message': 'fail'}),
        data: null,
      );

      final interceptor = mainDio.interceptors
          .whereType<AuthInterceptor>()
          .first;
      final options = RequestOptions(
        path: '/protected',
        baseUrl: 'https://api.test',
        method: 'GET',
      );
      final handler = _RecordingErrorHandler();

      await interceptor.onError(
        DioException(
          requestOptions: options,
          response: Response(requestOptions: options, statusCode: 401),
          type: DioExceptionType.badResponse,
        ),
        handler,
      );

      expect(handler.forwarded, isTrue);
      expect(handler.resolved, isFalse);
      expect(session.updateTokensCalls, 1);
    });

    test('forwards error when retry dio is unavailable', () async {
      final interceptorOnly = Dio(BaseOptions(baseUrl: 'https://api.test'));
      interceptorOnly.interceptors.add(
        AuthInterceptor(
          sessionService: session,
          baseUrl: 'https://api.test',
          refreshDio: refreshDio,
        ),
      );

      refreshAdapter.onPost(
        '/auth/refresh',
        (server) => server.reply(200, {
          'accessToken': 'new-access',
          'refreshToken': 'new-refresh',
          'tokenType': 'bearer',
          'expiresIn': 3600,
        }),
        data: {'refreshToken': 'old-refresh'},
      );

      final interceptor = interceptorOnly.interceptors
          .whereType<AuthInterceptor>()
          .first;
      final handler = _RecordingErrorHandler();

      await interceptor.onError(
        DioException(
          requestOptions: RequestOptions(path: '/protected'),
          response: Response(
            requestOptions: RequestOptions(path: '/protected'),
            statusCode: 401,
          ),
          type: DioExceptionType.badResponse,
        ),
        handler,
      );

      expect(session.updateTokensCalls, 1);
      expect(handler.forwarded, isTrue);
      expect(handler.resolved, isFalse);
    });

    test('concurrent 401s share a single refresh request', () async {
      var refreshPosts = 0;
      refreshAdapter.onPost(
        '/auth/refresh',
        (server) {
          refreshPosts++;
          return server.reply(200, {
            'accessToken': 'new-access',
            'refreshToken': 'new-refresh',
            'tokenType': 'bearer',
            'expiresIn': 3600,
          });
        },
        data: {'refreshToken': 'old-refresh'},
      );

      mainAdapter.onGet(
        '/protected',
        (server) => server.reply(200, {'ok': true}),
        data: null,
      );

      final interceptor = mainDio.interceptors
          .whereType<AuthInterceptor>()
          .first;
      final options = RequestOptions(
        path: '/protected',
        baseUrl: 'https://api.test',
        method: 'GET',
      );
      final error = DioException(
        requestOptions: options,
        response: Response(requestOptions: options, statusCode: 401),
        type: DioExceptionType.badResponse,
      );

      final handler1 = _RecordingErrorHandler();
      final handler2 = _RecordingErrorHandler();

      await Future.wait([
        interceptor.onError(error, handler1),
        interceptor.onError(error, handler2),
      ]);

      expect(refreshPosts, 1);
      expect(session.updateTokensCalls, 1);
      expect(handler1.resolved || handler2.resolved, isTrue);
    });
  });
}
