import 'package:eto_pay/widgets/home_shell/rounded_notched_shape.dart';
import 'package:flutter/material.dart';

class RoundedNotchedShapeWithShadowPainter extends CustomPainter {
  final Rect host;
  final Rect? guest;

  RoundedNotchedShapeWithShadowPainter({required this.host, this.guest});

  @override
  void paint(Canvas canvas, Size size) {
    final notchedShape = RoundedNotchedShape();
    final path = notchedShape.getOuterPath(host, guest);

    canvas.drawShadow(path, const Color.fromARGB(255, 44, 160, 255), 20.0, true);
    canvas.drawShadow(path, const Color.fromARGB(255, 44, 160, 255), 30.0, true);

    final paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
