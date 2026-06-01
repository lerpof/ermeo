import 'package:beneesse_api/beneesse_api.dart' as api;

import '../models/exercise_summary.dart';

class ExerciseConverter {
  const ExerciseConverter();

  ExerciseSummary toSummary(api.Exercise exercise) {
    return ExerciseSummary(
      id: exercise.id,
      name: exercise.name,
      bodyPart: exercise.bodyPart,
      equipment: exercise.equipment,
      target: exercise.target,
    );
  }
}
