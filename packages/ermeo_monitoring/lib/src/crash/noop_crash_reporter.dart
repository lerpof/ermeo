import 'package:ermeo_monitoring/src/crash/crash_reporter.dart';
import 'package:flutter/foundation.dart';

/// No-op [CrashReporter] for tests and environments without remote crash reporting.
class NoOpCrashReporter implements CrashReporter {
  const NoOpCrashReporter();

  @override
  Future<void> setCollectionEnabled(bool enabled) async {}

  @override
  Future<void> recordFlutterError(FlutterErrorDetails details) async {}

  @override
  Future<void> recordError(
    Object error,
    StackTrace? stackTrace, {
    bool fatal = false,
  }) async {}
}
