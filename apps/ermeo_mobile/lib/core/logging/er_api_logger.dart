import 'package:ermeo_api/ermeo_api.dart';
import 'package:ermeo_monitoring/ermeo_monitoring.dart';

/// Adapts [ErLogger] to the pure-Dart [ApiLogger] port used by `ermeo_api`.
class ErApiLogger implements ApiLogger {
  const ErApiLogger(this._logger);

  final ErLogger _logger;

  @override
  void d(String message) => _logger.d(message);

  @override
  void i(String message) => _logger.i(message);

  @override
  void w(String message, {Object? error, StackTrace? stackTrace}) {
    _logger.w(message, error: error, stackTrace: stackTrace);
  }

  @override
  void e(String message, {Object? error, StackTrace? stackTrace}) {
    _logger.e(message, error: error, stackTrace: stackTrace);
  }
}
