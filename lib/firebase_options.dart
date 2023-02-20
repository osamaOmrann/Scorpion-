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
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
        'you can reconfigure this by running the FlutterFire CLI again.',
      );
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
    apiKey: 'AIzaSyDgDjh0mnrB8P1VLxSogNEcf_59MJRNi2M',
    appId: '1:267546551176:android:f85982b9f8582e89e7903d',
    messagingSenderId: '267546551176',
    projectId: 'scorpion-plus-ii',
    storageBucket: 'scorpion-plus-ii.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyASViiaiUJHIGEW99mcoqcIRiUonoYRumM',
    appId: '1:267546551176:ios:9916f5f419fe2356e7903d',
    messagingSenderId: '267546551176',
    projectId: 'scorpion-plus-ii',
    storageBucket: 'scorpion-plus-ii.appspot.com',
    androidClientId:
        '267546551176-r78qo0l1tsjmonitdmpg7bskgi6o8imh.apps.googleusercontent.com',
    iosClientId:
        '267546551176-tn44rdb3qjf7ccvib3ers8g0vi4233q9.apps.googleusercontent.com',
    iosBundleId: 'com.example.scorpionPlus',
  );
}
