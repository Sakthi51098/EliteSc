import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show TargetPlatform, defaultTargetPlatform, kIsWeb;

class DefaultFirebaseOptions {
  const DefaultFirebaseOptions._();

  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web.',
      );
    }

    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are only configured for Android and iOS.',
        );
    }
  }

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyB0FeV4pyXqXP3cd5SB3_nvcDiUzIBoeto',
    appId: '1:585026031226:android:fb8ac8f1f42194e26eb5c3',
    messagingSenderId: '585026031226',
    projectId: 'elite-fc1eb',
    storageBucket: 'elite-fc1eb.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyA55a-LS5tCAxIVXr-Xp-JGoCB7Q4jQnJU',
    appId: '1:585026031226:ios:410ed6633cbca9f06eb5c3',
    messagingSenderId: '585026031226',
    projectId: 'elite-fc1eb',
    storageBucket: 'elite-fc1eb.firebasestorage.app',
    iosBundleId: 'com.elite.app',
  );
}
