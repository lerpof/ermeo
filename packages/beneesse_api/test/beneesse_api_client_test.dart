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

    test('exposes exercises API', () {
      final client = BeneesseApiClient(baseUrl: 'https://api.example.com');
      expect(client.exercises, isNotNull);
    });
  });
}
