import 'package:eto_pay/main.dart';
import 'package:eto_pay/models/network_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NetworkSelector extends StatelessWidget {
  final String selectedNetwork;
  final Map<String, NetworkModel> networks;
  final VoidCallback onTap;

  const NetworkSelector({
    required this.selectedNetwork,
    required this.networks,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final method = networks[selectedNetwork];

    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: const Color(0xFFF0F0F0),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                SvgPicture.asset(
                  method!.icon,
                  width: 24,
                  height: 24,
                ),
                const SizedBox(width: 8),
                Text(
                  networks[selectedNetwork]!.name,
                  style:
                      Theme.of(context).textTheme.displayMedium?.bold().black(),
                ),
              ],
            ),
            Container(
              width: 32,
              height: 32,
              decoration: const BoxDecoration(
                color: Color(0xFF005CA9),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.arrow_forward,
                  size: 18, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
