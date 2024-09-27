import 'package:flutter/material.dart';
import 'package:login_signup_ui_starter/theme.dart';

class PrimaryButton extends StatelessWidget {
  final String buttonText;
  final VoidCallback onTap; // เพิ่มพารามิเตอร์ onTap

  PrimaryButton(
      {required this.buttonText, required this.onTap}); // ปรับ constructor

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // ใช้ GestureDetector เพื่อรองรับการกด
      onTap: onTap, // เรียกใช้ onTap เมื่อกดปุ่ม
      child: Container(
        alignment: Alignment.center,
        height: MediaQuery.of(context).size.height * 0.08,
        width: double.infinity,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16), color: kPrimaryColor),
        child: Text(
          buttonText,
          style: textButton.copyWith(color: kWhiteColor),
        ),
      ),
    );
  }
}
