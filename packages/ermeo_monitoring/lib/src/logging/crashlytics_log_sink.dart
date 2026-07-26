import 'package:ermeo_monitoring/src/crash/crashlytics_client.dart';
import 'package:ermeo_monitoring/src/crash/firebase_crashlytics_client.dart';
import 'package:ermeo_monitoring/src/logging/log_sink.dart';
import 'package:logger/logger.dart';

/// Forwards log events to Firebase Crashlytics breadcrumbs / non-fatals.
///
/// Requires [Firebase.initializeApp] to have been called by the app first.
class CrashlyticsLogSink implements LogSink {
  const CrashlyticsLogSink({CrashlyticsClient? client})
    : _client = client ?? const FirebaseCrashlyticsClient();

  final CrashlyticsClient _client;

  @override
  void write({
    required Level level,
    required String message,
    Object? error,
    StackTrace? stackTrace,
  }) {
    final line = '[${level.name}] $message';
    // Fire-and-forget; Crashlytics log is async but sinks are sync.
    _client.log(line);
    if (error != null &&
        (level == Level.error ||
            level == Level.fatal ||
            level == Level.warning)) {
      _client.recordError(
        error,
        stackTrace,
        fatal: level == Level.fatal,
      );
    }
  }
}
