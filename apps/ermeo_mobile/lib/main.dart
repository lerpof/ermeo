import 'package:ermeo_api/ermeo_api.dart';
import 'package:ermeo_l10n/ermeo_l10n.dart';
import 'package:ermeo_secure_storage/ermeo_secure_storage.dart';
import 'package:ermeo_ui/ermeo_ui.dart';
import 'package:flutter/material.dart';

import 'package:ermeo_mobile/core/config/app_config.dart';
import 'package:ermeo_mobile/core/router/app_router.dart';
import 'package:ermeo_mobile/core/session/session_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final tokenStorage = InMemoryTokenSecureStorage();
  final sessionService = AppSessionService(tokenStorage: tokenStorage);
  await sessionService.restore();

  final apiClient = ErmeoApiClient(
    baseUrl: AppConfig.apiBaseUrl,
    sessionService: sessionService,
  );

  final appRouter = AppRouter();

  runApp(
    ErmeoMobileApp(
      appRouter: appRouter,
      sessionService: sessionService,
      apiClient: apiClient,
    ),
  );
}

class ErmeoMobileApp extends StatelessWidget {
  const ErmeoMobileApp({
    required this.appRouter,
    required this.sessionService,
    required this.apiClient,
    super.key,
  });

  final AppRouter appRouter;
  final AppSessionService sessionService;

  /// Wired with [sessionService] for proactive token refresh; pass to repositories.
  final ErmeoApiClient apiClient;

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      localizationsDelegates: erLocalizationDelegates,
      supportedLocales: ErLocalizations.supportedLocales,
      theme: ErTheme.light,
      darkTheme: ErTheme.dark,
      themeMode: ThemeMode.system,
      routerConfig: appRouter.config(
        reevaluateListenable: sessionService.listenable,
      ),
    );
  }
}
