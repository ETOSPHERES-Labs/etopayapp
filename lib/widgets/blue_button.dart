import 'package:flutter/material.dart';

class BlueButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Widget? leftIcon;
  final Widget? rightIcon;
  final bool isActive;
  final Color activeColor;
  final Color inactiveColor;
  final Color foregroundColor;
  final Color disabledForegroundColor;
  final TextStyle? textStyle;
  final double height;
  final double borderRadius;
  final EdgeInsetsGeometry padding;

  const BlueButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.leftIcon,
    this.rightIcon,
    this.isActive = true,
    this.activeColor = const Color(0xFF005CA9),
    this.inactiveColor = const Color(0x80005CA9),
    this.foregroundColor = Colors.white,
    this.disabledForegroundColor = Colors.white,
    this.textStyle,
    this.height = 44,
    this.borderRadius = 6,
    this.padding = const EdgeInsets.fromLTRB(16, 0, 16, 0),
  });

  @override
  Widget build(BuildContext context) {
    final bgColor = isActive ? activeColor : inactiveColor;
    final effectiveTextStyle = textStyle ??
        Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: foregroundColor,
            );

    return Padding(
      padding: padding,
      child: SizedBox(
        width: double.infinity,
        height: height,
        child: ElevatedButton(
          onPressed: isActive ? onPressed : null,
          style: ElevatedButton.styleFrom(
            backgroundColor: bgColor,
            foregroundColor: foregroundColor,
            disabledForegroundColor: disabledForegroundColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 16),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (leftIcon != null) ...[
                leftIcon!,
                const SizedBox(width: 8),
              ],
              Text(text, style: effectiveTextStyle),
              if (rightIcon != null) ...[
                const SizedBox(width: 8),
                rightIcon!,
              ],
            ],
          ),
        ),
      ),
    );
  }
}
