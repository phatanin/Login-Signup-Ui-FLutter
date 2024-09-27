import 'package:flutter/material.dart';
import 'package:login_signup_ui_starter/theme.dart';
import 'package:login_signup_ui_starter/widgets/primary_button.dart';

class LogInForm extends StatefulWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final Function(String email, String password) onLogIn; // Callback function

  LogInForm({
    required this.emailController,
    required this.passwordController,
    required this.onLogIn, // รับ callback function
  });

  @override
  _LogInFormState createState() => _LogInFormState();
}

class _LogInFormState extends State<LogInForm> {
  final _formKey = GlobalKey<FormState>();
  bool _isObscure = true;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey, // เชื่อมกับ GlobalKey เพื่อใช้ตรวจสอบฟอร์ม
      child: Column(
        children: [
          buildInputForm(widget.emailController, 'Email', false, validateEmail),
          buildInputForm(
              widget.passwordController, 'Password', true, validatePassword),
          SizedBox(height: 20),
          PrimaryButton(
            buttonText: 'Log In',
            onTap: () {
              if (_formKey.currentState!.validate()) {
                // ถ้าฟอร์มถูกต้องทั้งหมด สามารถเข้าสู่ระบบได้ที่นี่
                final email = widget.emailController.text.trim();
                final password = widget.passwordController.text.trim();
                widget.onLogIn(email, password); // เรียกใช้ callback function
              } else {
                print("Form is invalid");
              }
            },
          ),
        ],
      ),
    );
  }

  Padding buildInputForm(TextEditingController controller, String label,
      bool pass, String? Function(String?) validator) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5),
      child: TextFormField(
        controller: controller,
        obscureText: pass ? _isObscure : false,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(color: kTextFieldColor),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: kPrimaryColor),
          ),
          suffixIcon: pass
              ? IconButton(
                  onPressed: () {
                    setState(() {
                      _isObscure = !_isObscure;
                    });
                  },
                  icon: _isObscure
                      ? Icon(Icons.visibility_off, color: kTextFieldColor)
                      : Icon(Icons.visibility, color: kPrimaryColor),
                )
              : null,
        ),
        validator: validator, // ฟังก์ชันสำหรับตรวจสอบข้อมูลที่กรอก
      ),
    );
  }

  // ฟังก์ชันตรวจสอบฟิลด์ต่างๆ
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

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    } else if (value.length < 6) {
      return 'Password must be at least 6 characters long';
    }
    return null;
  }
}
