import 'package:beneesse_api/beneesse_api.dart';

import '../models/exercise_summary.dart';
import 'exercise_converter.dart';

abstract class ExerciseRepository {
  Future<List<ExerciseSummary>> listExercises({
    int limit = 50,
    int offset = 0,
  });
}

class ExerciseRepositoryImpl implements ExerciseRepository {
  ExerciseRepositoryImpl({
    required BeneesseApiClient apiClient,
    ExerciseConverter? converter,
  })  : _api = apiClient,
        _converter = converter ?? const ExerciseConverter();

  final BeneesseApiClient _api;
  final ExerciseConverter _converter;

  @override
  Future<List<ExerciseSummary>> listExercises({
    int limit = 50,
    int offset = 0,
  }) async {
    final response = await _api.run(
      () => _api.exercises
          .listExercises(limit: limit, offset: offset)
          .then((r) => r.data!),
    );
    return response.items.map(_converter.toSummary).toList();
  }
}
