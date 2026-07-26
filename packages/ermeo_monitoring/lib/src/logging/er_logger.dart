import 'package:ermeo_monitoring/src/logging/log_sink.dart';
import 'package:logger/logger.dart';

/// Thin facade over [Logger] with optional remote [LogSink] fan-out.
class ErLogger {
  factory ErLogger({
    required Logger logger,
    List<LogSink> sinks = const [],
  }) {
    return ErLogger._(
      logger,
      List<LogSink>.unmodifiable(sinks),
    );
  }

  ErLogger._(this._logger, this._sinks);

  final Logger _logger;
  final List<LogSink> _sinks;

  void d(
    dynamic message, {
    DateTime? time,
    Object? error,
    StackTrace? stackTrace,
  }) {
    _logger.d(message, time: time, error: error, stackTrace: stackTrace);
    _writeSinks(
      Level.debug,
      message,
      error: error,
      stackTrace: stackTrace,
    );
  }

  void i(
    dynamic message, {
    DateTime? time,
    Object? error,
    StackTrace? stackTrace,
  }) {
    _logger.i(message, time: time, error: error, stackTrace: stackTrace);
    _writeSinks(
      Level.info,
      message,
      error: error,
      stackTrace: stackTrace,
    );
  }

  void w(
    dynamic message, {
    DateTime? time,
    Object? error,
    StackTrace? stackTrace,
  }) {
    _logger.w(message, time: time, error: error, stackTrace: stackTrace);
    _writeSinks(
      Level.warning,
      message,
      error: error,
      stackTrace: stackTrace,
    );
  }

  void e(
    dynamic message, {
    DateTime? time,
    Object? error,
    StackTrace? stackTrace,
  }) {
    _logger.e(message, time: time, error: error, stackTrace: stackTrace);
    _writeSinks(
      Level.error,
      message,
      error: error,
      stackTrace: stackTrace,
    );
  }

  void f(
    dynamic message, {
    DateTime? time,
    Object? error,
    StackTrace? stackTrace,
  }) {
    _logger.f(message, time: time, error: error, stackTrace: stackTrace);
    _writeSinks(
      Level.fatal,
      message,
      error: error,
      stackTrace: stackTrace,
    );
  }

  void _writeSinks(
    Level level,
    dynamic message, {
    Object? error,
    StackTrace? stackTrace,
  }) {
    final text = message?.toString() ?? '';
    for (final sink in _sinks) {
      sink.write(
        level: level,
        message: text,
        error: error,
        stackTrace: stackTrace,
      );
    }
  }
}
