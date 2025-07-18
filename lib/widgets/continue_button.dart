import 'package:flutter/material.dart';
import 'package:eto_pay/widgets/conditional_button.dart';

class ContinueButtonWidget extends StatelessWidget {
  final bool isEnabled;
  final String text;
  final VoidCallback onPressed;

  const ContinueButtonWidget({
    super.key,
    required this.isEnabled,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    const double _continueButtonHeight = 64;

    return Container(
      height: _continueButtonHeight,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ConditionalButton(
            isActive: isEnabled,
            onPressed: onPressed,
            text: text,
          )
        ],
      ),
    );
  }
}
