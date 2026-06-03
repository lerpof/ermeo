import 'package:beneesse_mobile/core/session/session_service.dart';
import 'package:beneesse_mobile/core/router/app_router.dart';
import 'package:beneesse_secure_storage/beneesse_secure_storage.dart';
import 'package:beneesse_mobile/main.dart';
import 'package:flutter_test/flutter_test.dart';

import 'helpers/fakes.dart';

class _InMemoryTokenStorage implements TokenSecureStorage {
  @override
  Future<void> clearTokens() async {}

  @override
  Future<SessionTokens?> readTokens() async => null;

  @override
  Future<void> writeTokens(SessionTokens tokens) async {}
}

void main() {
  testWidgets('shows login when unauthenticated', (tester) async {
    final sessionService = SessionServiceImpl(
      tokenStorage: _InMemoryTokenStorage(),
    );
    await sessionService.restore();

    final appRouter = AppRouter(
      sessionService: sessionService,
    );

    await tester.pumpWidget(
      BeneesseMobileApp(
        appRouter: appRouter,
        sessionService: sessionService,
        authRepository: FakeAuthRepository(),
        exerciseRepository: FakeExerciseRepository(),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Sign in'), findsWidgets);
  });
}
