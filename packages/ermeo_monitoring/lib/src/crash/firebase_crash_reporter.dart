import 'package:ermeo_monitoring/src/crash/crash_reporter.dart';
import 'package:ermeo_monitoring/src/crash/crashlytics_client.dart';
import 'package:ermeo_monitoring/src/crash/firebase_crashlytics_client.dart';
import 'package:flutter/foundation.dart';

/// [CrashReporter] that forwards to Firebase Crashlytics.
///
/// Requires [Firebase.initializeApp] to have been called by the app first.
class FirebaseCrashReporter implements CrashReporter {
  const FirebaseCrashReporter({CrashlyticsClient? client})
    : _client = client ?? const FirebaseCrashlyticsClient();

  final CrashlyticsClient _client;

  @override
  Future<void> setCollectionEnabled(bool enabled) {
    return _client.setCrashlyticsCollectionEnabled(enabled);
  }

  @override
  Future<void> recordFlutterError(FlutterErrorDetails details) {
    return _client.recordFlutterError(details);
  }

  @override
  Future<void> recordError(
    Object error,
    StackTrace? stackTrace, {
    bool fatal = false,
  }) {
    return _client.recordError(error, stackTrace, fatal: fatal);
  }
}
