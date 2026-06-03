import 'package:beneesse_api/beneesse_api.dart';
import 'package:beneesse_mobile/features/auth/data/auth_repository.dart';
import 'package:beneesse_mobile/features/exercises/data/exercise_repository.dart';
import 'package:beneesse_mobile/features/exercises/models/exercise_summary.dart';

class FakeAuthRepository implements AuthRepository {
  @override
  Future<void> login({required String email, required String password}) async {}

  @override
  Future<void> register({
    required String email,
    required String password,
    required String displayName,
    required UserRole role,
  }) async {}
}

class FakeExerciseRepository implements ExerciseRepository {
  @override
  Future<List<ExerciseSummary>> listExercises({
    int limit = 50,
    int offset = 0,
  }) async {
    return const [];
  }
}
