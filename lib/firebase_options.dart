// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyCc8q7RRFCqaHG5v_0Fyc1xngDxgtymZaQ',
    appId: '1:727668312119:web:664d151506e7bdee9dd7b2',
    messagingSenderId: '727668312119',
    projectId: 'health10293',
    authDomain: 'health10293.firebaseapp.com',
    storageBucket: 'health10293.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDtKuEMMGzl2rbVEfRdEo-psg91I7fcQqM',
    appId: '1:727668312119:android:ddd3afcb01f6bdc29dd7b2',
    messagingSenderId: '727668312119',
    projectId: 'health10293',
    storageBucket: 'health10293.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDACrDeI7_AFmnEMq6OmUUaqPpr3WJ5eU8',
    appId: '1:727668312119:ios:8feabe707354c8859dd7b2',
    messagingSenderId: '727668312119',
    projectId: 'health10293',
    storageBucket: 'health10293.appspot.com',
    iosClientId: '727668312119-li9vfh4aso26bsnvqma58o9qpkjjcgro.apps.googleusercontent.com',
    iosBundleId: 'com.example.healthTaylor',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDACrDeI7_AFmnEMq6OmUUaqPpr3WJ5eU8',
    appId: '1:727668312119:ios:83c8647019d7dc199dd7b2',
    messagingSenderId: '727668312119',
    projectId: 'health10293',
    storageBucket: 'health10293.appspot.com',
    iosClientId: '727668312119-evqfp2034rm4ogdqk72o8imnpr2396u4.apps.googleusercontent.com',
    iosBundleId: 'com.example.healthTaylor.RunnerTests',
  );
}
