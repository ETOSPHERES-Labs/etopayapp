import 'package:flutter/material.dart';
import 'router/app_router.dart';
import 'core/logger.dart';

void main() {
  AppLogger.i('App starting...');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'ETOPay App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
        useMaterial3: true,
        fontFamily: 'Poppins',
      ),
      routerConfig: appRouter,
    );
  }
}
