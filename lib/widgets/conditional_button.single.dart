import 'package:flutter/material.dart';

class ConditionalSingleButton extends StatelessWidget {
  final bool isActive;
  final VoidCallback onPressed;
  final String text;

  const ConditionalSingleButton({
    super.key,
    required this.isActive,
    required this.onPressed,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        backgroundColor: isActive ? Color(0xFF005CA9) : Color(0x80005CA9),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6),
        ),
        foregroundColor: Colors.white,
        disabledForegroundColor: Colors.white,
        side: BorderSide(color: Colors.transparent),
      ),
      onPressed: isActive ? onPressed : null,
      child: Text(text),
    );
  }
}
