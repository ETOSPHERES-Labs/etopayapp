import 'package:eto_pay/providers/user_provider.dart';
import 'package:eto_pay/screens/kyc_verification_pages/kyc_verification_step_0.dart';
import 'package:eto_pay/screens/profile_creation_pages/terms_and_conditions_screen.dart';
import 'package:eto_pay/screens/home_and_inner_pages/unlock_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DeveloperPanelScreen extends ConsumerWidget {
  const DeveloperPanelScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    // load fake user
    Future.microtask(() { 
      ref.read(userProvider.notifier).fetchUser();
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('🧪 Developer Panel'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => const TermsAndConditionsScreen()),
                );
              },
              child: const Text('Go to: Profile creation pages'),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => const KycVerificationStep0Screen()),
                );
              },
              child: const Text('Go to: KYC Verification pages'),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const UnlockScreen()),
                );
              },
              child: const Text('Go to: Home and inner pages'),
            ),
            const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }
}
