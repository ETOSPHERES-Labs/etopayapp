import 'package:flutter/material.dart';

class RoundedNotchedShape extends NotchedShape {
  const RoundedNotchedShape();

  @override
  Path getOuterPath(Rect host, Rect? guest) {
    final path = Path();
    final top = host.top;
    final bottom = host.bottom;
    final left = host.left;
    final right = host.right;

    const double plusIconWidth = 106;

    double radius = plusIconWidth / 2.2;
    double qradius = plusIconWidth / 2;

    final double centerOfScreen = host.center.dx;
    double startX = centerOfScreen - 2 * radius;

    double maximum = top;
    double minimum = top + radius + 10;
    double middle = minimum / 2;

    path.moveTo(left, maximum);
    path.lineTo(startX , maximum);

    double point1 = startX + radius;
      path.arcToPoint(Offset(point1+3.5, middle ),
      radius: Radius.circular(qradius),
        clockwise: true,
    );

    double point2 = point1 - 2 + 2 * radius;
    path.arcToPoint(
      Offset(point2, middle),
      radius: Radius.circular(radius),
      clockwise: false,
    );

    double point3 = point2 + radius;

    path.arcToPoint(Offset(point3-3.5, maximum),
    radius: Radius.circular(qradius),
      clockwise: true,
    );

    path.lineTo(right, top);
    path.lineTo(right, bottom);
    path.lineTo(left, bottom);
    path.close();

    return path;
  }
}
