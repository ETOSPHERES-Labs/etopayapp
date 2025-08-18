import 'package:flutter/material.dart';

class ActionButtonsRow extends StatelessWidget {
  const ActionButtonsRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 🔹 Tytuł nad przyciskami
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

          // 🔘 3 przyciski w jednym wierszu
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: const [
              _ActionButton(
                icon: Icons.euro,
                label: 'Buy',
                color: Color(0xFF028032),
              ),
              const SizedBox(width: 16),
              _ActionButton(
                icon: Icons.stacked_bar_chart_outlined,
                label: 'Sell',
                color: Color(0xFFB20F00),
              ),
              const SizedBox(width: 16),
              _ActionButton(
                icon: Icons.account_balance_wallet_outlined,
                label: 'Bridge',
                color: Color(0xFF005CA9),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  final IconData icon;
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
      width: 111,
      height: 36,
      child: ElevatedButton(
        onPressed: () {
          // obsługa kliknięcia
        },
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
            Icon(icon, size: 16, color: Colors.white),
            const SizedBox(width: 10),
            Text(
              label,
              style: const TextStyle(
                fontSize: 14,
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
