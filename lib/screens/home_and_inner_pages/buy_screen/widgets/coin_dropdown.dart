import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CoinDropdown extends StatelessWidget {
  final List<Map<String, String>> items;
  final String selectedSymbol;
  final ValueChanged<String?> onChanged;

  const CoinDropdown({
    required this.items,
    required this.selectedSymbol,
    required this.onChanged,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: selectedSymbol,
      decoration: InputDecoration(
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      ),
      icon: const Icon(Icons.keyboard_arrow_down),
      isExpanded: true,
      onChanged: onChanged,
      items: items.map((item) {
        return DropdownMenuItem<String>(
          value: item['symbol'],
          child: Row(
            children: [
              SvgPicture.asset(
                item['icon']!,
                width: 24,
                height: 24,
                colorFilter: item['paint_in_gray'] != null
                    ? const ColorFilter.mode(Color(0xFF747474), BlendMode.srcIn)
                    : null,
              ),
              const SizedBox(width: 12),
              Text(item['name']!),
              const Spacer(),
              Text(
                item['symbol']!,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}
