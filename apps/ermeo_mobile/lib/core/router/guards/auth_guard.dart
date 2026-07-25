import 'package:auto_route/auto_route.dart';

import 'package:ermeo_mobile/core/router/app_router.dart';
import 'package:ermeo_mobile/core/session/session_service.dart';

/// Redirects unauthenticated users to login and authenticated users away from auth.
class AuthGuard extends AutoRouteGuard {
  const AuthGuard(this._sessionService);

  final AppSessionService _sessionService;

  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    final isAuthenticated = _sessionService.isAuthenticated;
    final isAuthRoute = _isAuthRoute(resolver.route.name);

    if (!isAuthenticated && !isAuthRoute) {
      resolver.redirectUntil(
        const AuthShellRoute(children: [LoginRoute()]),
        replace: true,
      );
      return;
    }

    if (isAuthenticated && isAuthRoute) {
      resolver.redirectUntil(const HomeRoute(), replace: true);
      return;
    }

    resolver.next();
  }

  bool _isAuthRoute(String routeName) {
    return routeName == AuthShellRoute.name ||
        routeName == LoginRoute.name ||
        routeName == RegisterRoute.name;
  }
}
