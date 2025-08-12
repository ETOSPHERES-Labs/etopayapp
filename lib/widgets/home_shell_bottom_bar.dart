import 'package:flutter/material.dart';

class HomeShellBottomBar extends StatelessWidget {
  final double notchRadius;
  final List<Widget> children;

  const HomeShellBottomBar({
    super.key,
    required this.notchRadius,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: BottomBarPainter(notchRadius: notchRadius),
      child: SizedBox(
        height: 72,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: children,
        ),
      ),
    );
  }
}

class BottomBarPainter extends CustomPainter {
  final double notchRadius;

  BottomBarPainter({required this.notchRadius});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill
      // ..shadowColor = Colors.black.withOpacity(0.25)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 3);

    final path = Path();
    final center = size.width / 2;

    // Start from bottom left
    path.moveTo(0, 0);

    // Line to before curve
    path.lineTo(center - notchRadius * 1.5, 0);

    // Curve down and up (Bezier)
    path.quadraticBezierTo(
      center - notchRadius, notchRadius * 1.5,
      center, notchRadius * 1.5,
    );
    path.quadraticBezierTo(
      center + notchRadius, notchRadius * 1.5,
      center + notchRadius * 1.5, 0,
    );

    // Right edge
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);

    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
