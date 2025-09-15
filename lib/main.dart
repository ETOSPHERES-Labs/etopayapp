import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'router/app_router.dart';
import 'core/logger.dart';

void main() {
  AppLogger.i('App starting...');
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);

    return MaterialApp.router(
      title: 'ETOPay App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
        useMaterial3: true,
        fontFamily: "Roboto",// 'Poppins',
        textTheme: TextTheme(
          labelMedium: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            fontFamily: "Roboto"
          ),
          labelSmall: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w400,
            fontFamily: "Roboto"
          ),
          titleLarge: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            fontFamily: "Roboto"
          ), 
          titleMedium: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            fontFamily: "Roboto"
          ), 
          titleSmall: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            fontFamily: "Roboto"
          ), 
          bodyLarge: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w400,
            fontFamily: "Roboto"
          ),
          bodyMedium: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            fontFamily: "Roboto"
          ), 
          displayMedium: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            fontFamily: "Roboto"
          ), 
        ),
      ),
      routerConfig: router,
    );
  }
}

extension TextStyleHelpers on TextStyle {
  TextStyle bold() => copyWith(fontWeight: FontWeight.bold);
  TextStyle gray() => copyWith(color: Color(0xFF747474));
  TextStyle black() => copyWith(color: Color(0xFF000000));
  TextStyle white() => copyWith(color: Color(0xFFFFFFFF));
}
