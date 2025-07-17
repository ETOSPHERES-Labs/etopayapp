import 'package:flutter/material.dart';
import '../widgets/navbar.dart';

class MainHomeScreen extends StatefulWidget {
  const MainHomeScreen({super.key});

  @override
  State<MainHomeScreen> createState() => _MainHomeScreenState();
}

class _MainHomeScreenState extends State<MainHomeScreen> {
  int _selectedIndex = 0;

  void _onNavBarTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
    // TODO: Handle navigation for each tab
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Text(
          'Main Home Screen',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 0),
        child: CustomNavBar(
          selectedIndex: _selectedIndex,
          onItemSelected: _onNavBarTap,
        ),
      ),
    );
  }
} 