// File generated manually from Firebase console configs for ermeo-dev.
// Both mobile flavors currently target the ermeo-dev Firebase project
// (prod package apps registered there). Swap to ermeo-prod when that
// project's Android/iOS configs and service account are available.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members

import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show TargetPlatform, defaultTargetPlatform, kIsWeb;

/// Default [FirebaseOptions] for the current flavor / platform.
class DefaultFirebaseOptions {
  const DefaultFirebaseOptions._();

  static FirebaseOptions forFlavor({required bool isProd}) {
    if (kIsWeb) {
      throw UnsupportedError('Web is not configured for Ermeo Firebase.');
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return isProd ? androidProd : androidDev;
      case TargetPlatform.iOS:
        return isProd ? iosProd : iosDev;
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions androidDev = FirebaseOptions(
    apiKey: 'AIzaSyDbb_iSzyp0fG_OZObY-KgDqoB7krESxEU',
    appId: '1:923295688170:android:2138d0ac305f99b02cfe93',
    messagingSenderId: '923295688170',
    projectId: 'ermeo-dev',
    storageBucket: 'ermeo-dev.firebasestorage.app',
  );

  static const FirebaseOptions androidProd = FirebaseOptions(
    apiKey: 'AIzaSyDbb_iSzyp0fG_OZObY-KgDqoB7krESxEU',
    appId: '1:923295688170:android:ae3997b24bca6a8c2cfe93',
    messagingSenderId: '923295688170',
    projectId: 'ermeo-dev',
    storageBucket: 'ermeo-dev.firebasestorage.app',
  );

  static const FirebaseOptions iosDev = FirebaseOptions(
    apiKey: 'AIzaSyDOpqLgQUea7RpQliSEPcHGFtE4hhmjrWQ',
    appId: '1:923295688170:ios:ea31873bda752d002cfe93',
    messagingSenderId: '923295688170',
    projectId: 'ermeo-dev',
    storageBucket: 'ermeo-dev.firebasestorage.app',
    iosBundleId: 'com.lerpof.ermeo.dev',
  );

  static const FirebaseOptions iosProd = FirebaseOptions(
    apiKey: 'AIzaSyDOpqLgQUea7RpQliSEPcHGFtE4hhmjrWQ',
    appId: '1:923295688170:ios:74b3f536d24672f62cfe93',
    messagingSenderId: '923295688170',
    projectId: 'ermeo-dev',
    storageBucket: 'ermeo-dev.firebasestorage.app',
    iosBundleId: 'com.lerpof.ermeo',
  );
}
