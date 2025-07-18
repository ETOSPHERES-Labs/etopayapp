import 'package:flutter/material.dart';

class StepProgressBar extends StatelessWidget {
  final int currentStep;

  StepProgressBar({required this.currentStep});

  final int totalSteps = 4;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(totalSteps * 2 - 1, (index) {
        if (index.isEven) {
          int stepIndex = index ~/ 2 + 1;
          bool isCompleted = stepIndex < currentStep;
          bool isCurrent = stepIndex == currentStep;

          Color bgColor = isCompleted
              ? Color(0xFF028032)
              : isCurrent
                  ? Color(0xFF005CA9)
                  : Color(0xFFE6EFF7);

          return Expanded(
            flex: 2,
            child: CircleAvatar(
              radius: 16, 
              backgroundColor: bgColor,
              child: isCompleted
                  ? Icon(Icons.check, color: Colors.white, size: 18)
                  : Text(
                      '$stepIndex',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
            ),
          );
        } else {
          int stepLineIndex = (index - 1) ~/ 2 + 1;
          bool isCompleted = stepLineIndex < currentStep;

          return Expanded(
            flex: 3,
            child: Container(
              height: 4,
              color: isCompleted ? Color(0xFF028032) : Color(0xFFE6EFF7),
            ),
          );
        }
      }),
    );
  }
}
