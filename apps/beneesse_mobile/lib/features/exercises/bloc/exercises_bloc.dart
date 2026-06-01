import 'package:beneesse_api/beneesse_api.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/exercise_repository.dart';
import '../models/exercise_summary.dart';
import 'exercises_event.dart';
import 'exercises_state.dart';

class ExercisesBloc extends Bloc<ExercisesEvent, ExercisesState> {
  ExercisesBloc({required ExerciseRepository exerciseRepository})
      : _exerciseRepository = exerciseRepository,
        super(const ExercisesState()) {
    on<ExercisesLoadRequested>(_onLoadRequested);
  }

  final ExerciseRepository _exerciseRepository;

  Future<void> _onLoadRequested(
    ExercisesLoadRequested event,
    Emitter<ExercisesState> emit,
  ) async {
    emit(state.copyWith(status: ExercisesStatus.loading, clearError: true));

    try {
      final summaries = await _exerciseRepository.listExercises();
      emit(
        state.copyWith(
          status: ExercisesStatus.loaded,
          items: summaries.map(_toListItem).toList(),
          clearError: true,
        ),
      );
    } on ApiException catch (error) {
      emit(
        state.copyWith(
          status: ExercisesStatus.failure,
          errorMessage: error.message,
        ),
      );
    } on Object {
      emit(
        state.copyWith(
          status: ExercisesStatus.failure,
          errorMessage: 'Unable to load exercises. Please try again.',
        ),
      );
    }
  }

  ExerciseListItem _toListItem(ExerciseSummary summary) {
    final subtitle = _formatSubtitle(
      bodyPart: summary.bodyPart,
      equipment: summary.equipment,
      target: summary.target,
    );
    return ExerciseListItem(title: summary.name, subtitle: subtitle);
  }

  String _formatSubtitle({
    required String bodyPart,
    required String equipment,
    required String target,
  }) {
    return '${_capitalize(bodyPart)} · $equipment · $target';
  }

  String _capitalize(String value) {
    if (value.isEmpty) {
      return value;
    }
    return '${value[0].toUpperCase()}${value.substring(1)}';
  }
}
