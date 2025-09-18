import 'package:eto_pay/main.dart';
import 'package:eto_pay/models/network_model.dart';
import 'package:eto_pay/providers/user_provider.dart';
import 'package:eto_pay/widgets/blue_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TopBar extends ConsumerWidget {
  const TopBar({super.key});

  void _showNetworkPickerDialog(
    BuildContext context,
    WidgetRef ref,
    String? selectedNetwork,
    NetworksModel networks,
  ) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          clipBehavior: Clip.antiAlias,
          child: Material(
            color: Colors.white,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Select Network',
                        style: Theme.of(context).textTheme.bodyMedium?.bold(),
                      ),
                      IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: networks.networks.entries.map((entry) {
                      final isSelected = entry.key == selectedNetwork;
                      return InkWell(
                        borderRadius: BorderRadius.circular(12),
                        onTap: () {
                          ref
                              .read(userProvider.notifier)
                              .updatePreferredNetwork(entry.key);
                          Navigator.pop(context);
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 14),
                          margin: const EdgeInsets.symmetric(vertical: 6),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? const Color(0xFFE6F0FF)
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            children: [
                              SvgPicture.asset(
                                entry.value.icon,
                                width: 24,
                                height: 24,
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Text(
                                  entry.value.name,
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                              ),
                              if (isSelected)
                                Container(
                                  width: 24,
                                  height: 24,
                                  decoration: const BoxDecoration(
                                    color: Color(0xFF005CA9),
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(
                                    Icons.check,
                                    color: Colors.white,
                                    size: 16,
                                  ),
                                ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
                const SizedBox(height: 20),
                BlueButton(
                  text: 'Add Network',
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                SizedBox(
                  height: 20,
                )
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(requireUserProvider);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          CircleAvatar(
            radius: 20,
            backgroundImage: AssetImage(user.avatar),
          ),
          const SizedBox(width: 12),
          InkWell(
            onTap: () => _showNetworkPickerDialog(
              context,
              ref,
              user.preferredNetwork,
              user.networks,
            ),
            borderRadius: BorderRadius.circular(8),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (user.preferredNetwork != null)
                    Padding(
                      padding: const EdgeInsets.only(right: 6),
                      child: SvgPicture.asset(
                        user.networks.iconFor(user.preferredNetwork),
                        width: 20,
                        height: 20,
                      ),
                    ),
                  const SizedBox(width: 4),
                  Text(
                    user.networks.nameFor(user.preferredNetwork) ??
                        'Select Network',
                    style: Theme.of(context).textTheme.bodyMedium?.white(),
                  ),
                  const SizedBox(width: 4),
                  const Icon(Icons.keyboard_arrow_down_rounded,
                      size: 20, color: Colors.white),
                ],
              ),
            ),
          ),
          const Spacer(),
          Stack(
            alignment: Alignment.topRight,
            children: [
              IconButton(
                icon: const Icon(Icons.notifications_none,
                    color: Colors.white, size: 32),
                onPressed: () {
                  // Notification logic
                },
              ),
              if (user.unreadNotifications > 0)
                Positioned(
                  right: 6,
                  top: 12,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                    constraints: const BoxConstraints(
                      minWidth: 18,
                      minHeight: 18,
                    ),
                    child: Text(
                      '${user.unreadNotifications}',
                      style: Theme.of(context)
                          .textTheme
                          .labelSmall
                          ?.white()
                          .bold(),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
