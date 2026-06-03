import 'package:beneesse_api/beneesse_api.dart';
import 'package:beneesse_secure_storage/beneesse_secure_storage.dart';
import 'package:beneesse_ui/beneesse_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/config/app_config.dart';
import 'core/router/app_router.dart';
import 'core/session/session_service.dart';
import 'features/auth/data/auth_repository.dart';
import 'features/exercises/data/exercise_repository.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final tokenStorage = FlutterTokenSecureStorage();
  final sessionService = AppSessionService(tokenStorage: tokenStorage);
  await sessionService.restore();

  final apiClient = BeneesseApiClient(
    baseUrl: AppConfig.apiBaseUrl,
    sessionService: sessionService,
  );

  final authRepository = AuthRepositoryImpl(
    apiClient: apiClient,
    sessionService: sessionService,
  );
  final exerciseRepository = ExerciseRepositoryImpl(apiClient: apiClient);
  final appRouter = AppRouter(sessionService: sessionService);

  runApp(
    BeneesseMobileApp(
      appRouter: appRouter,
      sessionService: sessionService,
      authRepository: authRepository,
      exerciseRepository: exerciseRepository,
    ),
  );
}

class BeneesseMobileApp extends StatelessWidget {
  const BeneesseMobileApp({
    required this.appRouter,
    required this.sessionService,
    required this.authRepository,
    required this.exerciseRepository,
    super.key,
  });

  final AppRouter appRouter;
  final AppSessionService sessionService;
  final AuthRepository authRepository;
  final ExerciseRepository exerciseRepository;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<AuthRepository>.value(value: authRepository),
        RepositoryProvider<ExerciseRepository>.value(value: exerciseRepository),
      ],
      child: MaterialApp.router(
        theme: BeTheme.light,
        darkTheme: BeTheme.dark,
        themeMode: ThemeMode.system,
        routerConfig: appRouter.config(
          reevaluateListenable: sessionService.listenable,
        ),
      ),
    );
  }
}
