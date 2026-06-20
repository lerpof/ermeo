// coverage:ignore-file
import 'package:dio/dio.dart';

import 'api/assignments_api.dart';
import 'api/athletes_api.dart';
import 'api/auth_api.dart';
import 'api/exercises_api.dart';
import 'api/health_api.dart';
import 'api/instructors_api.dart';
import 'api/sessions_api.dart';
import 'api/workouts_api.dart';

/// Entry point for generated API classes.
class ErmeoApiClient {
  ErmeoApiClient(this.dio, {String? basePath}) {
    if (basePath != null) {
      dio.options.baseUrl = basePath;
    }
  }

  final Dio dio;

  late final HealthApi health = HealthApi(dio);
  late final AuthApi auth = AuthApi(dio);
  late final ExercisesApi exercises = ExercisesApi(dio);
  late final WorkoutsApi workouts = WorkoutsApi(dio);
  late final SessionsApi sessions = SessionsApi(dio);
  late final InstructorsApi instructors = InstructorsApi(dio);
  late final AssignmentsApi assignments = AssignmentsApi(dio);
  late final AthletesApi athletes = AthletesApi(dio);
}
