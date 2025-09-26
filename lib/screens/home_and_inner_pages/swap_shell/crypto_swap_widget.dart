import 'package:eto_pay/main.dart';
import 'package:eto_pay/models/network_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CryptoSwapWidget extends StatefulWidget {
  final NetworksModel networks;
  final void Function(String fromId) onFromChanged;
  final void Function(String toId) onToChanged;

  const CryptoSwapWidget({
    super.key,
    required this.networks,
    required this.onFromChanged,
    required this.onToChanged,
  });

  @override
  State<CryptoSwapWidget> createState() => _CryptoSwapWidgetState();
}

class _CryptoSwapWidgetState extends State<CryptoSwapWidget> {
  String fromId = "";
  String toId = "";

  void _showCurrencyPicker(bool isFrom) async {
    final result = await showModalBottomSheet<Map<String, String>>(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return ListView(
          children: widget.networks.networks.entries.map((entry) {
            final network = entry.value;

            return ListTile(
              leading: SvgPicture.asset(
                network.icon,
                width: 24,
                height: 24,
              ),
              title: Text(
                network.name,
                style: Theme.of(context).textTheme.displayMedium?.bold(),
              ),
              subtitle: Text(
                network.symbol,
                style: Theme.of(context).textTheme.labelMedium,
              ),
              onTap: () => Navigator.pop(context, {
                'id': network.id,
              }),
            );
          }).toList(),
        );
      },
    );

    if (result != null) {
      setState(() {
        if (isFrom) {
          fromId = result["id"]!;
          widget.onFromChanged(fromId);
        } else {
          toId = result["id"]!;
          widget.onToChanged(toId);
        }
      });
    }
  }

  Widget _buildCryptoSection({
    required String label,
    required String id,
    required VoidCallback onSelect,
  }) {
    final network = widget.networks.networkFor(id);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: Theme.of(context).textTheme.titleSmall?.bold().black()),
        const SizedBox(height: 6),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Row(
            children: [
              SvgPicture.asset(
                network?.icon ?? "assets/icons/no_network.svg",
                width: 32,
                height: 32,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        GestureDetector(
                          onTap: onSelect,
                          child: Row(
                            children: [
                              Text(
                                network?.symbol ?? "",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.black()
                                    .bold(),
                              ),
                              const Icon(Icons.keyboard_arrow_down),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        const SizedBox(height: 8),
                        Text(
                          network?.name ?? "",
                          style: Theme.of(context).textTheme.labelMedium?.gray(),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    'Balance : \$0',
                    style: Theme.of(context).textTheme.labelMedium?.gray(),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '€ 0.00',
                    style: Theme.of(context).textTheme.labelSmall?.gray(),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    '\$0 ${network?.symbol ?? ""}',
                    style: Theme.of(context).textTheme.bodyMedium?.black(),
                  ),
                ],
              )
            ],
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    fromId = fromId.isNotEmpty ? fromId : "1";
    toId = toId.isNotEmpty ? toId : "2";
    return Column(
      children: [
        _buildCryptoSection(
          label: 'From',
          id: fromId,
          onSelect: () => _showCurrencyPicker(true),
        ),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Container(
                height: 1,
                color: Color(0xFFE4E4E4),
              ),
            ),
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: Color(0xFFE4E4E4),
                  width: 1,
                ),
              ),
              child: Center(
                child: SvgPicture.asset(
                  'assets/icons/icon_swap2.svg',
                  width: 16,
                  height: 16,
                ),
              ),
            ),
            Expanded(
              child: Container(
                height: 1,
                color: Color(0xFFE4E4E4),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        _buildCryptoSection(
          label: 'To',
          id: toId,
          onSelect: () => _showCurrencyPicker(false),
        ),
      ],
    );
  }
}
