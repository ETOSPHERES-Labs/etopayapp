import 'package:eto_pay/providers/user_provider.dart';
import 'package:eto_pay/screens/home_and_inner_pages/swap_shell/crypto_swap_widget.dart';
import 'package:eto_pay/screens/home_and_inner_pages/widgets/top_bar.dart';
import 'package:eto_pay/screens/home_and_inner_pages/widgets/top_bar_blue_background.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SwapShellScreen extends ConsumerStatefulWidget {
  const SwapShellScreen({super.key});

  @override
  ConsumerState<SwapShellScreen> createState() => _SwapShellScreenState();
}

class _SwapShellScreenState extends ConsumerState<SwapShellScreen> {
  @override
  Widget build(BuildContext context) {
    final user = ref.watch(requireUserProvider);
    final preferredNetwork = user.networks.networkFor(user.preferredNetwork);

    return SafeArea(
      child: SingleChildScrollView(
        child: CustomPaint(
          painter: TopBarBlueBackgroundPainter(
              overflow: TopBarBlueBackgroundOverflowLevel.overflowLarge),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TopBar(),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: const [
                    BoxShadow(
                      color: Color.fromARGB(30, 0, 0, 0),
                      blurRadius: 6,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: CryptoSwapWidget(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
