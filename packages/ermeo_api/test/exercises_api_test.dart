import 'package:ermeo_api/ermeo_api.dart';
import 'package:dio/dio.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:test/test.dart';

void main() {
  group('ExercisesApi', () {
    late Dio dio;
    late DioAdapter adapter;
    late ErmeoApiClient client;

    setUp(() {
      dio = Dio(BaseOptions(baseUrl: 'https://api.test'));
      adapter = DioAdapter(dio: dio);
      client = ErmeoApiClient(baseUrl: 'https://api.test', dio: dio);
    });

    test('listExercises returns catalog page', () async {
      adapter.onGet(
        '/exercises',
        (server) => server.reply(200, {
          'items': [
            {
              'id': '0001',
              'name': 'Bench Press',
              'bodyPart': 'chest',
              'equipment': 'barbell',
              'target': 'pectorals',
            },
          ],
          'total': 1,
          'limit': 50,
          'offset': 0,
        }),
        queryParameters: {'limit': 10},
      );

      final response = await client.run(
        () => client.exercises.listExercises(limit: 10).then((r) => r.data!),
      );

      expect(response.items, hasLength(1));
      expect(response.items.first.name, 'Bench Press');
      expect(response.total, 1);
    });

    test('getExercise returns one exercise', () async {
      adapter.onGet(
        '/exercises/0001',
        (server) => server.reply(200, {
          'id': '0001',
          'name': 'Bench Press',
          'bodyPart': 'chest',
          'equipment': 'barbell',
          'target': 'pectorals',
        }),
      );

      final exercise = await client.run(
        () => client.exercises.getExercise('0001').then((r) => r.data!),
      );

      expect(exercise.id, '0001');
      expect(exercise.target, 'pectorals');
    });
  });
}
