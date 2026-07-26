import 'package:flutter/foundation.dart';

/// Narrow port over Firebase Crashlytics used by monitoring wrappers.
///
/// Keeps unit tests free of a real Firebase app.
abstract interface class CrashlyticsClient {
  Future<void> setCrashlyticsCollectionEnabled(bool enabled);

  Future<void> recordFlutterError(FlutterErrorDetails details);

  Future<void> recordError(
    Object exception,
    StackTrace? stack, {
    bool fatal = false,
  });

  Future<void> log(String message);
}
