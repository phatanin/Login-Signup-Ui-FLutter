import 'package:flutter/material.dart';
import 'package:login_signup_ui_starter/screens/login.dart';
import 'package:login_signup_ui_starter/theme.dart';
import 'package:login_signup_ui_starter/widgets/checkbox.dart';
import 'package:login_signup_ui_starter/widgets/signup_form.dart';

class SignUpScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 70),
            Padding(
              padding: kDefaultPadding,
              child: Text('Create Account', style: titleText),
            ),
            SizedBox(height: 5),
            Padding(
              padding: kDefaultPadding,
              child: Row(
                children: [
                  Text('Already a member?', style: subTitle),
                  SizedBox(width: 5),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LogInScreen()));
                    },
                    child: Text(
                      'Log In',
                      style: textButton.copyWith(
                        decoration: TextDecoration.underline,
                        decorationThickness: 1,
                      ),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: kDefaultPadding,
              child: SignUpForm(),
            ),
            SizedBox(height: 20),
            Padding(
              padding: kDefaultPadding,
              child: CustomCheckBox(text: 'Agree to terms and conditions.'),
            ),
            SizedBox(height: 20),
            Padding(
              padding: kDefaultPadding,
              child: CustomCheckBox(text: 'I have at least 18 years old.'),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
