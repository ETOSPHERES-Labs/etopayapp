import 'package:eto_pay/screens/home_and_inner_pages/buy_screen.dart';
import 'package:eto_pay/screens/developer_panel_screen.dart';
import 'package:eto_pay/screens/home_and_inner_pages/home_and_inner_pages_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../screens/profile_creation_pages/choose_network_screen.dart';
import '../screens/profile_creation_pages/terms_and_conditions_screen.dart';
import '../screens/home_and_inner_pages/unlock_screen.dart';
import '../screens/trash/main_home_screen.dart';

final GoRouter appRouter = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      name: 'developer-panel',
      builder: (context, state) => const DeveloperPanelScreen(),
    ),
    GoRoute(
      path: '/home',
      name: 'home',
      builder: (context, state) => const UnlockScreen(),
    ),
    GoRoute(
      path: '/terms',
      name: 'terms',
      builder: (context, state) => const TermsAndConditionsScreen(),
    ),
    GoRoute(
      path: '/choose-network',
      name: 'choose-network',
      builder: (context, state) => const ChooseNetworkScreen(),
    ),
    GoRoute(
      path: '/main-home',
      name: 'main-home',
      builder: (context, state) => const MainHomeScreen(),
    ),
    GoRoute(
      path: '/home-and-inner-pages',
      name: 'home-and-inner-pages',
      builder: (context, state) => const HomeAndInnerPagesScreen(),
    ),
    GoRoute(
      path: '/buy-screen',
      name: 'buy-screen',
      builder: (context, state) => const BuyScreen(),
    ),
  ],
  errorBuilder: (context, state) => Scaffold(
    body: Center(child: Text('404: Page not found')),
  ),
);
