import 'package:ermeo_api/ermeo_api.dart';
import 'package:dio/dio.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

class _MockApiLogger extends Mock implements ApiLogger {}

void main() {
  setUpAll(() {
    registerFallbackValue(StackTrace.empty);
  });

  group('LoggingInterceptor', () {
    late Dio dio;
    late DioAdapter adapter;
    late _MockApiLogger logger;

    setUp(() {
      dio = Dio(BaseOptions(baseUrl: 'https://api.test'));
      adapter = DioAdapter(dio: dio);
      logger = _MockApiLogger();
      dio.interceptors.add(LoggingInterceptor(logger: logger));

      when(() => logger.d(any())).thenReturn(null);
      when(() => logger.i(any())).thenReturn(null);
      when(
        () => logger.w(
          any(),
          error: any(named: 'error'),
          stackTrace: any(named: 'stackTrace'),
        ),
      ).thenReturn(null);
      when(
        () => logger.e(
          any(),
          error: any(named: 'error'),
          stackTrace: any(named: 'stackTrace'),
        ),
      ).thenReturn(null);
    });

    test('logs request and response bodies at debug', () async {
      adapter.onPost(
        '/auth/login',
        (server) => server.reply(200, {
          'accessToken': 'secret-access',
          'userId': 'u1',
        }),
        data: Matchers.any,
      );

      await dio.post<dynamic>(
        '/auth/login',
        data: {'email': 'a@b.com', 'password': 'hunter2'},
      );

      final logs = verify(() => logger.d(captureAny())).captured
          .map((m) => m.toString())
          .toList();

      final request = logs.firstWhere((m) => m.startsWith('→ POST /auth/login'));
      expect(request, contains('"email":"a@b.com"'));
      expect(request, contains('"password":"***"'));
      expect(request, isNot(contains('hunter2')));

      final response = logs.firstWhere(
        (m) => m.startsWith('← 200 POST /auth/login'),
      );
      expect(response, contains('"userId":"u1"'));
      expect(response, contains('"accessToken":"***"'));
      expect(response, isNot(contains('secret-access')));
    });

    test('redacts Authorization header', () async {
      adapter.onGet(
        '/secure',
        (server) => server.reply(200, {'ok': true}),
      );

      await dio.get<dynamic>(
        '/secure',
        options: Options(headers: {'Authorization': 'Bearer secret-token'}),
      );

      final requestMessages = verify(() => logger.d(captureAny())).captured
          .map((m) => m.toString())
          .where((m) => m.startsWith('→ '))
          .toList();

      expect(requestMessages, hasLength(1));
      expect(requestMessages.single, contains('Authorization: ***'));
      expect(requestMessages.single, isNot(contains('secret-token')));
    });

    test('includes query string in path', () async {
      adapter.onGet(
        '/items',
        (server) => server.reply(200, []),
        queryParameters: {'page': '1'},
      );

      await dio.get<dynamic>('/items', queryParameters: {'page': '1'});

      final messages = verify(() => logger.d(captureAny())).captured
          .map((m) => m.toString())
          .toList();
      expect(messages.any((m) => m.contains('/items?page=1')), isTrue);
    });

    test('logs error response body at error level', () async {
      adapter.onGet(
        '/boom',
        (server) => server.reply(500, {'message': 'fail'}),
      );

      await expectLater(
        dio.get<dynamic>('/boom'),
        throwsA(isA<DioException>()),
      );

      final message = verify(
        () => logger.e(
          captureAny(),
          error: any(named: 'error'),
          stackTrace: any(named: 'stackTrace'),
        ),
      ).captured.single.toString();

      expect(message, startsWith('✕ 500 GET /boom'));
      expect(message, contains('"message":"fail"'));
    });

    test('logs null body for requests without data', () async {
      adapter.onGet(
        '/health',
        (server) => server.reply(200, {'status': 'ok'}),
      );

      await dio.get<dynamic>('/health');

      final request = verify(() => logger.d(captureAny())).captured
          .map((m) => m.toString())
          .firstWhere((m) => m.startsWith('→ GET /health'));
      expect(request, contains('body=null'));
    });
  });
}
