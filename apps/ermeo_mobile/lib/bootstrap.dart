import 'package:ermeo_api/ermeo_api.dart';
import 'package:ermeo_mobile/app.dart';
import 'package:ermeo_mobile/core/config/app_config.dart';
import 'package:ermeo_mobile/core/config/app_environment.dart';
import 'package:ermeo_mobile/core/firebase/firebase_bootstrap.dart';
import 'package:ermeo_mobile/core/logging/er_api_logger.dart';
import 'package:ermeo_mobile/core/router/app_router.dart';
import 'package:ermeo_mobile/core/session/session_service.dart';
import 'package:ermeo_mobile/features/auth/data/auth_repository.dart';
import 'package:ermeo_monitoring/ermeo_monitoring.dart';
import 'package:ermeo_secure_storage/ermeo_secure_storage.dart';
import 'package:flutter/material.dart';

/// Shared app bootstrap for all environment entry points.
Future<void> runErmeoApp(AppConfig config) async {
  await runAppGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();
    await initializeErmeoFirebase(config.environment);

    await ErmeoMonitoring.initialize(
      MonitoringConfig(
        enableRemoteLogging: config.environment == AppEnvironment.prod,
        crashReporter: const FirebaseCrashReporter(),
        logSinks: const [CrashlyticsLogSink()],
      ),
    );

    final tokenStorage = FlutterTokenSecureStorage();
    final sessionService = AppSessionService(tokenStorage: tokenStorage);
    await sessionService.restore();

    final apiClient = ErmeoApiClient(
      baseUrl: config.apiBaseUrl,
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
