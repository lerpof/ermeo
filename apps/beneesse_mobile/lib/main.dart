import 'package:beneesse_ui/beneesse_ui.dart';
import 'package:flutter/material.dart';

import 'core/config/app_config.dart';
import 'core/di/service_locator.dart';
import 'features/instructor/data/instructor_repository.dart';
import 'features/workout/data/workout_repository.dart';

void main() {
  ServiceLocator.instance.init(baseUrl: AppConfig.apiBaseUrl);

  // Repository stubs wired for DI; inject into BLoCs as features grow.
  WorkoutRepositoryImpl();
  InstructorRepositoryImpl();

  runApp(const BeneesseMobileApp());
}

class BeneesseMobileApp extends StatelessWidget {
  const BeneesseMobileApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: BeTheme.light,
      darkTheme: BeTheme.dark,
      themeMode: ThemeMode.system,
      home: const Scaffold(
        body: Center(
          child: Text('beneesse_mobile'),
        ),
      ),
    );
  }
}
