import 'package:ermeo_api/ermeo_api.dart';
import 'package:ermeo_l10n/ermeo_l10n.dart';
import 'package:ermeo_mobile/core/config/app_config.dart';
import 'package:ermeo_mobile/core/config/app_environment.dart';
import 'package:ermeo_mobile/core/firebase/firebase_bootstrap.dart';
import 'package:ermeo_mobile/core/logging/er_api_logger.dart';
import 'package:ermeo_mobile/core/router/app_router.dart';
import 'package:ermeo_mobile/core/session/session_service.dart';
import 'package:ermeo_mobile/features/auth/data/auth_repository.dart';
import 'package:ermeo_monitoring/ermeo_monitoring.dart';
import 'package:ermeo_secure_storage/ermeo_secure_storage.dart';
import 'package:ermeo_ui/ermeo_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<void> main() async {
  await runAppGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();
    await initializeErmeoFirebase();

    await ErmeoMonitoring.initialize(
      MonitoringConfig(
        enableRemoteLogging: AppConfig.environment == AppEnvironment.prod,
        crashReporter: const FirebaseCrashReporter(),
        logSinks: const [CrashlyticsLogSink()],
      ),
    );

    final tokenStorage = FlutterTokenSecureStorage();
    final sessionService = AppSessionService(tokenStorage: tokenStorage);
    await sessionService.restore();

    final apiClient = ErmeoApiClient(
      baseUrl: AppConfig.apiBaseUrl,
      sessionService: sessionService,
      logger: ErApiLogger(ErmeoMonitoring.logger),
    );

    final authRepository = AuthRepositoryImpl(
      apiClient: apiClient,
      sessionService: sessionService,
    );

    final appRouter = AppRouter(sessionService: sessionService);

    runApp(
      ErmeoMobileApp(
        appRouter: appRouter,
        sessionService: sessionService,
        authRepository: authRepository,
      ),
    );
  });
}

class ErmeoMobileApp extends StatelessWidget {
  const ErmeoMobileApp({
    required this.appRouter,
    required this.sessionService,
    required this.authRepository,
    super.key,
  });

  final AppRouter appRouter;
  final AppSessionService sessionService;
  final AuthRepository authRepository;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider<AuthRepository>.value(
      value: authRepository,
      child: MaterialApp.router(
        localizationsDelegates: erLocalizationDelegates,
        supportedLocales: ErLocalizations.supportedLocales,
        theme: ErTheme.light,
        darkTheme: ErTheme.dark,
        themeMode: ThemeMode.system,
        routerConfig: appRouter.config(
          reevaluateListenable: sessionService.listenable,
        ),
      ),
    );
  }
}
