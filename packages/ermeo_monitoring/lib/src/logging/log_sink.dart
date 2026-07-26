import 'package:logger/logger.dart';

/// Destination for log events beyond the local console.
///
/// Implement to forward logs to Crashlytics, a remote collector, etc.
abstract interface class LogSink {
  /// Called for each log event that passes the logger filter.
  void write({
    required Level level,
    required String message,
    Object? error,
    StackTrace? stackTrace,
  });
}
