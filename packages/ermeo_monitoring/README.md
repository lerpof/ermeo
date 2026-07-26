# ermeo_monitoring

Flutter package for observability: logging, crash reporting, and guarded app bootstrap.

## Purpose

Thin wrappers so apps do not call third-party monitoring SDKs directly. Today:

- Console (+ optional remote) logging via [`logger`](https://pub.dev/packages/logger) `2.7.0`
- Pluggable `LogSink` (shipped: `CrashlyticsLogSink`)
- Pluggable `CrashReporter` (shipped: `FirebaseCrashReporter`, `NoOpCrashReporter`)
- `runAppGuarded` to catch Flutter / zone / platform errors

## Public API

| Symbol | Role |
|--------|------|
| `ErmeoMonitoring.initialize` | Configure logger, sinks, crash reporter |
| `ErmeoMonitoring.logger` | `ErLogger` (`d` / `i` / `w` / `e` / `f`) |
| `ErmeoMonitoring.crashReporter` | Active `CrashReporter` |
| `MonitoringConfig` | `enableRemoteLogging`, `crashReporter`, `logSinks`, `minLevel` |
| `LogSink` | Remote log destination interface |
| `CrashReporter` | Crash / non-fatal reporting interface |
| `CrashlyticsLogSink` | Forwards logs to Firebase Crashlytics |
| `FirebaseCrashReporter` | Crashlytics-backed crash reporter |
| `NoOpCrashReporter` | No-op for tests / local-only |
| `runAppGuarded` | Zone + `FlutterError` + `PlatformDispatcher` capture |

## Usage

```dart
await runAppGuarded(() async {
  // ensureInitialized + runApp must share this zone
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: /* flavor options */);

  await ErmeoMonitoring.initialize(
    MonitoringConfig(
      enableRemoteLogging: true, // attach logSinks
      crashReporter: const FirebaseCrashReporter(),
      logSinks: const [CrashlyticsLogSink()],
    ),
  );

  ErmeoMonitoring.logger.i('Booted');
  runApp(const MyApp());
});
```

`Firebase.initializeApp` stays in the **app** (flavor-specific options). This package only wraps Crashlytics.

## Dependency rules

- No dependency on `ermeo_api`.
- Consumed by `apps/ermeo_mobile` (and future apps as needed).
- Swap Crashlytics by implementing `CrashReporter` / `LogSink` and passing them in `MonitoringConfig`.

## Tests

```bash
cd packages/ermeo_monitoring && fvm flutter test --coverage
```
