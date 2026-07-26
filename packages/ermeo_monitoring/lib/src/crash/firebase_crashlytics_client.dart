import 'package:ermeo_monitoring/src/crash/crashlytics_client.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';

/// [CrashlyticsClient] backed by [FirebaseCrashlytics].
class FirebaseCrashlyticsClient implements CrashlyticsClient {
  /// Creates a client using [crashlytics], or [FirebaseCrashlytics.instance]
  /// when omitted.
  const FirebaseCrashlyticsClient([this._crashlytics]);

  final FirebaseCrashlytics? _crashlytics;

  FirebaseCrashlytics get _client {
    final injected = _crashlytics;
    if (injected != null) {
      return injected;
    }
    // Requires Firebase.initializeApp in the host app.
    // coverage:ignore-start
    return FirebaseCrashlytics.instance;
    // coverage:ignore-end
  }

  @override
  Future<void> setCrashlyticsCollectionEnabled(bool enabled) {
    return _client.setCrashlyticsCollectionEnabled(enabled);
  }

  @override
  Future<void> recordFlutterError(FlutterErrorDetails details) {
    return _client.recordFlutterError(details);
  }

  @override
  Future<void> recordError(
    Object exception,
    StackTrace? stack, {
    bool fatal = false,
  }) {
    return _client.recordError(exception, stack, fatal: fatal);
  }

  @override
  Future<void> log(String message) {
    return _client.log(message);
  }
}
