// custom_button.dart
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const CustomButton({
    required this.text,
    required this.onPressed,

  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(backgroundColor: WidgetStatePropertyAll(Colors.brown[200])),
      onPressed: onPressed,
      child: Text(text),
    );
  }
}
