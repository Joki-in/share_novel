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

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyAGW2XNvy9jJEn-TURsyHykt2_i9DRiqSc',
    appId: '1:17775040778:web:9009f6375f271a9be402f3',
    messagingSenderId: '17775040778',
    projectId: 'sharenovel-flutter-3d556',
    authDomain: 'sharenovel-flutter-3d556.firebaseapp.com',
    storageBucket: 'sharenovel-flutter-3d556.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCC6etrrvCiHQpk3YJG4RSLgy86PrFW7Yk',
    appId: '1:17775040778:android:b8d5143d89311d0be402f3',
    messagingSenderId: '17775040778',
    projectId: 'sharenovel-flutter-3d556',
    storageBucket: 'sharenovel-flutter-3d556.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDTqdFaqNE-Ob3sdN7IETFaTIYPTFj_qYM',
    appId: '1:17775040778:ios:3da06dedcb41150de402f3',
    messagingSenderId: '17775040778',
    projectId: 'sharenovel-flutter-3d556',
    storageBucket: 'sharenovel-flutter-3d556.appspot.com',
    iosBundleId: 'com.sharenovel.shareNovel',
  );
}
