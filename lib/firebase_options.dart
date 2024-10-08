// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCTn2wDqr0YSSolzDc-dQ6BB-p-QxG7i4c',
    appId: '1:345725309478:android:43ad25290ce772a8a88ce7',
    messagingSenderId: '345725309478',
    projectId: 'brainetapp',
    storageBucket: 'brainetapp.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyA0upzkqD1EWSJIYtqXMvmOt63FwBDVOkE',
    appId: '1:345725309478:ios:1a83051f0102cc17a88ce7',
    messagingSenderId: '345725309478',
    projectId: 'brainetapp',
    storageBucket: 'brainetapp.appspot.com',
    iosBundleId: 'com.example.netbrains',
  );

  static const FirebaseOptions web = FirebaseOptions(
      apiKey: "AIzaSyBRz0XkqTPrfqvUEXFVWnHA3f7--UfcMT0",
      authDomain: "brainetapp.firebaseapp.com",
      projectId: "brainetapp",
      storageBucket: "brainetapp.appspot.com",
      messagingSenderId: "345725309478",
      appId: "1:345725309478:web:3b50fe0fc0c42eb3a88ce7",
      measurementId: "G-PR279JHNTE");
}
