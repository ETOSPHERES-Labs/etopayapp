import 'package:eto_pay/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ReceiveSendFundsSection extends StatelessWidget {
  final String networkAddress;

  const ReceiveSendFundsSection({super.key, required this.networkAddress});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Receive Funds',
            style: Theme.of(context).textTheme.displayMedium?.copyWith(
              letterSpacing: -0.24,
            ),
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: BoxDecoration(
              color: const Color(0xFFF0F0F0),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Row(
              children: [
                const Icon(Icons.qr_code_2, size: 48, color: Colors.black),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    networkAddress,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: Theme.of(context).textTheme.bodyMedium?.gray().copyWith(
                      letterSpacing: -0.24,
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.copy,
                      size: 24, color: Color.fromARGB(255, 49, 49, 49)),
                  onPressed: () {
                    Clipboard.setData(ClipboardData(text: networkAddress));
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Skopiowano adres')),
                    );
                  },
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),
          InkWell(
            onTap: () {
            },
            borderRadius: BorderRadius.circular(6),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              decoration: BoxDecoration(
                color: const Color(0xFFF0F0F0),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Row(
                children: [
                  SvgPicture.asset(
                    'assets/icons/icon_send_crypto.svg',
                    width: 32,
                    height: 32,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      "Send Crypto",
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                  Container(
                    width: 32,
                    height: 32,
                    decoration: const BoxDecoration(
                      color: Color(0xFF005CA9),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.arrow_forward_ios_rounded,
                      size: 16,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
