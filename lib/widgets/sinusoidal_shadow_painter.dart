import 'dart:math';
import 'package:flutter/material.dart';

class SinusoidalShadowPainter extends CustomPainter {
  final double waveWidth;
  final double waveHeight;
  final double shadowHeight;

  SinusoidalShadowPainter({
    this.waveWidth = 170,
    this.waveHeight = 24,
    this.shadowHeight = 16,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Paint shadowPaint = Paint()
      ..color = Colors.black.withOpacity(0.15)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 8);

    final Path path = Path();
    final double top = 0;
    final double width = size.width;
    final double centerX = width / 2;

    final double startX = centerX - waveWidth / 2;
    final double endX = centerX + waveWidth / 2;

    path.moveTo(0, top);
    path.lineTo(startX, top);

    const int steps = 90;
    for (int i = 0; i <= steps; i++) {
      double t = i / steps;
      double x = startX + (endX - startX) * t;
      double localX = t * 2 * pi - pi; // x ∈ [-π, π]
      double y = top + waveHeight * (-1)*sin(localX - pi / 2);
      path.lineTo(x, y);
    }

    path.lineTo(width, top);
    path.lineTo(width, top + shadowHeight);
    path.lineTo(0, top + shadowHeight);
    path.close();

    canvas.drawPath(path, shadowPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
