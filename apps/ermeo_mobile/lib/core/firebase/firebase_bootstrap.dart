import 'package:ermeo_mobile/core/config/app_config.dart';
import 'package:ermeo_mobile/core/config/app_environment.dart';
import 'package:ermeo_mobile/core/firebase/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';

/// Initializes Firebase for the current [AppConfig.environment] flavor.
Future<FirebaseApp> initializeErmeoFirebase() {
  final isProd = AppConfig.environment == AppEnvironment.prod;
  return Firebase.initializeApp(
    options: DefaultFirebaseOptions.forFlavor(isProd: isProd),
  );
}
