import 'package:eto_pay/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Notifications',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Color(0xFF005CA9),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              'assets/images/no_new_notifications.svg',
              height: 140,
            ),
            const SizedBox(height: 48),
            Text(
              'No new notifications',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyLarge?.black(),
            ),
            const SizedBox(height: 18),
            Text(
              'There are currently no new notifications.',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium?.gray(),
            ),
          ],
        ),
      ),
    );
  }
}
