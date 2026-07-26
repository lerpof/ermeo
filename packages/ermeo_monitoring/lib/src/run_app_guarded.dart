import 'dart:async';

import 'package:ermeo_monitoring/src/monitoring.dart';
import 'package:flutter/foundation.dart';

/// Runs [body] inside a zone that reports uncaught errors to
/// [ErmeoMonitoring.crashReporter].
///
/// Call [WidgetsFlutterBinding.ensureInitialized], Firebase / monitoring
/// setup, and [runApp] **inside** [body] so they share the same zone.
Future<void> runAppGuarded(Future<void> Function() body) async {
  await runZonedGuarded<Future<void>>(
    () async {
      FlutterError.onError = (FlutterErrorDetails details) {
        FlutterError.presentError(details);
        unawaited(ErmeoMonitoring.crashReporter.recordFlutterError(details));
      };

      PlatformDispatcher.instance.onError = (Object error, StackTrace stack) {
        unawaited(
          ErmeoMonitoring.crashReporter.recordError(error, stack, fatal: true),
        );
        return true;
      };

      await body();
    },
    (Object error, StackTrace stack) {
      unawaited(
        ErmeoMonitoring.crashReporter.recordError(error, stack, fatal: true),
      );
    },
  );
}
