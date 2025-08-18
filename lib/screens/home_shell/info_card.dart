import 'package:flutter/material.dart';

class InfoCard extends StatelessWidget {
  const InfoCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity, // dopasuj do szerokości ekranu
      height: 125,
      margin: const EdgeInsets.symmetric(horizontal: 20), // z Figma: left 20
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFFC1E3FF), // #C1E3FF
            Colors.white,
          ],
        ),
        borderRadius: BorderRadius.circular(6),
        boxShadow: const [
          BoxShadow(
            color: Color(0x66000000), // #00000040
            blurRadius: 6,
            offset: Offset(0, 0),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'Shimmer Balance',
            style: TextStyle(
              fontFamily: 'Roboto',
              fontWeight: FontWeight.w600,
              fontSize: 16,
              height: 1.0,
              letterSpacing: -0.24,
              color: Color(0xFF005CA9),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Text(
                '12.325.00,99 SMR',
                style: TextStyle(
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w600,
                  fontSize: 24,
                  height: 1.0,
                  letterSpacing: -0.24,
                  color: Colors.black,
                ),
              ),
              const SizedBox(width: 13),
              Icon(
                Icons.remove_red_eye_outlined,
                size: 20,
                color: Colors.grey[700],
              ),
            ],
          ),

          // 🔽 Trzeci wiersz z ikoną po lewej
          Row(
            children: [
              const Icon(Icons.euro, size: 18, color: Color(0xFF747474)),
              const SizedBox(width: 6),
              const Text(
                '10,88 EURO',
                style: TextStyle(
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w400,
                  fontSize: 16,
                  height: 1.0,
                  letterSpacing: -0.24,
                  color: Color(0xFF747474),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
