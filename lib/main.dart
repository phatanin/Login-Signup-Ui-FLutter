import 'package:flutter/material.dart';
import 'package:login_signup_ui_starter/screens/login.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
    apiKey: 'AIzaSyDujGhkUw1UL-kD2Bp22GUMwxdi6kPKx_g',
    appId: '1:984576650238:android:b12bdd9325561a97966eaf',
    messagingSenderId: '',
    projectId: 'flutter-project-facaf',
  ));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'Poppins'),
      home: LogInScreen(),
    );
  }
}
