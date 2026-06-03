import 'package:auto_route/auto_route.dart';

import '../session/session_service.dart';
import 'app_router.dart';

class AuthGuard extends AutoRouteGuard {
  AuthGuard(this._sessionService);

  final AppSessionService _sessionService;

  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    if (_sessionService.isAuthenticated) {
      resolver.next();
      return;
    }

    resolver.redirectUntil(const AuthRoute());
    resolver.next(false);
  }
}

class GuestGuard extends AutoRouteGuard {
  GuestGuard(this._sessionService);

  final AppSessionService _sessionService;

  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    if (!_sessionService.isAuthenticated) {
      resolver.next();
      return;
    }

    resolver.redirectUntil(const ExercisesRoute());
    resolver.next(false);
  }
}
