import 'package:ermeo_mobile/core/config/app_environment.dart';
import 'package:ermeo_mobile/core/firebase/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';

/// Initializes Firebase for the given [environment].
///
/// Staging shares the non-prod (dev) Firebase options until a staging
/// Firebase project exists.
Future<FirebaseApp> initializeErmeoFirebase(AppEnvironment environment) {
  final isProd = environment == AppEnvironment.prod;
  return Firebase.initializeApp(
    options: DefaultFirebaseOptions.forFlavor(isProd: isProd),
  );
}
