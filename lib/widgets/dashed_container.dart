import 'dart:math';

import 'package:flutter/material.dart';

class DashedBorderContainer extends StatelessWidget {
  final Widget child;
  final double width;
  final double height;
  final Color backgroundColor;
  final Color borderColor;
  final double strokeWidth;
  final double dashLength;
  final double dashGap;

  const DashedBorderContainer({
    super.key,
    required this.child,
    this.width = double.infinity,
    this.height = 300,
    this.backgroundColor = Colors.white,
    this.borderColor = Colors.black,
    this.strokeWidth = 1,
    this.dashLength = 8,
    this.dashGap = 4,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _DashedBorderPainter(
        color: borderColor,
        strokeWidth: strokeWidth,
        dashLength: dashLength,
        dashGap: dashGap,
      ),
      child: Container(
        width: width,
        height: height,
        color: backgroundColor,
        child: child,
      ),
    );
  }
}

class _DashedBorderPainter extends CustomPainter {
  final Color color;
  final double strokeWidth;
  final double dashLength;
  final double dashGap;

  _DashedBorderPainter({
    required this.color,
    required this.strokeWidth,
    required this.dashLength,
    required this.dashGap,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    // Helper to draw dashed lines on a single edge
    void drawDashedLine(Offset start, Offset end) {
      double dx = end.dx - start.dx;
      double dy = end.dy - start.dy;
      double distance = sqrt(dx * dx + dy * dy);
      final dashCount = (distance / (dashLength + dashGap)).floor();

      final dashVector = Offset(dx / distance, dy / distance);

      for (int i = 0; i < dashCount; i++) {
        final dashStart = start + dashVector * (i * (dashLength + dashGap));
        final dashEnd = dashStart + dashVector * dashLength;
        canvas.drawLine(dashStart, dashEnd, paint);
      }
    }

    // Draw top border
    drawDashedLine(Offset(0, 0), Offset(size.width, 0));
    // Draw right border
    drawDashedLine(Offset(size.width, 0), Offset(size.width, size.height));
    // Draw bottom border
    drawDashedLine(Offset(size.width, size.height), Offset(0, size.height));
    // Draw left border
    drawDashedLine(Offset(0, size.height), Offset(0, 0));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
