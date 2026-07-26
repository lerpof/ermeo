import 'package:ermeo_mobile/core/config/app_environment.dart';

/// Runtime configuration for the current app entry point.
///
/// [environment] comes from each `main_*.dart`. [apiBaseUrl] comes from
/// `--dart-define` / `--dart-define-from-file` (`ERMEO_API_BASE_URL`).
class AppConfig {
  const AppConfig({
    required this.environment,
    this.apiBaseUrl = const String.fromEnvironment(
      'ERMEO_API_BASE_URL',
      defaultValue: 'http://localhost:8000',
    ),
  });

  final AppEnvironment environment;
  final String apiBaseUrl;
}
