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
  final double borderRadius;

  const DashedBorderContainer({
    super.key,
    required this.child,
    this.width = double.infinity,
    this.height = 300,
    this.backgroundColor = Colors.white,
    this.borderColor = const Color(0xFF747474),
    this.strokeWidth = 1,
    this.dashLength = 16,
    this.dashGap = 14,
    this.borderRadius = 6,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _DashedBorderPainter(
        color: borderColor,
        strokeWidth: strokeWidth,
        dashLength: dashLength,
        dashGap: dashGap,
        borderRadius: borderRadius,
      ),
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(borderRadius),
        ),
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
  final double borderRadius;

  _DashedBorderPainter({
    required this.color,
    required this.strokeWidth,
    required this.dashLength,
    required this.dashGap,
    required this.borderRadius,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    final rect = Rect.fromLTWH(0, 0, size.width, size.height);
    final rrect = RRect.fromRectAndRadius(rect, Radius.circular(borderRadius));
    final path = Path()..addRRect(rrect);

    for (final metric in path.computeMetrics()) {
      double distance = 0.0;
      while (distance < metric.length) {
        final next = (distance + dashLength).clamp(0.0, metric.length);
        final extractPath = metric.extractPath(distance, next);
        canvas.drawPath(extractPath, paint);
        distance += dashLength + dashGap;
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
