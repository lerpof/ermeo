import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../features/auth/data/auth_repository.dart';
import '../../features/auth/presentation/pages/auth_page.dart';
import '../../features/exercises/data/exercise_repository.dart';
import '../../features/exercises/presentation/pages/exercises_page.dart';
import '../di/service_locator.dart';

class AppRouter {
  AppRouter({
    required AuthRepository authRepository,
    required ExerciseRepository exerciseRepository,
    ServiceLocator? serviceLocator,
  })  : _serviceLocator = serviceLocator ?? ServiceLocator.instance,
        _authRepository = authRepository,
        _exerciseRepository = exerciseRepository;

  final ServiceLocator _serviceLocator;
  final AuthRepository _authRepository;
  final ExerciseRepository _exerciseRepository;

  late final GoRouter router = GoRouter(
    initialLocation: '/',
    refreshListenable: _serviceLocator.sessionNotifier,
    redirect: _redirect,
    routes: [
      GoRoute(
        path: '/login',
        builder: (context, state) => AuthPage(authRepository: _authRepository),
      ),
      GoRoute(
        path: '/',
        builder: (context, state) =>
            ExercisesPage(exerciseRepository: _exerciseRepository),
      ),
    ],
  );

  String? _redirect(BuildContext context, GoRouterState state) {
    final isAuthenticated = _serviceLocator.isAuthenticated;
    final loggingIn = state.matchedLocation == '/login';

    if (!isAuthenticated && !loggingIn) {
      return '/login';
    }
    if (isAuthenticated && loggingIn) {
      return '/';
    }
    return null;
  }
}
