import 'package:eto_pay/providers/user_provider.dart';
import 'package:eto_pay/screens/home_and_inner_pages/history_shell/history_shell_screen.dart';
import 'package:eto_pay/screens/home_and_inner_pages/home_shell/home_shell_screen.dart';
import 'package:eto_pay/screens/home_and_inner_pages/home_shell/rounded_notched_shape_with_shadow_painter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeAndInnerPagesScreen extends ConsumerStatefulWidget {
  const HomeAndInnerPagesScreen({super.key});

  @override
  ConsumerState<HomeAndInnerPagesScreen> createState() =>
      _HomeAndInnerPagesScreenState();
}

class _HomeAndInnerPagesScreenState
    extends ConsumerState<HomeAndInnerPagesScreen> {
  int _selectedIndex = 0;

  static const List<Widget> _pages = <Widget>[
    HomeShellScreen(),
    Center(child: Text('Screen 2')),
    HistoryShellScreen(),
    Center(child: Text('Screen 4')),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _onFabPressed(String address) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          insetPadding:
              const EdgeInsets.symmetric(horizontal: 40, vertical: 40),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(44, 24, 44, 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'QR Code',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close_outlined),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                ClipRRect(
                  borderRadius: BorderRadius.circular(6),
                  child: Container(
                    width: double.infinity,
                    height: 300,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 1),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Image.asset(
                      'assets/images/qr_code.png',
                      fit: BoxFit.scaleDown,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF0F0F0),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    address,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                    ),
                    softWrap: true,
                  ),
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildActionButton(
                      icon: Icons.share,
                      label: 'Share',
                      onPressed: () {},
                    ),
                    _buildActionButton(
                      icon: Icons.copy,
                      label: 'Copy',
                      onPressed: () {},
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required VoidCallback onPressed,
  }) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon, color: Colors.white, size: 20),
      label: Text(
        label,
        style: const TextStyle(color: Colors.white),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF005CA9),
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }

  Widget _buildNavItem({
    required String assetPath,
    required String label,
    required int index,
  }) {
    final isSelected = _selectedIndex == index;

    return InkWell(
      onTap: () => _onItemTapped(index),
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      hoverColor: Colors.transparent,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 40,
            height: 28,
            decoration: BoxDecoration(
              color: isSelected ? const Color(0xFF005CA9) : Colors.transparent,
              borderRadius: BorderRadius.circular(16),
            ),
            alignment: Alignment.center,
            child: SvgPicture.asset(
              assetPath,
              width: 24,
              height: 24,
              colorFilter: ColorFilter.mode(
                isSelected ? Colors.white : const Color(0xFF747474),
                BlendMode.srcIn,
              ),
            ),
          ),
          const SizedBox(height: 5),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: isSelected ? const Color(0xFF005CA9) : Colors.grey,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(requireUserProvider);
    final preferredNetwork = user.networks.networkFor(user.preferredNetwork);

    return Scaffold(
      body: _pages[_selectedIndex],
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Transform.translate(
        offset: const Offset(0, 22),
        child: SizedBox(
          width: 64,
          height: 64,
          child: FloatingActionButton(
            onPressed: () => _onFabPressed(preferredNetwork?.address ?? ""),
            backgroundColor: const Color(0xFF005CA9),
            foregroundColor: Colors.transparent,
            elevation: 4,
            shape: const CircleBorder(),
            child: SvgPicture.asset(
              'assets/icons/icon_scan.svg',
              width: 40,
              height: 40,
            ),
          ),
        ),
      ),
      bottomNavigationBar: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Transform.translate(
            offset: Offset.zero,
            child: CustomPaint(
              size: Size(MediaQuery.of(context).size.width, 77),
              painter: RoundedNotchedShapeWithShadowPainter(
                host: Rect.fromLTWH(
                  0,
                  0,
                  MediaQuery.of(context).size.width,
                  80,
                ),
                guest: Rect.fromCircle(
                  center: Offset(
                    MediaQuery.of(context).size.width / 2,
                    0,
                  ),
                  radius: 53,
                ),
              ),
            ),
          ),
          BottomAppBar(
            elevation: 0,
            color: Colors.transparent,
            child: SizedBox(
              height: 60,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildNavItem(
                    assetPath: 'assets/icons/icon_home.svg',
                    label: 'Home',
                    index: 0,
                  ),
                  _buildNavItem(
                    assetPath: 'assets/icons/icon_swap.svg',
                    label: 'Swap',
                    index: 1,
                  ),
                  const SizedBox(width: 48),
                  _buildNavItem(
                    assetPath: 'assets/icons/icon_history.svg',
                    label: 'History',
                    index: 2,
                  ),
                  _buildNavItem(
                    assetPath: 'assets/icons/icon_govt.svg',
                    label: 'Govt',
                    index: 3,
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
