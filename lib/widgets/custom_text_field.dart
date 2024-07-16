// custom_text_field.dart
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  final bool isPassword;
  final Icon? icon; // New icon parameter

  CustomTextField({
    required this.label,
    this.isPassword = false,
    this.icon, // Initialize icon parameter
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        labelText: label,
        icon: icon, // Use the icon here
      ),
      obscureText: isPassword,
    );
  }
}

