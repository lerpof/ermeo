import 'package:beneesse_api/beneesse_api.dart' as api;

import '../models/workout_summary.dart';

class WorkoutConverter {
  const WorkoutConverter();

  WorkoutSummary toSummary(api.Workout workout) {
    return WorkoutSummary(
      id: workout.id,
      name: workout.name,
      description: workout.description,
    );
  }
}
