import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CryptoAddressSection extends StatelessWidget {
  const CryptoAddressSection({super.key});

  final String address = 'fr5579u2jtgboi290-1jkf90eidcfdhbskdjowle456kfdj';

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          // 🔹 Nagłówek
          const Text(
            'Receive Funds',
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

          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: BoxDecoration(
              color: const Color(0xFFF0F0F0), // jasny szary
              borderRadius: BorderRadius.circular(6),
            ),
            child: Row(
              children: [
                // 📷 Ikonka QR
                const Icon(Icons.qr_code_2, size: 48, color: Colors.black),

                const SizedBox(width: 12),

                // 🔤 Adres krypto + ikona kopiowania
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Wrap(
                        spacing: 4,
                        children: [
                          Text(
                            _splitAddress(address),
                            style: const TextStyle(
                              fontSize: 14,
                              color: Color(0xFF747474),
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.w400,
                              letterSpacing: -0.24,
                            ),
                          ),
                          // 📋 Ikona kopiuj
                          IconButton(
                            icon: const Icon(Icons.copy,
                                size: 24,
                                color: Color.fromARGB(255, 49, 49, 49)),
                            onPressed: () {
                              Clipboard.setData(ClipboardData(text: address));
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text('Skopiowano adres')),
                              );
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                // 🔵 Okrągły niebieski z białym >
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
          const SizedBox(height: 16),
          InkWell(
            onTap: () {
              // Akcja po kliknięciu całego prostokąta
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
                  const Icon(Icons.move_down_outlined,
                      size: 48, color: Colors.black),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Wrap(
                          spacing: 4,
                          children: [
                            Text(
                              "Send Crypto",
                              style: const TextStyle(
                                fontSize: 14,
                                color: Color.fromARGB(255, 0, 0, 0),
                                fontFamily: 'Roboto',
                                fontWeight: FontWeight.w500,
                                letterSpacing: -0.24,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  // 🔵 Okrągły niebieski z białym >
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
        ]));
  }

  /// Pomocnicza funkcja do łamania adresu co 24 znaki (z dodaniem znaku nowej linii)
  static String _splitAddress(String address) {
    final buffer = StringBuffer();
    for (int i = 0; i < address.length; i += 24) {
      buffer.write(address.substring(
          i, i + 24 > address.length ? address.length : i + 24));
      if (i + 24 < address.length) buffer.write('\n');
    }
    return buffer.toString();
  }
}
