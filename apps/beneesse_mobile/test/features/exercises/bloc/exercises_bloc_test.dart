import 'package:beneesse_api/beneesse_api.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:beneesse_mobile/features/exercises/bloc/exercises_bloc.dart';
import 'package:beneesse_mobile/features/exercises/bloc/exercises_event.dart';
import 'package:beneesse_mobile/features/exercises/bloc/exercises_state.dart';
import 'package:beneesse_mobile/features/exercises/data/exercise_repository.dart';
import 'package:beneesse_mobile/features/exercises/models/exercise_summary.dart';

class _MockExerciseRepository extends Mock implements ExerciseRepository {}

void main() {
  late _MockExerciseRepository exerciseRepository;

  setUp(() {
    exerciseRepository = _MockExerciseRepository();
  });

  ExercisesBloc buildBloc() =>
      ExercisesBloc(exerciseRepository: exerciseRepository);

  group('ExercisesBloc', () {
    blocTest<ExercisesBloc, ExercisesState>(
      'loads and formats exercises',
      build: buildBloc,
      setUp: () {
        when(() => exerciseRepository.listExercises()).thenAnswer(
          (_) async => const [
            ExerciseSummary(
              id: '0001',
              name: 'Bench Press',
              bodyPart: 'chest',
              equipment: 'barbell',
              target: 'pectorals',
            ),
          ],
        );
      },
      act: (bloc) => bloc.add(const ExercisesLoadRequested()),
      expect: () => [
        isA<ExercisesState>().having((s) => s.status, 'status', ExercisesStatus.loading),
        isA<ExercisesState>()
            .having((s) => s.status, 'status', ExercisesStatus.loaded)
            .having((s) => s.items, 'items', hasLength(1))
            .having((s) => s.items.first.title, 'title', 'Bench Press')
            .having(
              (s) => s.items.first.subtitle,
              'subtitle',
              'Chest · barbell · pectorals',
            ),
      ],
    );

    blocTest<ExercisesBloc, ExercisesState>(
      'handles empty body part capitalization',
      build: buildBloc,
      setUp: () {
        when(() => exerciseRepository.listExercises()).thenAnswer(
          (_) async => const [
            ExerciseSummary(
              id: '0002',
              name: 'Plank',
              bodyPart: '',
              equipment: 'body weight',
              target: 'abs',
            ),
          ],
        );
      },
      act: (bloc) => bloc.add(const ExercisesLoadRequested()),
      expect: () => [
        isA<ExercisesState>().having((s) => s.status, 'status', ExercisesStatus.loading),
        isA<ExercisesState>().having(
          (s) => s.items.first.subtitle,
          'subtitle',
          ' · body weight · abs',
        ),
      ],
    );

    blocTest<ExercisesBloc, ExercisesState>(
      'maps ApiException to failure',
      build: buildBloc,
      setUp: () {
        when(() => exerciseRepository.listExercises()).thenThrow(
          const ApiException(
            statusCode: 401,
            code: 'unauthorized',
            message: 'Unauthorized',
          ),
        );
      },
      act: (bloc) => bloc.add(const ExercisesLoadRequested()),
      expect: () => [
        isA<ExercisesState>().having((s) => s.status, 'status', ExercisesStatus.loading),
        isA<ExercisesState>()
            .having((s) => s.status, 'status', ExercisesStatus.failure)
            .having((s) => s.errorMessage, 'error', 'Unauthorized'),
      ],
    );

    blocTest<ExercisesBloc, ExercisesState>(
      'maps unknown errors to generic message',
      build: buildBloc,
      setUp: () {
        when(() => exerciseRepository.listExercises()).thenThrow(Exception('x'));
      },
      act: (bloc) => bloc.add(const ExercisesLoadRequested()),
      expect: () => [
        isA<ExercisesState>().having((s) => s.status, 'status', ExercisesStatus.loading),
        isA<ExercisesState>().having(
          (s) => s.errorMessage,
          'error',
          'Unable to load exercises. Please try again.',
        ),
      ],
    );
  });
}
