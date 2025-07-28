import 'package:flutter/material.dart';
import 'package:eto_pay/widgets/conditional_button.single.dart';

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
    const double continueButtonHeight = 64;

    return Container(
      height: continueButtonHeight,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ConditionalSingleButton(
            isActive: isEnabled,
            onPressed: onPressed,
            text: text,
          )
        ],
      ),
    );
  }
}
