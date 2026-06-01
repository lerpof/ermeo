import 'package:beneesse_ui/beneesse_ui.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'core/config/app_config.dart';
import 'core/di/service_locator.dart';
import 'core/router/app_router.dart';
import 'features/auth/data/auth_repository.dart';
import 'features/exercises/data/exercise_repository.dart';

void main() {
  ServiceLocator.instance.init(baseUrl: AppConfig.apiBaseUrl);

  final authRepository = AuthRepositoryImpl();
  final exerciseRepository = ExerciseRepositoryImpl();
  final appRouter = AppRouter(
    authRepository: authRepository,
    exerciseRepository: exerciseRepository,
  );

  runApp(BeneesseMobileApp(router: appRouter.router));
}

class BeneesseMobileApp extends StatelessWidget {
  const BeneesseMobileApp({required this.router, super.key});

  final GoRouter router;

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: BeTheme.light,
      darkTheme: BeTheme.dark,
      themeMode: ThemeMode.system,
      routerConfig: router,
    );
  }
}
