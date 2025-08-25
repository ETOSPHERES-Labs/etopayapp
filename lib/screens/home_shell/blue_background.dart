import 'package:flutter/material.dart';

class BlueBackgroundPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final height = 150.0;
    final width = size.width;

    Paint paint = Paint();
    Path mainBackground = Path();
    mainBackground.addRRect(RRect.fromRectAndCorners(
      Rect.fromLTRB(0, 0, width, height),
      topLeft: Radius.zero,
      topRight: Radius.zero,
      bottomLeft: Radius.circular(20),
      bottomRight: Radius.circular(20),
    ));

    paint.color = Color(0xFF005CA9);
    canvas.drawPath(mainBackground, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return oldDelegate != this;
  }
}
