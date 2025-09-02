import 'package:flutter/material.dart';

class TopBarBlueBackgroundPainter extends CustomPainter {
  final bool overflow;

  TopBarBlueBackgroundPainter({this.overflow = false});

  @override
  void paint(Canvas canvas, Size size) {
    final height = overflow ? 150.0 : 75.0;
    final width = size.width;

    Paint paint = Paint();
    Path mainBackground = Path();

    mainBackground.addRRect(RRect.fromRectAndCorners(
      Rect.fromLTRB(0, 0, width, height),
      topLeft: Radius.zero,
      topRight: Radius.zero,
      bottomLeft: overflow ? Radius.circular(20) : Radius.zero,
      bottomRight: overflow ? Radius.circular(20) : Radius.zero,
    ));

    paint.color = Color(0xFF005CA9);
    canvas.drawPath(mainBackground, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return oldDelegate != this;
  }
}
