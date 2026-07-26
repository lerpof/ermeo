/// Minimal logging port used by [LoggingInterceptor].
///
/// Kept free of Flutter / `ermeo_monitoring` so `ermeo_api` stays pure Dart.
/// Apps adapt their logger (e.g. `ErLogger`) to this interface.
abstract interface class ApiLogger {
  void d(String message);

  void i(String message);

  void w(String message, {Object? error, StackTrace? stackTrace});

  void e(String message, {Object? error, StackTrace? stackTrace});
}
