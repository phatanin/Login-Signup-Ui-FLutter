import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:login_signup_ui_starter/theme.dart';
import 'package:login_signup_ui_starter/screens/login.dart';
import 'package:login_signup_ui_starter/widgets/primary_button.dart'; // นำเข้า PrimaryButton

class SignUpForm extends StatefulWidget {
  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  bool _isObscure = true;

  Future<void> signUpWithEmailPassword(
      String email, String password, BuildContext context) async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      print("User registered: ${userCredential.user?.email}");
      // Navigate to login screen or home screen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LogInScreen()),
      );
    } catch (e) {
      print("Error: $e");
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Error: ${e.toString()}")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          buildInputForm('First Name', false, validateNotEmpty),
          buildInputForm('Last Name', false, validateNotEmpty),
          buildInputForm('Email', false, validateEmail),
          buildInputForm('Phone', false, validatePhone),
          buildInputForm('Password', true, validatePassword),
          buildInputForm('Confirm Password', true, validateConfirmPassword),
          SizedBox(height: 20),
          PrimaryButton(
            buttonText: 'Sign Up', // ใช้ PrimaryButton
            onTap: () async {
              if (_formKey.currentState!.validate()) {
                String email = emailController.text.trim();
                String password = passwordController.text.trim();

                // Call the sign-up function
                await signUpWithEmailPassword(email, password, context);
              } else {
                print("Form is invalid");
              }
            },
          ),
        ],
      ),
    );
  }

  Padding buildInputForm(
      String hint, bool pass, String? Function(String?) validator) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5),
      child: TextFormField(
        controller: hint == 'Email'
            ? emailController
            : (hint == 'Password'
                ? passwordController
                : (hint == 'Confirm Password'
                    ? confirmPasswordController
                    : null)), // กำหนด controller ตามฟิลด์
        obscureText: pass ? _isObscure : false,
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(color: kTextFieldColor),
          focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: kPrimaryColor)),
          suffixIcon: pass
              ? IconButton(
                  onPressed: () {
                    setState(() {
                      _isObscure = !_isObscure;
                    });
                  },
                  icon: _isObscure
                      ? Icon(
                          Icons.visibility_off,
                          color: kTextFieldColor,
                        )
                      : Icon(
                          Icons.visibility,
                          color: kPrimaryColor,
                        ))
              : null,
        ),
        validator: validator,
      ),
    );
  }

  // ฟังก์ชันตรวจสอบฟิลด์ต่างๆ
  String? validateNotEmpty(String? value) {
    if (value == null || value.isEmpty) {
      return 'This field is required';
    }
    return null;
  }

  String? validateEmail(String? value) {
    final emailPattern = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
    final regExp = RegExp(emailPattern);
    if (value == null || value.isEmpty) {
      return 'Email is required';
    } else if (!regExp.hasMatch(value)) {
      return 'Enter a valid email';
    }
    return null;
  }

  String? validatePhone(String? value) {
    if (value == null || value.isEmpty) {
      return 'Phone number is required';
    } else if (value.length != 10) {
      return 'Enter a valid phone number';
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    } else if (value.length < 6) {
      return 'Password must be at least 6 characters long';
    }
    return null;
  }

  String? validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Confirm your password';
    } else if (value != passwordController.text) {
      return 'Passwords do not match';
    }
    return null;
  }
}
