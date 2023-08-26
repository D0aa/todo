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
    apiKey: 'AIzaSyDK6cJZIyXlqGVyVyIhjSjbrimDsyju-lU',
    appId: '1:541170619647:web:392ac8b3266cb2895aa8ca',
    messagingSenderId: '541170619647',
    projectId: 'to-do-app-68a59',
    authDomain: 'to-do-app-68a59.firebaseapp.com',
    storageBucket: 'to-do-app-68a59.appspot.com',
    measurementId: 'G-FSMB17NT1D',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBkXRDP0bYoo8-fX6j86KkW-ITIFn8GlB8',
    appId: '1:541170619647:android:efc657dbabe198045aa8ca',
    messagingSenderId: '541170619647',
    projectId: 'to-do-app-68a59',
    storageBucket: 'to-do-app-68a59.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAl43TM-m8Y5FR0w5o_Ns1Y4hYWT1KOJMU',
    appId: '1:541170619647:ios:2fc879176960c6015aa8ca',
    messagingSenderId: '541170619647',
    projectId: 'to-do-app-68a59',
    storageBucket: 'to-do-app-68a59.appspot.com',
    iosClientId: '541170619647-uvsc0u0o3sthjbik2e3r955cordd45h6.apps.googleusercontent.com',
    iosBundleId: 'com.example.toDoApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAl43TM-m8Y5FR0w5o_Ns1Y4hYWT1KOJMU',
    appId: '1:541170619647:ios:6ef047d902fa799e5aa8ca',
    messagingSenderId: '541170619647',
    projectId: 'to-do-app-68a59',
    storageBucket: 'to-do-app-68a59.appspot.com',
    iosClientId: '541170619647-p6lu5ks8l64ikvkd4odmnuiimnjr4b8a.apps.googleusercontent.com',
    iosBundleId: 'com.example.toDoApp.RunnerTests',
  );
}
