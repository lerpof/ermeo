import 'package:beneesse_api/beneesse_api.dart';
import 'package:beneesse_l10n/beneesse_l10n.dart';
import 'package:beneesse_secure_storage/beneesse_secure_storage.dart';
import 'package:beneesse_ui/beneesse_ui.dart';
import 'package:flutter/material.dart';

import 'core/config/app_config.dart';
import 'core/router/app_router.dart';
import 'core/session/session_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final tokenStorage = InMemoryTokenSecureStorage();
  final sessionService = AppSessionService(tokenStorage: tokenStorage);
  await sessionService.restore();

  final apiClient = BeneesseApiClient(
    baseUrl: AppConfig.apiBaseUrl,
    sessionService: sessionService,
  );

  final appRouter = AppRouter();

  runApp(
    BeneesseMobileApp(
      appRouter: appRouter,
      sessionService: sessionService,
      apiClient: apiClient,
    ),
  );
}

class BeneesseMobileApp extends StatelessWidget {
  const BeneesseMobileApp({
    required this.appRouter,
    required this.sessionService,
    required this.apiClient,
    super.key,
  });

  final AppRouter appRouter;
  final AppSessionService sessionService;

  /// Wired with [sessionService] for proactive token refresh; pass to repositories.
  final BeneesseApiClient apiClient;

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      localizationsDelegates: beLocalizationDelegates,
      supportedLocales: BeLocalizations.supportedLocales,
      theme: BeTheme.light,
      darkTheme: BeTheme.dark,
      themeMode: ThemeMode.system,
      routerConfig: appRouter.config(
        reevaluateListenable: sessionService.listenable,
      ),
    );
  }
}
