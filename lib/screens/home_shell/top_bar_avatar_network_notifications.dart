import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TopBarAvatarNetworkNotifications extends StatelessWidget {
  final String selectedNetwork;
  final Map<String, String> networkIcons;
  final int notificationsCount;
  final VoidCallback onNetworkTap;

  const TopBarAvatarNetworkNotifications({
    super.key,
    required this.selectedNetwork,
    required this.networkIcons,
    required this.notificationsCount,
    required this.onNetworkTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          const CircleAvatar(
            radius: 20,
            backgroundImage: AssetImage('assets/images/avatar.png'),
          ),
          const SizedBox(width: 12),
          InkWell(
            onTap: onNetworkTap,
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
                  if (networkIcons[selectedNetwork] != null)
                    Padding(
                      padding: const EdgeInsets.only(right: 6),
                      child: SvgPicture.asset(
                        networkIcons[selectedNetwork]!,
                        width: 20,
                        height: 20,
                      ),
                    ),
                  const SizedBox(width: 4),
                  Text(
                    selectedNetwork,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                    ),
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
                onPressed: () {},
              ),
              if (notificationsCount > 0)
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
                      '$notificationsCount',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 8,
                        fontWeight: FontWeight.bold,
                      ),
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
