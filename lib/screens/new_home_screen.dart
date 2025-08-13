import 'package:eto_pay/widgets/custom_notched_share.dart';
import 'package:eto_pay/widgets/rounded_notched_share.dart';
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
    Center(child: Text('Ekran 1')),
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
            backgroundColor: const Color(0xFF005CA9), //#005CA9
            foregroundColor: Colors.white,
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
          BottomAppBar(
            shape: const RoundedNotchedShape(),
            elevation: 8,
            child: SizedBox(
              height: 60,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  IconButton(
                    icon: Icon(
                      Icons.home,
                      color: _selectedIndex == 0 ? Colors.blue : Colors.grey,
                    ),
                    onPressed: () => _onItemTapped(0),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.search,
                      color: _selectedIndex == 1 ? Colors.blue : Colors.grey,
                    ),
                    onPressed: () => _onItemTapped(1),
                  ),
                  const SizedBox(width: 48),
                  IconButton(
                    icon: Icon(
                      Icons.notifications,
                      color: _selectedIndex == 2 ? Colors.blue : Colors.grey,
                    ),
                    onPressed: () => _onItemTapped(2),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.person,
                      color: _selectedIndex == 3 ? Colors.blue : Colors.grey,
                    ),
                    onPressed: () => _onItemTapped(3),
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
