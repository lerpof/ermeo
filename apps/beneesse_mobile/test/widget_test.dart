import 'package:beneesse_mobile/core/di/service_locator.dart';
import 'package:beneesse_mobile/core/router/app_router.dart';
import 'package:beneesse_mobile/features/auth/data/auth_repository.dart';
import 'package:beneesse_mobile/features/exercises/data/exercise_repository.dart';
import 'package:beneesse_mobile/main.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class _MockAuthRepository extends Mock implements AuthRepository {}

class _MockExerciseRepository extends Mock implements ExerciseRepository {}

void main() {
  testWidgets('shows login when unauthenticated', (tester) async {
    ServiceLocator.instance.init(baseUrl: 'https://api.test');

    final appRouter = AppRouter(
      authRepository: _MockAuthRepository(),
      exerciseRepository: _MockExerciseRepository(),
    );

    await tester.pumpWidget(BeneesseMobileApp(router: appRouter.router));
    await tester.pumpAndSettle();

    expect(find.text('Sign in'), findsWidgets);
  });
}
