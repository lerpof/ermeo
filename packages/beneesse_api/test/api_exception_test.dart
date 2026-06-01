import 'package:beneesse_api/beneesse_api.dart';
import 'package:dio/dio.dart';
import 'package:test/test.dart';

void main() {
  group('mapDioException', () {
    test('maps ApiError JSON body', () {
      final error = DioException(
        requestOptions: RequestOptions(path: '/workouts'),
        response: Response(
          requestOptions: RequestOptions(path: '/workouts'),
          statusCode: 400,
          data: {
            'code': 'validation_error',
            'message': 'Invalid payload',
            'details': {'field': 'name'},
          },
        ),
        type: DioExceptionType.badResponse,
      );

      final mapped = mapDioException(error);
      expect(mapped.statusCode, 400);
      expect(mapped.code, 'validation_error');
      expect(mapped.message, 'Invalid payload');
      expect(mapped.details, {'field': 'name'});
    });

    test('maps timeout errors', () {
      final error = DioException(
        requestOptions: RequestOptions(path: '/health'),
        type: DioExceptionType.receiveTimeout,
      );

      final mapped = mapDioException(error);
      expect(mapped.code, 'timeout');
      expect(mapped.message, 'Request timed out');
    });

    test('maps connection errors', () {
      final error = DioException(
        requestOptions: RequestOptions(path: '/health'),
        type: DioExceptionType.connectionError,
      );

      final mapped = mapDioException(error);
      expect(mapped.code, 'connection_error');
    });

    test('maps generic http errors', () {
      final error = DioException(
        requestOptions: RequestOptions(path: '/health'),
        message: 'Server exploded',
        type: DioExceptionType.unknown,
      );

      final mapped = mapDioException(error);
      expect(mapped.code, 'http_error');
      expect(mapped.message, 'Server exploded');
    });

    test('falls back when error body is not ApiError shape', () {
      final error = DioException(
        requestOptions: RequestOptions(path: '/health'),
        response: Response(
          requestOptions: RequestOptions(path: '/health'),
          statusCode: 500,
          data: 'plain text',
        ),
        type: DioExceptionType.badResponse,
      );

      final mapped = mapDioException(error);
      expect(mapped.code, 'http_error');
      expect(mapped.statusCode, 500);
    });
  });

  group('ApiException', () {
    test('toString includes code and message', () {
      const ex = ApiException(
        statusCode: 404,
        code: 'not_found',
        message: 'Missing',
      );
      expect(ex.toString(), contains('not_found'));
      expect(ex.toString(), contains('Missing'));
    });
  });
}
