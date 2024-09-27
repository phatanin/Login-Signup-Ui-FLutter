import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:login_signup_ui_starter/theme.dart';
import 'package:login_signup_ui_starter/widgets/primary_button.dart';
import '../screens/login.dart'; // นำเข้า PrimaryButton

class ResetForm extends StatelessWidget {
  final TextEditingController emailController =
      TextEditingController(); // ใช้เพื่อรับอีเมลจากผู้ใช้

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 20),
      child: Column(
        children: [
          TextFormField(
            controller: emailController, // เชื่อมต่อกับ controller
            decoration: InputDecoration(
              hintText: 'Email',
              hintStyle: TextStyle(color: kTextFieldColor),
              focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: kPrimaryColor)),
            ),
          ),
          SizedBox(height: 20),
          PrimaryButton(
            buttonText: 'Reset Password',
            onTap: () async {
              await resetPassword(context);
            },
          ),
        ],
      ),
    );
  }

  Future<void> resetPassword(BuildContext context) async {
    final String email = emailController.text.trim(); // รับอีเมลจากผู้ใช้
    if (email.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please enter your email address')),
      );
      return;
    }

    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Password reset email sent!')),
      );
      // นำทางกลับไปยังหน้าล็อกอิน
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LogInScreen()),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${e.toString()}')),
      );
    }
  }
}
