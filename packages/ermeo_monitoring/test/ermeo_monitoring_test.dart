import 'dart:async';

import 'package:ermeo_monitoring/ermeo_monitoring.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:logger/logger.dart';
import 'package:mocktail/mocktail.dart';

class _MockLogSink extends Mock implements LogSink {}

class _MockCrashReporter extends Mock implements CrashReporter {}

class _MockCrashlyticsClient extends Mock implements CrashlyticsClient {}

void main() {
  setUpAll(() {
    registerFallbackValue(Level.debug);
    registerFallbackValue(StackTrace.empty);
    registerFallbackValue(
      FlutterErrorDetails(exception: Exception('fallback')),
    );
  });

  tearDown(ErmeoMonitoring.resetForTest);

  group('NoOpCrashReporter', () {
    test('methods complete without error', () async {
      const reporter = NoOpCrashReporter();
      await reporter.setCollectionEnabled(true);
      await reporter.recordFlutterError(
        FlutterErrorDetails(exception: Exception('x')),
      );
      await reporter.recordError(Exception('y'), StackTrace.current, fatal: true);
    });
  });

  group('ErLogger', () {
    late _MockLogSink sink;
    late ErLogger logger;

    setUp(() {
      sink = _MockLogSink();
      logger = ErLogger(
        logger: Logger(
          filter: ProductionFilter(),
          printer: SimplePrinter(colors: false),
          output: ConsoleOutput(),
          level: Level.all,
        ),
        sinks: [sink],
      );
      when(
        () => sink.write(
          level: any(named: 'level'),
          message: any(named: 'message'),
          error: any(named: 'error'),
          stackTrace: any(named: 'stackTrace'),
        ),
      ).thenReturn(null);
    });

    test('d/i/w/e/f forward to sinks', () {
      final stack = StackTrace.current;
      final error = Exception('boom');

      logger.d('debug');
      logger.i('info');
      logger.w('warn', error: error, stackTrace: stack);
      logger.e('error', error: error, stackTrace: stack);
      logger.f('fatal', error: error, stackTrace: stack);

      verify(
        () => sink.write(
          level: Level.debug,
          message: 'debug',
          error: null,
          stackTrace: null,
        ),
      ).called(1);
      verify(
        () => sink.write(
          level: Level.info,
          message: 'info',
          error: null,
          stackTrace: null,
        ),
      ).called(1);
      verify(
        () => sink.write(
          level: Level.warning,
          message: 'warn',
          error: error,
          stackTrace: stack,
        ),
      ).called(1);
      verify(
        () => sink.write(
          level: Level.error,
          message: 'error',
          error: error,
          stackTrace: stack,
        ),
      ).called(1);
      verify(
        () => sink.write(
          level: Level.fatal,
          message: 'fatal',
          error: error,
          stackTrace: stack,
        ),
      ).called(1);
    });

    test('null message becomes empty string for sinks', () {
      logger.i(null);
      verify(
        () => sink.write(
          level: Level.info,
          message: '',
          error: null,
          stackTrace: null,
        ),
      ).called(1);
    });
  });

  group('CrashlyticsLogSink', () {
    late _MockCrashlyticsClient client;
    late CrashlyticsLogSink sink;

    setUp(() {
      client = _MockCrashlyticsClient();
      sink = CrashlyticsLogSink(client: client);
      when(() => client.log(any())).thenAnswer((_) async {});
      when(
        () => client.recordError(
          any(),
          any(),
          fatal: any(named: 'fatal'),
        ),
      ).thenAnswer((_) async {});
    });

    test('logs breadcrumb for info without recording error', () {
      sink.write(level: Level.info, message: 'hello');

      verify(() => client.log('[info] hello')).called(1);
      verifyNever(
        () => client.recordError(
          any(),
          any(),
          fatal: any(named: 'fatal'),
        ),
      );
    });

    test('records non-fatal for warning/error with error object', () {
      final error = Exception('bad');
      final stack = StackTrace.current;

      sink.write(
        level: Level.warning,
        message: 'warn',
        error: error,
        stackTrace: stack,
      );
      sink.write(
        level: Level.error,
        message: 'err',
        error: error,
        stackTrace: stack,
      );

      verify(
        () => client.recordError(error, stack, fatal: false),
      ).called(2);
    });

    test('records fatal for fatal level with error', () {
      final error = Exception('fatal');
      sink.write(level: Level.fatal, message: 'die', error: error);

      verify(
        () => client.recordError(error, null, fatal: true),
      ).called(1);
    });
  });

  group('FirebaseCrashReporter', () {
    late _MockCrashlyticsClient client;
    late FirebaseCrashReporter reporter;

    setUp(() {
      client = _MockCrashlyticsClient();
      reporter = FirebaseCrashReporter(client: client);
      when(
        () => client.setCrashlyticsCollectionEnabled(any()),
      ).thenAnswer((_) async {});
      when(() => client.recordFlutterError(any())).thenAnswer((_) async {});
      when(
        () => client.recordError(
          any(),
          any(),
          fatal: any(named: 'fatal'),
        ),
      ).thenAnswer((_) async {});
    });

    test('delegates to client', () async {
      final details = FlutterErrorDetails(exception: Exception('fe'));
      await reporter.setCollectionEnabled(true);
      await reporter.recordFlutterError(details);
      await reporter.recordError(Exception('e'), StackTrace.current, fatal: true);

      verify(() => client.setCrashlyticsCollectionEnabled(true)).called(1);
      verify(() => client.recordFlutterError(details)).called(1);
      verify(
        () => client.recordError(
          any(),
          any(),
          fatal: true,
        ),
      ).called(1);
    });
  });

  group('ErmeoMonitoring', () {
    test('logger throws before initialize', () {
      expect(() => ErmeoMonitoring.logger, throwsStateError);
      expect(ErmeoMonitoring.isInitialized, isFalse);
      expect(ErmeoMonitoring.crashReporter, isA<NoOpCrashReporter>());
    });

    test('initialize without remote logging ignores sinks', () async {
      final sink = _MockLogSink();
      when(
        () => sink.write(
          level: any(named: 'level'),
          message: any(named: 'message'),
          error: any(named: 'error'),
          stackTrace: any(named: 'stackTrace'),
        ),
      ).thenReturn(null);

      await ErmeoMonitoring.initialize(
        MonitoringConfig(
          enableRemoteLogging: false,
          logSinks: [sink],
        ),
      );

      expect(ErmeoMonitoring.isInitialized, isTrue);
      ErmeoMonitoring.logger.i('local only');

      verifyNever(
        () => sink.write(
          level: any(named: 'level'),
          message: any(named: 'message'),
          error: any(named: 'error'),
          stackTrace: any(named: 'stackTrace'),
        ),
      );
    });

    test('initialize with remote logging attaches sinks', () async {
      final sink = _MockLogSink();
      when(
        () => sink.write(
          level: any(named: 'level'),
          message: any(named: 'message'),
          error: any(named: 'error'),
          stackTrace: any(named: 'stackTrace'),
        ),
      ).thenReturn(null);

      await ErmeoMonitoring.initialize(
        MonitoringConfig(
          enableRemoteLogging: true,
          logSinks: [sink],
          minLevel: Level.all,
        ),
      );

      ErmeoMonitoring.logger.i('remote');

      verify(
        () => sink.write(
          level: Level.info,
          message: 'remote',
          error: null,
          stackTrace: null,
        ),
      ).called(1);
    });

    test('initialize enables collection for non-noop reporter', () async {
      final reporter = _MockCrashReporter();
      when(() => reporter.setCollectionEnabled(any())).thenAnswer((_) async {});

      await ErmeoMonitoring.initialize(
        MonitoringConfig(crashReporter: reporter),
      );

      verify(() => reporter.setCollectionEnabled(true)).called(1);
      expect(ErmeoMonitoring.crashReporter, same(reporter));
    });

    test('initialize disables collection for NoOpCrashReporter', () async {
      await ErmeoMonitoring.initialize(const MonitoringConfig());
      expect(ErmeoMonitoring.crashReporter, isA<NoOpCrashReporter>());
    });
  });

  group('runAppGuarded', () {
    test('runs body and records FlutterError', () async {
      final reporter = _MockCrashReporter();
      when(() => reporter.setCollectionEnabled(any())).thenAnswer((_) async {});
      when(
        () => reporter.recordError(
          any(),
          any(),
          fatal: any(named: 'fatal'),
        ),
      ).thenAnswer((_) async {});
      when(() => reporter.recordFlutterError(any())).thenAnswer((_) async {});

      await ErmeoMonitoring.initialize(
        MonitoringConfig(crashReporter: reporter),
      );

      await runAppGuarded(() async {
        FlutterError.reportError(
          FlutterErrorDetails(exception: Exception('flutter')),
        );
      });

      verify(() => reporter.recordFlutterError(any())).called(1);
    });

    test('PlatformDispatcher onError records fatal', () async {
      final reporter = _MockCrashReporter();
      when(() => reporter.setCollectionEnabled(any())).thenAnswer((_) async {});
      when(
        () => reporter.recordError(
          any(),
          any(),
          fatal: any(named: 'fatal'),
        ),
      ).thenAnswer((_) async {});
      when(() => reporter.recordFlutterError(any())).thenAnswer((_) async {});

      await ErmeoMonitoring.initialize(
        MonitoringConfig(crashReporter: reporter),
      );

      await runAppGuarded(() async {});

      final handled = PlatformDispatcher.instance.onError?.call(
        Exception('platform'),
        StackTrace.current,
      );
      expect(handled, isTrue);

      await pumpEventQueue();
      verify(
        () => reporter.recordError(
          any(),
          any(),
          fatal: true,
        ),
      ).called(1);
    });

    test('zone onError records fatal async errors', () async {
      final reporter = _MockCrashReporter();
      when(() => reporter.setCollectionEnabled(any())).thenAnswer((_) async {});
      when(
        () => reporter.recordError(
          any(),
          any(),
          fatal: any(named: 'fatal'),
        ),
      ).thenAnswer((_) async {});
      when(() => reporter.recordFlutterError(any())).thenAnswer((_) async {});

      await ErmeoMonitoring.initialize(
        MonitoringConfig(crashReporter: reporter),
      );

      await runAppGuarded(() async {
        scheduleMicrotask(() {
          throw Exception('zone boom');
        });
        await Future<void>.delayed(Duration.zero);
      });

      await pumpEventQueue();
      verify(
        () => reporter.recordError(
          any(),
          any(),
          fatal: true,
        ),
      ).called(1);
    });
  });

  test('FirebaseCrashReporter and CrashlyticsLogSink default clients', () {
    expect(const FirebaseCrashReporter(), isA<FirebaseCrashReporter>());
    expect(const CrashlyticsLogSink(), isA<CrashlyticsLogSink>());
    expect(const FirebaseCrashlyticsClient(), isA<FirebaseCrashlyticsClient>());
  });
}
