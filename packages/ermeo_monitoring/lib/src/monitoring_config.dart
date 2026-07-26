import 'package:ermeo_monitoring/src/crash/crash_reporter.dart';
import 'package:ermeo_monitoring/src/crash/noop_crash_reporter.dart';
import 'package:ermeo_monitoring/src/logging/log_sink.dart';
import 'package:logger/logger.dart';

/// Configuration for [ErmeoMonitoring.initialize].
class MonitoringConfig {
  const MonitoringConfig({
    this.enableRemoteLogging = false,
    this.crashReporter = const NoOpCrashReporter(),
    this.logSinks = const [],
    this.minLevel = Level.debug,
  });

  /// When true, [logSinks] receive log events in addition to the console.
  final bool enableRemoteLogging;

  /// Backend used by [runAppGuarded] and [ErmeoMonitoring.crashReporter].
  final CrashReporter crashReporter;

  /// Remote destinations used only when [enableRemoteLogging] is true.
  final List<LogSink> logSinks;

  /// Minimum level printed to the local console.
  final Level minLevel;
}
