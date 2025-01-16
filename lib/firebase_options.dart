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
      apiKey: 'AIzaSyARCjxiRmxYg0ou8UZB9iBbaXZU9bgM9zo',
      appId: '1:451193137837:web:20ef4a02bac5e70b7af424',
      messagingSenderId: '451193137837',
      projectId: 'evenly-project',
      authDomain: 'evenly-project.firebaseapp.com',
      storageBucket: 'evenly-project.firebasestorage.app',
    databaseURL: 'https://evenly-project-default-rtdb.asia-southeast1.firebasedatabase.app');

  static const FirebaseOptions android = FirebaseOptions(
      apiKey: 'AIzaSyDQcnWxsYHqcW8MBvpMnC-F-EeLHrxm0OQ',
      appId: '1:451193137837:android:df47673d0643c5ff7af424',
      messagingSenderId: '451193137837',
      projectId: 'evenly-project',
      storageBucket: 'evenly-project.firebasestorage.app',
    databaseURL: 'https://evenly-project-default-rtdb.asia-southeast1.firebasedatabase.app');

  static const FirebaseOptions ios = FirebaseOptions(
      apiKey: 'AIzaSyAVmk9DbHOlCBJnadBiOmbrckbJPX2MLpI',
      appId: '1:451193137837:ios:6d15be5b12208a9a7af424',
      messagingSenderId: '451193137837',
      projectId: 'evenly-project',
      storageBucket: 'evenly-project.firebasestorage.app',
      iosBundleId: 'edu.icet.evenly',
    databaseURL: 'https://evenly-project-default-rtdb.asia-southeast1.firebasedatabase.app');

  static const FirebaseOptions macos = FirebaseOptions(
      apiKey: 'AIzaSyAVmk9DbHOlCBJnadBiOmbrckbJPX2MLpI',
      appId: '1:451193137837:ios:6d15be5b12208a9a7af424',
      messagingSenderId: '451193137837',
      projectId: 'evenly-project',
      storageBucket: 'evenly-project.firebasestorage.app',
      iosBundleId: 'edu.icet.evenly',
    databaseURL: 'https://evenly-project-default-rtdb.asia-southeast1.firebasedatabase.app');


  static const FirebaseOptions windows = FirebaseOptions(
      apiKey: 'AIzaSyARCjxiRmxYg0ou8UZB9iBbaXZU9bgM9zo',
      appId: '1:451193137837:web:c8314d5dadd2ea6a7af424',
      messagingSenderId: '451193137837',
      projectId: 'evenly-project',
      authDomain: 'evenly-project.firebaseapp.com',
      storageBucket: 'evenly-project.firebasestorage.app',
    databaseURL: 'https://evenly-project-default-rtdb.asia-southeast1.firebasedatabase.app');
}
