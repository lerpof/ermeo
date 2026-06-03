import 'package:beneesse_mobile/core/router/app_router.dart';
import 'package:beneesse_mobile/core/session/session_service.dart';
import 'package:beneesse_mobile/features/auth/data/auth_repository.dart';
import 'package:beneesse_mobile/features/exercises/data/exercise_repository.dart';
import 'package:beneesse_secure_storage/beneesse_secure_storage.dart';
import 'package:beneesse_ui/beneesse_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/fakes.dart';

class _InMemoryTokenStorage implements TokenSecureStorage {
  SessionTokens? _tokens;

  @override
  Future<void> clearTokens() async => _tokens = null;

  @override
  Future<SessionTokens?> readTokens() async => _tokens;

  @override
  Future<void> writeTokens(SessionTokens tokens) async => _tokens = tokens;
}

void main() {
  group('AppRouter', () {
    late SessionServiceImpl sessionService;

    setUp(() {
      sessionService = SessionServiceImpl(
        tokenStorage: _InMemoryTokenStorage(),
        baseUrl: 'https://api.test',
      );
    });

    testWidgets('redirects unauthenticated users to login', (tester) async {
      final appRouter = AppRouter(
        sessionService: sessionService,
      );

      await tester.pumpWidget(
        MultiRepositoryProvider(
          providers: [
            RepositoryProvider<AuthRepository>(
              create: (_) => FakeAuthRepository(),
            ),
            RepositoryProvider<ExerciseRepository>(
              create: (_) => FakeExerciseRepository(),
            ),
          ],
          child: MaterialApp.router(
            theme: BeTheme.light,
            routerConfig: appRouter.config(
              reevaluateListenable: sessionService.listenable,
              navigatorObservers: () => const [],
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(appRouter.currentPath, '/login');
    });

    testWidgets('redirects authenticated users away from login', (tester) async {
      await sessionService.setSession(
        accessToken: 'access',
        refreshToken: 'refresh',
      );

      final appRouter = AppRouter(
        sessionService: sessionService,
      );

      await tester.pumpWidget(
        MultiRepositoryProvider(
          providers: [
            RepositoryProvider<AuthRepository>(
              create: (_) => FakeAuthRepository(),
            ),
            RepositoryProvider<ExerciseRepository>(
              create: (_) => FakeExerciseRepository(),
            ),
          ],
          child: MaterialApp.router(
            theme: BeTheme.light,
            routerConfig: appRouter.config(
              reevaluateListenable: sessionService.listenable,
              navigatorObservers: () => const [],
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      appRouter.pushPath('/login');
      await tester.pumpAndSettle();

      expect(appRouter.currentPath, '/');
    });
  });
}
