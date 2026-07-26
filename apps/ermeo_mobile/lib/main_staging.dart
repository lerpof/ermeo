import 'package:ermeo_mobile/bootstrap.dart';
import 'package:ermeo_mobile/core/config/app_config.dart';
import 'package:ermeo_mobile/core/config/app_environment.dart';

Future<void> main() => runErmeoApp(
  const AppConfig(environment: AppEnvironment.staging),
);
