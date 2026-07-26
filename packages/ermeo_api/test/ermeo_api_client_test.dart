import 'package:ermeo_api/ermeo_api.dart';
import 'package:dio/dio.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:test/test.dart';

void main() {
  group('ErmeoApiClient', () {
    test('configures base URL and timeouts', () {
      final client = ErmeoApiClient(
        baseUrl: 'https://api.example.com',
        connectTimeout: const Duration(seconds: 5),
        receiveTimeout: const Duration(seconds: 10),
      );

      expect(client.dio.options.baseUrl, 'https://api.example.com');
      expect(client.dio.options.connectTimeout, const Duration(seconds: 5));
      expect(client.dio.options.receiveTimeout, const Duration(seconds: 10));
    });

    test('run maps DioException to ApiException', () async {
      final dio = Dio(BaseOptions(baseUrl: 'https://api.test'));
      final adapter = DioAdapter(dio: dio);
      adapter.onGet(
        '/health',
        (server) => server.reply(503, {
          'code': 'unavailable',
          'message': 'Down',
        }),
        data: null,
      );

      final client = ErmeoApiClient(baseUrl: 'https://api.test', dio: dio);

      await expectLater(
        client.run(() async {
          final response = await client.health.getHealth();
          return response.data;
        }),
        throwsA(
          isA<ApiException>().having((e) => e.code, 'code', 'unavailable'),
        ),
      );
    });

    test('run returns successful result', () async {
      final dio = Dio(BaseOptions(baseUrl: 'https://api.test'));
      final adapter = DioAdapter(dio: dio);
      adapter.onGet(
        '/health',
        (server) => server.reply(200, {'status': 'ok'}),
        data: null,
      );

      final client = ErmeoApiClient(baseUrl: 'https://api.test', dio: dio);
      final status = await client.run(() async {
        final response = await client.health.getHealth();
        return response.data?.status;
      });

      expect(status, 'ok');
    });

    test('exposes generated API accessors', () {
      final client = ErmeoApiClient(baseUrl: 'https://api.example.com');
      expect(client.health, isNotNull);
      expect(client.auth, isNotNull);
      expect(client.exercises, isNotNull);
      expect(client.workouts, isNotNull);
      expect(client.sessions, isNotNull);
      expect(client.instructors, isNotNull);
      expect(client.assignments, isNotNull);
      expect(client.athletes, isNotNull);
    });

    test('registers AuthInterceptor when sessionService is provided', () {
      final session = _FakeSessionService();
      final client = ErmeoApiClient(
        baseUrl: 'https://api.example.com',
        sessionService: session,
      );

      expect(
        client.dio.interceptors.whereType<AuthInterceptor>(),
        isNotEmpty,
      );
    });

    test('registers LoggingInterceptor when logger is provided', () {
      final client = ErmeoApiClient(
        baseUrl: 'https://api.example.com',
        logger: _FakeApiLogger(),
      );

      expect(
        client.dio.interceptors.whereType<LoggingInterceptor>(),
        isNotEmpty,
      );
    });

    test('does not register LoggingInterceptor when logger is omitted', () {
      final client = ErmeoApiClient(baseUrl: 'https://api.example.com');

      expect(
        client.dio.interceptors.whereType<LoggingInterceptor>(),
        isEmpty,
      );
    });
  });
}

class _FakeApiLogger implements ApiLogger {
  @override
  void d(String message) {}

  @override
  void i(String message) {}

  @override
  void w(String message, {Object? error, StackTrace? stackTrace}) {}

  @override
  void e(String message, {Object? error, StackTrace? stackTrace}) {}
}

class _FakeSessionService implements SessionService {
  @override
  String? readAccessToken() => null;

  @override
  String? readRefreshToken() => null;

  @override
  Future<void> updateTokens({
    required String accessToken,
    required String refreshToken,
  }) async {}

  @override
  Future<void> clearSession() async {}
}
