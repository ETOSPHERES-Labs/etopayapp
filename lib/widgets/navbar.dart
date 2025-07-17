import 'package:flutter/material.dart';
import '../core/colors.dart';

class CustomNavBar extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onItemSelected;
  const CustomNavBar({
    super.key,
    required this.selectedIndex,
    required this.onItemSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        // Background with deeper U shape and gradient border
        CustomPaint(
          size: const Size(double.infinity, 100),
          painter: _NavBarPainter(),
        ),
        SizedBox(
          height: 80,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _NavBarItem(
                icon: Icons.home_filled,
                label: 'Home',
                selected: selectedIndex == 0,
                onTap: () => onItemSelected(0),
              ),
              _NavBarItem(
                icon: Icons.swap_horiz,
                label: 'Swap',
                selected: selectedIndex == 1,
                onTap: () => onItemSelected(1),
              ),
              const SizedBox(width: 56), // Space for QR code
              _NavBarItem(
                icon: Icons.history,
                label: 'History',
                selected: selectedIndex == 2,
                onTap: () => onItemSelected(2),
              ),
              _NavBarItem(
                icon: Icons.account_balance,
                label: 'DAO',
                selected: selectedIndex == 3,
                onTap: () => onItemSelected(3),
              ),
            ],
          ),
        ),
        // Central QR code button
        Positioned(
          bottom: 38,
          child: Material(
            elevation: 12,
            shape: const CircleBorder(),
            color: Colors.transparent,
            child: InkWell(
              onTap: () => onItemSelected(4),
              customBorder: const CircleBorder(),
              child: Container(
                width: 54,
                height: 54,
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  border: Border.all(color: AppColors.primary, width: 4),
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primary.withOpacity(0.2),
                      blurRadius: 16,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.qr_code,
                  color: Colors.white,
                  size: 28,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _NavBarItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool selected;
  final VoidCallback onTap;
  const _NavBarItem({
    required this.icon,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 36,
            height: 28,
            decoration: BoxDecoration(
              color: selected ? AppColors.primary : Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: selected ? AppColors.primary : Colors.white,
                width: 2,
              ),
            ),
            child: Icon(
              icon,
              color: selected ? Colors.white : AppColors.primary,
              size: 22,
            ),
          ),
          const SizedBox(height: 4),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
            child: Text(
              label,
              style: TextStyle(
                color: AppColors.primary,
                fontWeight: FontWeight.w600,
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _NavBarPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    // Draw the U shape
    final path = Path();
    final double center = size.width / 2;
    final double radius = 56; // Deeper U
    path.moveTo(0, 0);
    path.lineTo(center - radius - 36, 0);
    path.quadraticBezierTo(center - radius, 0, center - radius + 12, 48);
    path.arcToPoint(
      Offset(center + radius - 12, 48),
      radius: Radius.circular(radius),
      clockwise: false,
    );
    path.quadraticBezierTo(center + radius, 0, center + radius + 36, 0);
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    canvas.drawPath(path, paint);

    // Horizontal gradient border for backlight effect
    final borderPath = Path.from(path);
    final gradient = LinearGradient(
      colors: [
        AppColors.primary.withOpacity(0.0),
        AppColors.primary.withOpacity(0.7),
        AppColors.primary.withOpacity(0.0),
      ],
      stops: const [0.0, 0.5, 1.0],
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
    );
    final rect = Rect.fromLTWH(0, 0, size.width, size.height);
    final borderPaint = Paint()
      ..shader = gradient.createShader(rect)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 6;
    canvas.drawPath(borderPath, borderPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
} 