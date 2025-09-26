import 'package:flutter/material.dart';

class BiometricSection extends StatelessWidget {
  final bool isAuthenticating;
  final VoidCallback onAuthenticate;

  const BiometricSection({
    required this.isAuthenticating,
    required this.onAuthenticate,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 48),
        Text(
          'Or use fingerprint',
          style: Theme.of(context)
              .textTheme
              .bodyLarge
              ?.copyWith(color: Colors.black),
        ),
        const SizedBox(height: 72),
        IconButton(
          icon: const Icon(Icons.fingerprint, size: 40),
          onPressed: isAuthenticating ? null : onAuthenticate,
        ),
      ],
    );
  }
}
