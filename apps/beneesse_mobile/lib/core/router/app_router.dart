import 'package:auto_route/auto_route.dart';

import '../../features/auth/presentation/pages/auth_page.dart';
import '../../features/exercises/presentation/pages/exercises_page.dart';
import '../session/session_service.dart';
import 'auth_guard.dart';

part 'app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Page,Route')
class AppRouter extends RootStackRouter {
  AppRouter({required this._sessionService});

  final AppSessionService _sessionService;

  @override
  RouteType get defaultRouteType => const RouteType.material();

  @override
  List<AutoRoute> get routes => [
    AutoRoute(
      page: AuthRoute.page,
      path: '/login',
      guards: [GuestGuard(_sessionService)],
    ),
    AutoRoute(
      page: ExercisesRoute.page,
      path: '/',
      initial: true,
      guards: [AuthGuard(_sessionService)],
    ),
  ];
}
