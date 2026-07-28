import 'package:auto_route/auto_route.dart';

import 'package:ermeo_mobile/core/router/guards/auth_guard.dart';
import 'package:ermeo_mobile/core/session/session_service.dart';
import 'package:ermeo_mobile/features/auth/presentation/pages/auth_shell_page.dart';
import 'package:ermeo_mobile/features/auth/presentation/pages/login_page.dart';
import 'package:ermeo_mobile/features/auth/presentation/pages/register_page.dart';
import 'package:ermeo_mobile/features/auth/presentation/pages/role_selection_page.dart';
import 'package:ermeo_mobile/features/home/presentation/pages/home_page.dart';

part 'app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Page,Route')
class AppRouter extends RootStackRouter {
  AppRouter({required this.sessionService});

  final AppSessionService sessionService;

  @override
  RouteType get defaultRouteType => const RouteType.material();

  @override
  late final List<AutoRouteGuard> guards = [AuthGuard(sessionService)];

  @override
  List<AutoRoute> get routes => [
    AutoRoute(
      path: '/home',
      page: HomeRoute.page,
      initial: true,
    ),
    AutoRoute(
      path: '/onboarding/role',
      page: RoleSelectionRoute.page,
    ),
    AutoRoute(
      path: '/auth',
      page: AuthShellRoute.page,
      children: [
        AutoRoute(path: 'login', page: LoginRoute.page, initial: true),
        AutoRoute(path: 'register', page: RegisterRoute.page),
      ],
    ),
  ];
}
