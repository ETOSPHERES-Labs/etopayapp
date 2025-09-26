import 'package:eto_pay/main.dart';
import 'package:eto_pay/screens/home_and_inner_pages/buy_sell_screens/buy_screen/buy_screen.dart';
import 'package:eto_pay/screens/home_and_inner_pages/buy_sell_screens/sell_screen/sell_screen.dart';
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
          Text(
            'Buying & Selling Funds',
            style: Theme.of(context).textTheme.displayMedium?.copyWith(
                  letterSpacing: -0.24,
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
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const BuyScreen(),
                      ),
                    );
                  },
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
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SellScreen(),
                      ),
                    );
                  },
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
                  onPressed: () {},
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
  final VoidCallback onPressed;

  const _ActionButton({
    required this.icon,
    required this.label,
    required this.color,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 130,
      height: 42,
      child: ElevatedButton(
        onPressed: onPressed,
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
              style: Theme.of(context).textTheme.bodyMedium?.white(),
            ),
          ],
        ),
      ),
    );
  }
}
