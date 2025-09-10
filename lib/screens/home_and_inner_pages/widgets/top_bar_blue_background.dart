import 'package:flutter/material.dart';

enum TopBarBlueBackgroundOverflowLevel {
  small,
  overflow,
  overflowLarge
}

double overflowLevelToHeight(TopBarBlueBackgroundOverflowLevel overflow) {
  switch (overflow) {
    case TopBarBlueBackgroundOverflowLevel.small:
      return 75.0;
    case TopBarBlueBackgroundOverflowLevel.overflow:
      return 150.0;
    case TopBarBlueBackgroundOverflowLevel.overflowLarge:
      return 350.0;
  }
}

bool overflowLevelToRoundedCorners(TopBarBlueBackgroundOverflowLevel overflow) {
  if(overflow == TopBarBlueBackgroundOverflowLevel.small) {
      return false;
  }
  return true;
}

class TopBarBlueBackgroundPainter extends CustomPainter {
  final TopBarBlueBackgroundOverflowLevel overflow;

  TopBarBlueBackgroundPainter({this.overflow = TopBarBlueBackgroundOverflowLevel.small});

  @override
  void paint(Canvas canvas, Size size) {
    final height = overflowLevelToHeight(overflow);
    final width = size.width;

    Paint paint = Paint();
    Path mainBackground = Path();

    mainBackground.addRRect(RRect.fromRectAndCorners(
      Rect.fromLTRB(0, 0, width, height),
      topLeft: Radius.zero,
      topRight: Radius.zero,
      bottomLeft: overflowLevelToRoundedCorners(overflow) ? Radius.circular(20) : Radius.zero,
      bottomRight: overflowLevelToRoundedCorners(overflow) ? Radius.circular(20) : Radius.zero,
    ));

    paint.color = Color(0xFF005CA9);
    canvas.drawPath(mainBackground, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return oldDelegate != this;
  }
}
