import 'package:auto_route/auto_route.dart';
import 'package:ermeo_mobile/features/auth/presentation/pages/auth_shell_page.dart';
import 'package:ermeo_mobile/features/auth/presentation/pages/login_page.dart';
import 'package:ermeo_mobile/features/auth/presentation/pages/register_page.dart';

part 'app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Page,Route')
class AppRouter extends RootStackRouter {
  @override
  RouteType get defaultRouteType => const RouteType.material();

  @override
  List<AutoRoute> get routes => [
        AutoRoute(
          path: '/auth',
          page: AuthShellRoute.page,
          initial: true,
          children: [
            AutoRoute(path: 'login', page: LoginRoute.page, initial: true),
            AutoRoute(path: 'register', page: RegisterRoute.page),
          ],
        ),
      ];
}
