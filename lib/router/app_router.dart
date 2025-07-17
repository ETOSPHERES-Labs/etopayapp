import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../screens/choose_network_screen.dart';
import '../screens/terms_and_conditions_screen.dart';
import '../screens/home_screen.dart';
import '../screens/main_home_screen.dart';

final GoRouter appRouter = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      name: 'home',
      builder: (context, state) => const HomeScreen(),
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
  ],
  errorBuilder: (context, state) => Scaffold(
    body: Center(child: Text('404: Page not found')),
  ),
);
