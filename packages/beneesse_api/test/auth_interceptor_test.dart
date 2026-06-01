import 'package:beneesse_api/beneesse_api.dart';
import 'package:dio/dio.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:test/test.dart';

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
    late Dio dio;
    late DioAdapter adapter;
    String? accessToken;
    String? refreshToken;
    var refreshCalls = 0;

    setUp(() {
      dio = Dio(BaseOptions(baseUrl: 'https://api.test'));
      adapter = DioAdapter(dio: dio);
      accessToken = 'old-access';
      refreshToken = 'old-refresh';
      refreshCalls = 0;

      dio.interceptors.add(
        AuthInterceptor(
          readAccessToken: () => accessToken,
          writeTokens: (access, refresh) {
            accessToken = access;
            refreshToken = refresh;
          },
          refreshTokens: () async {
            refreshCalls++;
            if (refreshCalls > 1) return null;
            return (
              accessToken: 'new-access',
              refreshToken: 'new-refresh',
            );
          },
          refreshDio: dio,
        ),
      );
    });

    test('attaches Authorization header when token present', () async {
      String? capturedAuth;
      dio.interceptors.add(
        InterceptorsWrapper(
          onRequest: (options, handler) {
            capturedAuth = options.headers['Authorization'] as String?;
            handler.next(options);
          },
        ),
      );

      adapter.onGet(
        '/protected',
        (server) => server.reply(200, {'ok': true}),
        data: null,
      );

      await dio.get<Map<String, dynamic>>('/protected');

      expect(capturedAuth, 'Bearer old-access');
    });

    test('retries once after 401 when refresh succeeds', () async {
      adapter.onGet(
        '/protected',
        (server) => server.reply(200, {'ok': true}),
        data: null,
      );

      final interceptor = dio.interceptors
          .whereType<AuthInterceptor>()
          .first;
      final options = RequestOptions(
        path: '/protected',
        baseUrl: 'https://api.test',
        method: 'GET',
      );
      options.extra['dio'] = dio;

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
      expect(refreshCalls, 1);
      expect(accessToken, 'new-access');
      expect(refreshToken, 'new-refresh');
    });

    test('forwards error when refresh returns null', () async {
      refreshCalls = 1;
      final interceptor = dio.interceptors
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
    });
  });
}
