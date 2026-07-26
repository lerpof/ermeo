import 'package:flutter/foundation.dart';

/// Abstraction over crash / non-fatal error reporting backends.
abstract interface class CrashReporter {
  /// Enables or disables automatic crash collection for this backend.
  Future<void> setCollectionEnabled(bool enabled);

  /// Records a Flutter framework error (typically from [FlutterError.onError]).
  Future<void> recordFlutterError(FlutterErrorDetails details);

  /// Records an arbitrary error, optionally as fatal.
  Future<void> recordError(
    Object error,
    StackTrace? stackTrace, {
    bool fatal = false,
  });
}
