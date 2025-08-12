import 'package:flutter/material.dart';
import 'dart:math';

class SinusoidalNotchedShape extends NotchedShape {
  const SinusoidalNotchedShape();

  @override
  Path getOuterPath(Rect host, Rect? guest) {
    final path = Path();
    final top = host.top;
    final bottom = host.bottom;
    final left = host.left;
    final right = host.right;

    const double waveWidth = 170; 
    const double waveHeight = 25; 
    final double waveCenterX = host.center.dx;

    final double startX = waveCenterX - waveWidth / 2;
    final double endX = waveCenterX + waveWidth / 2;

    path.moveTo(left, top);

    path.lineTo(startX, top);

    const int steps = 90; 

    for (int i = 0; i <= steps; i++) {
      double t = i / steps; 
      double x = startX + (endX - startX) * t;
      double localX = t * 2 * pi - pi;
      double y = top + waveHeight * sin(localX + pi - pi / 2);
      path.lineTo(x, y + 25);
    }

    path.lineTo(right, top);
    path.lineTo(right, bottom);
    path.lineTo(left, bottom);
    path.close();

    return path;
  }
}
