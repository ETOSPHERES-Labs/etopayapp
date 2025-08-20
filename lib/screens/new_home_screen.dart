import 'package:eto_pay/screens/home_shell/homepage_shell_screen.dart';
import 'package:eto_pay/widgets/home_shell/rounded_notched_shape_with_shadow_painter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeShellScreen extends StatefulWidget {
  const HomeShellScreen({super.key});

  @override
  State<HomeShellScreen> createState() => _HomeShellScreenState();
}

class _HomeShellScreenState extends State<HomeShellScreen> {
  int _selectedIndex = 0;

  static const List<Widget> _pages = <Widget>[
    HomePageShellScreen(),
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
        content: const Text('Kliknięto FAB!'),
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
    required IconData icon,
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
          Icon(icon, color: isSelected ? Color(0xFF005CA9) : Colors.grey),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: isSelected ? Color(0xFF005CA9) : Colors.grey,
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
        offset: const Offset(0, 18),
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
                    icon: Icons.home_outlined,
                    label: 'Home',
                    index: 0,
                  ),
                  _buildNavItem(
                    icon: Icons.swap_vert,
                    label: 'Swap',
                    index: 1,
                  ),
                  const SizedBox(width: 48),
                  _buildNavItem(
                    icon: Icons.history,
                    label: 'History',
                    index: 2,
                  ),
                  _buildNavItem(
                    icon: Icons.gavel_outlined,
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
