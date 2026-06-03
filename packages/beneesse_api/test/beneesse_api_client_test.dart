import 'package:beneesse_api/beneesse_api.dart';
import 'package:dio/dio.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:test/test.dart';

void main() {
  group('BeneesseApiClient', () {
    test('configures base URL and timeouts', () {
      final client = BeneesseApiClient(
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

      final client = BeneesseApiClient(baseUrl: 'https://api.test', dio: dio);

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

      final client = BeneesseApiClient(baseUrl: 'https://api.test', dio: dio);
      final status = await client.run(() async {
        final response = await client.health.getHealth();
        return response.data?.status;
      });

      expect(status, 'ok');
    });

    test('exposes generated API accessors', () {
      final client = BeneesseApiClient(baseUrl: 'https://api.example.com');
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
      final client = BeneesseApiClient(
        baseUrl: 'https://api.example.com',
        sessionService: session,
      );

      expect(
        client.dio.interceptors.whereType<AuthInterceptor>(),
        isNotEmpty,
      );
    });
  });
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
