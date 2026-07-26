import 'package:ermeo_monitoring/src/crash/crash_reporter.dart';
import 'package:ermeo_monitoring/src/crash/noop_crash_reporter.dart';
import 'package:ermeo_monitoring/src/logging/er_logger.dart';
import 'package:ermeo_monitoring/src/logging/log_sink.dart';
import 'package:ermeo_monitoring/src/monitoring_config.dart';
import 'package:logger/logger.dart';

/// Entry point for Ermeo observability (logging + crash reporting).
class ErmeoMonitoring {
  // coverage:ignore-start
  ErmeoMonitoring._();
  // coverage:ignore-end

  static ErLogger? _logger;
  static CrashReporter _crashReporter = const NoOpCrashReporter();
  static bool _initialized = false;

  /// Whether [initialize] has been called successfully.
  static bool get isInitialized => _initialized;

  /// Console (+ optional remote) logger. Requires [initialize].
  static ErLogger get logger {
    final value = _logger;
    if (value == null) {
      throw StateError(
        'ErmeoMonitoring.initialize must be called before accessing logger.',
      );
    }
    return value;
  }

  /// Active crash reporter. Safe before [initialize] (defaults to no-op).
  static CrashReporter get crashReporter => _crashReporter;

  /// Configures logging and crash reporting. Safe to call once at app start.
  static Future<void> initialize(MonitoringConfig config) async {
    final sinks = config.enableRemoteLogging
        ? List<LogSink>.unmodifiable(config.logSinks)
        : const <LogSink>[];

    _logger = ErLogger(
      logger: Logger(
        filter: ProductionFilter(),
        printer: PrettyPrinter(
          methodCount: 0,
          errorMethodCount: 5,
          lineLength: 80,
          colors: true,
          printEmojis: false,
        ),
        level: config.minLevel,
        output: ConsoleOutput(),
      ),
      sinks: sinks,
    );

    _crashReporter = config.crashReporter;

    final enableCollection = config.crashReporter is! NoOpCrashReporter;
    await _crashReporter.setCollectionEnabled(enableCollection);

    _initialized = true;
  }

  /// Resets static state. Intended for tests only.
  static void resetForTest() {
    _logger = null;
    _crashReporter = const NoOpCrashReporter();
    _initialized = false;
  }
}
