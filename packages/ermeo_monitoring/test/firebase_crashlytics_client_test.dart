import 'package:ermeo_monitoring/ermeo_monitoring.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class _MockFirebaseCrashlytics extends Mock implements FirebaseCrashlytics {}

void main() {
  setUpAll(() {
    registerFallbackValue(
      FlutterErrorDetails(exception: Exception('fallback')),
    );
    registerFallbackValue(StackTrace.empty);
  });

  group('FirebaseCrashlyticsClient', () {
    late _MockFirebaseCrashlytics crashlytics;
    late FirebaseCrashlyticsClient client;

    setUp(() {
      crashlytics = _MockFirebaseCrashlytics();
      client = FirebaseCrashlyticsClient(crashlytics);
      when(
        () => crashlytics.setCrashlyticsCollectionEnabled(any()),
      ).thenAnswer((_) async {});
      when(() => crashlytics.recordFlutterError(any())).thenAnswer((_) async {});
      when(
        () => crashlytics.recordError(
          any<Object>(),
          any<StackTrace?>(),
          fatal: any<bool>(named: 'fatal'),
          reason: any<Object?>(named: 'reason'),
          information: any<Iterable<Object>>(named: 'information'),
          printDetails: any<bool?>(named: 'printDetails'),
        ),
      ).thenAnswer((_) async {});
      when(() => crashlytics.log(any())).thenAnswer((_) async {});
    });

    test('delegates all methods to FirebaseCrashlytics', () async {
      final details = FlutterErrorDetails(exception: Exception('fe'));
      final error = Exception('err');
      final stack = StackTrace.current;

      await client.setCrashlyticsCollectionEnabled(true);
      await client.recordFlutterError(details);
      await client.recordError(error, stack, fatal: true);
      await client.log('breadcrumb');

      verify(() => crashlytics.setCrashlyticsCollectionEnabled(true)).called(1);
      verify(() => crashlytics.recordFlutterError(details)).called(1);
      verify(
        () => crashlytics.recordError(error, stack, fatal: true),
      ).called(1);
      verify(() => crashlytics.log('breadcrumb')).called(1);
    });
  });
}
