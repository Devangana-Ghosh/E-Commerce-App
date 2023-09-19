import 'package:flutter/material.dart';

class CustomInput extends StatelessWidget {
  final String hintText;
  final bool isPassword; // Add this parameter

  CustomInput({
    required this.hintText,
    this.isPassword = false, // Provide a default value
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        vertical: 8.0,
        horizontal: 24.0,
      ),
      decoration: BoxDecoration(
        color: Color(0XFFF2F2F2),
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: TextField(
        obscureText: isPassword, // Use the isPassword parameter
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: hintText ?? "HintText",
          contentPadding: EdgeInsets.symmetric(
            horizontal: 24.0,
            vertical: 20.0,
          ),
        ),
        style: Constants.regularDarkText,
      ),
    );
  }
}
class Constants {
  static final TextStyle regularDarkText = TextStyle(
    fontSize: 16.0,
    color: Colors.black, // Customize the color as needed
    fontWeight: FontWeight.normal,
  );
}

