import 'package:beneesse_api/beneesse_api.dart';
import 'package:beneesse_mobile/features/exercises/data/exercise_repository.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class _MockBeneesseApiClient extends Mock implements BeneesseApiClient {}

class _MockExercisesApi extends Mock implements ExercisesApi {}

void main() {
  group('ExerciseRepositoryImpl', () {
    late _MockBeneesseApiClient apiClient;
    late _MockExercisesApi exercisesApi;
    late ExerciseRepositoryImpl repository;

    setUp(() {
      apiClient = _MockBeneesseApiClient();
      exercisesApi = _MockExercisesApi();
      when(() => apiClient.exercises).thenReturn(exercisesApi);
      when(() => apiClient.run<ExerciseListResponse>(any())).thenAnswer(
        (invocation) async {
          final call = invocation.positionalArguments[0]
              as Future<ExerciseListResponse> Function();
          return call();
        },
      );
      repository = ExerciseRepositoryImpl(apiClient: apiClient);
    });

    test('listExercises returns summaries', () async {
      when(() => exercisesApi.listExercises(limit: 50, offset: 0)).thenAnswer(
        (_) async => Response(
          data: ExerciseListResponse(
            items: [
              Exercise(
                id: '0001',
                name: 'Bench Press',
                bodyPart: 'chest',
                equipment: 'barbell',
                target: 'pectorals',
              ),
            ],
            total: 1,
            limit: 50,
            offset: 0,
          ),
          requestOptions: RequestOptions(path: '/exercises'),
        ),
      );

      final items = await repository.listExercises();

      expect(items, hasLength(1));
      expect(items.first.name, 'Bench Press');
    });

    test('listExercises propagates ApiException', () async {
      when(() => apiClient.run<ExerciseListResponse>(any())).thenThrow(
        const ApiException(
          statusCode: 401,
          code: 'unauthorized',
          message: 'Unauthorized',
        ),
      );

      await expectLater(
        repository.listExercises(),
        throwsA(isA<ApiException>()),
      );
    });
  });
}
