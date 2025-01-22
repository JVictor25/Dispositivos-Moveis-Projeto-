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
    apiKey: 'AIzaSyDso5BX-kk8EUqLuMZcQKhhYHzT_N6BBUM',
    appId: '1:686694015678:web:194db74d4042dcecb5f4ef',
    messagingSenderId: '686694015678',
    projectId: 'breakpoint-4a869',
    authDomain: 'breakpoint-4a869.firebaseapp.com',
    storageBucket: 'breakpoint-4a869.firebasestorage.app',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDHeYOcxcAxHeV7dLhtDQ5Xxy5MMhb9Too',
    appId: '1:686694015678:android:f91c7fcb170f920cb5f4ef',
    messagingSenderId: '686694015678',
    projectId: 'breakpoint-4a869',
    storageBucket: 'breakpoint-4a869.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCkMJ105jrCUogI3YChlj0lcRi0OtPgkEY',
    appId: '1:686694015678:ios:e0855dd33392ef07b5f4ef',
    messagingSenderId: '686694015678',
    projectId: 'breakpoint-4a869',
    storageBucket: 'breakpoint-4a869.firebasestorage.app',
    iosBundleId: 'com.example.breakpointApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCkMJ105jrCUogI3YChlj0lcRi0OtPgkEY',
    appId: '1:686694015678:ios:e0855dd33392ef07b5f4ef',
    messagingSenderId: '686694015678',
    projectId: 'breakpoint-4a869',
    storageBucket: 'breakpoint-4a869.firebasestorage.app',
    iosBundleId: 'com.example.breakpointApp',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyDso5BX-kk8EUqLuMZcQKhhYHzT_N6BBUM',
    appId: '1:686694015678:web:d6dfcd0c62935c30b5f4ef',
    messagingSenderId: '686694015678',
    projectId: 'breakpoint-4a869',
    authDomain: 'breakpoint-4a869.firebaseapp.com',
    storageBucket: 'breakpoint-4a869.firebasestorage.app',
  );

}