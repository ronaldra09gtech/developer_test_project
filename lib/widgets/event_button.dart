import 'package:flutter/material.dart';

class EventButton extends StatelessWidget {
  final String buttonText;
  final VoidCallback onPressed;

  const EventButton({super.key, required this.buttonText, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
        onPressed: onPressed,
        child: Text(buttonText),
      ),
    );
  }
}
