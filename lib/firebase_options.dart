import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;
import 'package:firebase_core/firebase_core.dart';

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        return windows;
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyC2ps6c4LEj0nadaT6Qo6FxH-HCy8Klxrg',
    appId: '1:1048871214683:web:31235173fa3255433d697e',
    messagingSenderId: '1048871214683',
    projectId: 'login-flutter-903e6',
    authDomain: 'login-flutter-903e6.firebaseapp.com',
    storageBucket: 'login-flutter-903e6.firebasestorage.app',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDXQZWCKsbdDAd1A5a2c0o9QYL-4V3RHW4',
    appId: '1:1048871214683:android:ad48da5b61951c483d697e',
    messagingSenderId: '1048871214683',
    projectId: 'login-flutter-903e6',
    storageBucket: 'login-flutter-903e6.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDP7XOOBJ5Sd3acXnjbcxYBzJ3tlyyyKjI',
    appId: '1:1048871214683:ios:7772ff984986f1bd3d697e',
    messagingSenderId: '1048871214683',
    projectId: 'login-flutter-903e6',
    storageBucket: 'login-flutter-903e6.firebasestorage.app',
    iosBundleId: 'com.example.flutterApplication1',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDP7XOOBJ5Sd3acXnjbcxYBzJ3tlyyyKjI',
    appId: '1:1048871214683:ios:7772ff984986f1bd3d697e',
    messagingSenderId: '1048871214683',
    projectId: 'login-flutter-903e6',
    storageBucket: 'login-flutter-903e6.firebasestorage.app',
    iosBundleId: 'com.example.flutterApplication1',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyC2ps6c4LEj0nadaT6Qo6FxH-HCy8Klxrg',
    appId: '1:1048871214683:web:458cd55224f7ab613d697e',
    messagingSenderId: '1048871214683',
    projectId: 'login-flutter-903e6',
    authDomain: 'login-flutter-903e6.firebaseapp.com',
    storageBucket: 'login-flutter-903e6.firebasestorage.app',
  );

}
