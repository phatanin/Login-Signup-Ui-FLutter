import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login_signup_ui_starter/screens/reset_password.dart';
import 'package:login_signup_ui_starter/screens/signup.dart';
import 'package:login_signup_ui_starter/theme.dart';
import 'package:login_signup_ui_starter/widgets/login_form.dart';

class LogInScreen extends StatefulWidget {
  @override
  _LogInScreenState createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future<void> logInWithEmailPassword(String email, String password) async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      print("User logged in: ${userCredential.user?.email}");
      // Navigate to home screen or another page after successful login
    } catch (e) {
      print("Error: $e");
      // Show error message to the user
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Login failed: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: kDefaultPadding,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 120),
              Text('Welcome Back', style: titleText),
              SizedBox(height: 5),
              Row(
                children: [
                  Text('New to this app?', style: subTitle),
                  SizedBox(width: 5),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SignUpScreen()),
                      );
                    },
                    child: Text(
                      'Sign Up',
                      style: textButton.copyWith(
                        decoration: TextDecoration.underline,
                        decorationThickness: 1,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              LogInForm(
                emailController: emailController,
                passwordController: passwordController,
                onLogIn: (email, password) {
                  logInWithEmailPassword(
                      email, password); // จัดการเข้าสู่ระบบที่นี่
                },
              ),
              SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ResetPasswordScreen()));
                },
                child: Text(
                  'Forgot password?',
                  style: TextStyle(
                    color: kZambeziColor,
                    fontSize: 14,
                    decoration: TextDecoration.underline,
                    decorationThickness: 1,
                  ),
                ),
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
