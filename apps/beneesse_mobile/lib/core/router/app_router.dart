import 'package:auto_route/auto_route.dart';
import 'package:beneesse_mobile/core/session/session_service.dart';

part 'app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Page,Route')
class AppRouter extends RootStackRouter {
  AppRouter({required this._sessionService});

  final AppSessionService _sessionService;

  @override
  RouteType get defaultRouteType => const RouteType.material();

  @override
  List<AutoRoute> get routes => [];
}
