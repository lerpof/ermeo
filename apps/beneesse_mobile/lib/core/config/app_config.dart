import 'app_environment.dart';

/// Compile-time configuration from `--dart-define` / `--dart-define-from-file`.
class AppConfig {
  const AppConfig._();

  static const String apiBaseUrl = String.fromEnvironment(
    'BENEESE_API_BASE_URL',
    defaultValue: 'http://localhost:8000',
  );

  static const String _appEnv = String.fromEnvironment(
    'APP_ENV',
    defaultValue: 'dev',
  );

  static AppEnvironment get environment => AppEnvironment.fromDefine(_appEnv);
}
