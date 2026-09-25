// Firebase configuration for the `rupeshflutter` project.
//
// Regenerate this file with the FlutterFire CLI once you are logged in to the
// Firebase account that owns the project:
//
//   dart pub global activate flutterfire_cli
//   flutterfire configure --project=rupeshflutter --platforms=web
//
// Until real values are filled in, [FirebaseService] runs the site in
// "offline" mode and the contact form falls back to a mailto: link.
import 'package:firebase_core/firebase_core.dart';

class DefaultFirebaseOptions {
  DefaultFirebaseOptions._();

  static const String projectId = 'rupeshflutter';

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'REPLACE_WITH_WEB_API_KEY',
    appId: 'REPLACE_WITH_WEB_APP_ID',
    messagingSenderId: 'REPLACE_WITH_SENDER_ID',
    projectId: projectId,
    authDomain: '$projectId.firebaseapp.com',
    storageBucket: '$projectId.appspot.com',
    measurementId: 'REPLACE_WITH_MEASUREMENT_ID',
  );

  static bool get isConfigured => !web.apiKey.startsWith('REPLACE_WITH');
}
