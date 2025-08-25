import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BuySellBridgeButtonsRow extends StatelessWidget {
  const BuySellBridgeButtonsRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Buying & Selling Funds',
            style: TextStyle(
              fontFamily: 'Roboto',
              fontWeight: FontWeight.w600,
              fontSize: 16,
              height: 1.0,
              letterSpacing: -0.24,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 12),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _ActionButton(
                  icon: SvgPicture.asset(
                    'assets/icons/icon_euro.svg',
                    width: 22,
                    height: 22,
                  ),
                  label: 'Buy',
                  color: const Color(0xFF028032),
                ),
                const SizedBox(width: 16),
                _ActionButton(
                  icon: SvgPicture.asset(
                    'assets/icons/icon_cash.svg',
                    width: 22,
                    height: 22,
                  ),
                  label: 'Sell',
                  color: const Color(0xFFB20F00),
                ),
                const SizedBox(width: 16),
                _ActionButton(
                  icon: SvgPicture.asset(
                    'assets/icons/icon_bridge.svg',
                    width: 22,
                    height: 22,
                  ),
                  label: 'Bridge',
                  color: const Color(0xFF005CA9),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  final SvgPicture icon;
  final String label;
  final Color color;

  const _ActionButton({
    required this.icon,
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 130,
      height: 42,
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6),
          ),
          elevation: 0,
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            icon,
            const SizedBox(width: 10),
            Text(
              label,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.normal,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
