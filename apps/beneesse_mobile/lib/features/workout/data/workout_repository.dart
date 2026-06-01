import 'package:beneesse_api/beneesse_api.dart';

import '../../../core/di/service_locator.dart';
import '../models/workout_summary.dart';
import 'workout_converter.dart';

abstract class WorkoutRepository {
  Future<List<WorkoutSummary>> listWorkouts();
  Future<WorkoutSummary> getWorkout(String id);
}

class WorkoutRepositoryImpl implements WorkoutRepository {
  WorkoutRepositoryImpl({
    BeneesseApiClient? apiClient,
    WorkoutConverter? converter,
  })  : _api = apiClient ?? ServiceLocator.instance.apiClient,
        _converter = converter ?? const WorkoutConverter();

  final BeneesseApiClient _api;
  final WorkoutConverter _converter;

  @override
  Future<List<WorkoutSummary>> listWorkouts() async {
    final response = await _api.run(
      () => _api.workouts.listWorkouts().then((r) => r.data!),
    );
    return response.items.map(_converter.toSummary).toList();
  }

  @override
  Future<WorkoutSummary> getWorkout(String id) async {
    final response = await _api.run(
      () => _api.workouts.getWorkout(id).then((r) => r.data!),
    );
    return _converter.toSummary(response);
  }
}
