import 'package:eto_pay/screens/home_shell/home_shell_screen.dart';
import 'package:eto_pay/screens/home_shell/rounded_notched_shape_with_shadow_painter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeAndInnerPagesScreen extends StatefulWidget {
  const HomeAndInnerPagesScreen({super.key});

  @override
  State<HomeAndInnerPagesScreen> createState() =>
      _HomeAndInnerPagesScreenState();
}

class _HomeAndInnerPagesScreenState extends State<HomeAndInnerPagesScreen> {
  int _selectedIndex = 0;

  static const List<Widget> _pages = <Widget>[
    HomeShellScreen(),
    Center(child: Text('Ekran 2')),
    Center(child: Text('Ekran 3')),
    Center(child: Text('Ekran 4')),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _onFabPressed() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        content: const Text('FAB!'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          )
        ],
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
              borderRadius: BorderRadius.circular(16), // <- zaokrąglenie rogów
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
          SizedBox(height: 5,),
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
    return Scaffold(
      body: _pages[_selectedIndex],
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Transform.translate(
        offset: const Offset(0, 22),
        child: SizedBox(
          width: 64,
          height: 64,
          child: FloatingActionButton(
            onPressed: _onFabPressed,
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
            offset: Offset(0, -0),
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
            shape: null,
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
