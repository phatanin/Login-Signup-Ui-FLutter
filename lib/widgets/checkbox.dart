import 'package:flutter/material.dart';
import 'package:login_signup_ui_starter/theme.dart';

class CustomCheckBox extends StatefulWidget {
  final String text;
  final Function(bool)? onChanged; // Callback for state change
  final bool initialValue; // To manage the initial state

  const CustomCheckBox({
    required this.text,
    this.onChanged,
    this.initialValue = false,
  });

  @override
  _CustomCheckBoxState createState() => _CustomCheckBoxState();
}

class _CustomCheckBoxState extends State<CustomCheckBox> {
  late bool _isSelected;

  @override
  void initState() {
    super.initState();
    _isSelected = widget.initialValue; // Set initial state
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _isSelected = !_isSelected;
        });
        if (widget.onChanged != null) {
          widget.onChanged!(_isSelected); // Trigger callback
        }
      },
      child: Row(
        children: [
          Container(
            width: 20,
            height: 20,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              border: Border.all(color: kDarkGreyColor),
            ),
            child: _isSelected
                ? Icon(
                    Icons.check,
                    size: 17,
                    color: Colors.green,
                  )
                : null,
          ),
          SizedBox(width: 12),
          Text(widget.text),
        ],
      ),
    );
  }
}
