import 'package:eto_pay/main.dart';
import 'package:flutter/material.dart';

class BalanceInfoCard extends StatelessWidget {
  final String networkName;
  final String networkSymbol;
  final double amount;
  final double fiatConversionRate;
  final String fiatSymbol;

  const BalanceInfoCard(
      {super.key,
      required this.networkName,
      required this.networkSymbol,
      required this.amount,
      required this.fiatConversionRate,
      required this.fiatSymbol});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 125,
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFFC1E3FF),
            Colors.white,
          ],
        ),
        borderRadius: BorderRadius.circular(6),
        boxShadow: const [
          BoxShadow(
            color: Color(0x66000000),
            blurRadius: 6,
            offset: Offset(0, 0),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '$networkName Balance',
            style: Theme.of(context).textTheme.displayMedium?.blue().copyWith(
                  letterSpacing: -0.24,
                ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                '$amount $networkSymbol',
                style: Theme.of(context).textTheme.displayLarge?.copyWith(
                      letterSpacing: -0.24,
                    ),
              ),
              const SizedBox(width: 13),
              Icon(
                Icons.remove_red_eye_outlined,
                size: 28,
                color: const Color.fromARGB(255, 0, 0, 0),
              ),
            ],
          ),
          Row(
            children: [
              const Icon(Icons.euro, size: 18, color: Color(0xFF747474)),
              const SizedBox(width: 6),
              Text(
                '${amount * fiatConversionRate} $fiatSymbol',
                style: Theme.of(context).textTheme.bodyMedium?.gray().copyWith(
                      letterSpacing: -0.24,
                    ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
