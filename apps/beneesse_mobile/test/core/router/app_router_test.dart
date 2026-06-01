import 'package:beneesse_mobile/core/di/service_locator.dart';
import 'package:beneesse_mobile/core/router/app_router.dart';
import 'package:beneesse_mobile/features/auth/data/auth_repository.dart';
import 'package:beneesse_mobile/features/exercises/data/exercise_repository.dart';
import 'package:beneesse_ui/beneesse_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class _MockAuthRepository extends Mock implements AuthRepository {}

class _MockExerciseRepository extends Mock implements ExerciseRepository {}

void main() {
  group('AppRouter', () {
    late _MockAuthRepository authRepository;
    late _MockExerciseRepository exerciseRepository;

    setUp(() {
      ServiceLocator.instance.init(baseUrl: 'https://api.test');
      authRepository = _MockAuthRepository();
      exerciseRepository = _MockExerciseRepository();
    });

    tearDown(ServiceLocator.instance.clearSession);

    testWidgets('redirects unauthenticated users to login', (tester) async {
      final appRouter = AppRouter(
        authRepository: authRepository,
        exerciseRepository: exerciseRepository,
      );

      await tester.pumpWidget(
        MaterialApp.router(
          theme: BeTheme.light,
          routerConfig: appRouter.router,
        ),
      );
      await tester.pumpAndSettle();

      expect(appRouter.router.state.uri.path, '/login');
    });

    testWidgets('redirects authenticated users away from login', (tester) async {
      ServiceLocator.instance.setSession(
        accessToken: 'access',
        refreshToken: 'refresh',
      );

      final appRouter = AppRouter(
        authRepository: authRepository,
        exerciseRepository: exerciseRepository,
      );

      await tester.pumpWidget(
        MaterialApp.router(
          theme: BeTheme.light,
          routerConfig: appRouter.router,
        ),
      );
      await tester.pumpAndSettle();

      appRouter.router.go('/login');
      await tester.pumpAndSettle();

      expect(appRouter.router.state.uri.path, '/');
    });
  });
}
