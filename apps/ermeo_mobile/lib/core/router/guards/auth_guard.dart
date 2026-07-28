import 'package:auto_route/auto_route.dart';

import 'package:ermeo_mobile/core/router/app_router.dart';
import 'package:ermeo_mobile/core/session/session_service.dart';

/// Redirects based on authentication and onboarding (role) status.
class AuthGuard extends AutoRouteGuard {
  const AuthGuard(this._sessionService);

  final AppSessionService _sessionService;

  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    final isAuthenticated = _sessionService.isAuthenticated;
    final isAuthRoute = _isAuthRoute(resolver.route.name);
    final isRoleSelection = resolver.route.name == RoleSelectionRoute.name;
    final needsOnboarding = _sessionService.needsOnboarding;
    final profileReady = !_sessionService.isAuthenticated ||
        _sessionService.isProfileLoaded;

    if (!isAuthenticated && !isAuthRoute) {
      resolver.redirectUntil(
        const AuthShellRoute(children: [LoginRoute()]),
        replace: true,
      );
      return;
    }

    if (isAuthenticated && !profileReady) {
      resolver.next();
      return;
    }

    if (isAuthenticated && needsOnboarding && !isRoleSelection) {
      resolver.redirectUntil(const RoleSelectionRoute(), replace: true);
      return;
    }

    if (isAuthenticated && !needsOnboarding && (isAuthRoute || isRoleSelection)) {
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
