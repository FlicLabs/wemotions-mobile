// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members

import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart' show kIsWeb, defaultTargetPlatform, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      throw _unsupportedError('web');
    }
    return _platformOptions[defaultTargetPlatform] ?? _unsupportedError(defaultTargetPlatform.name);
  }

  static FirebaseOptions _unsupportedError(String platform) {
    throw UnsupportedError(
      'DefaultFirebaseOptions have not been configured for $platform - '
      'reconfigure using the FlutterFire CLI.',
    );
  }

  static final Map<TargetPlatform, FirebaseOptions> _platformOptions = {
    TargetPlatform.android: FirebaseOptions(
      apiKey: 'AIzaSyAxpR7Vx1FxhzFlqUbXF6kmZIWCWCilFwk',
      appId: '1:933869952850:android:3192be45e4a2961c2ea48b',
      messagingSenderId: '933869952850',
      projectId: 'we-motions',
      storageBucket: 'we-motions.appspot.com',
    ),
    TargetPlatform.iOS: FirebaseOptions(
      apiKey: 'AIzaSyCg4XP46RBvaAlfDC7csrpDyZA0LznuZzE',
      appId: '1:933869952850:ios:e9a666011fbc65452ea48b',
      messagingSenderId: '933869952850',
      projectId: 'we-motions',
      storageBucket: 'we-motions.appspot.com',
      iosBundleId: 'com.wemotions.app',
    ),
  };
}
