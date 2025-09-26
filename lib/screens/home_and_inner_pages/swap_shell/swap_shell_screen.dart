import 'package:eto_pay/main.dart';
import 'package:eto_pay/providers/user_provider.dart';
import 'package:eto_pay/screens/home_and_inner_pages/swap_shell/crypto_swap_widget.dart';
import 'package:eto_pay/screens/home_and_inner_pages/widgets/top_bar.dart';
import 'package:eto_pay/screens/home_and_inner_pages/widgets/top_bar_blue_background.dart';
import 'package:eto_pay/widgets/blue_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SwapShellScreen extends ConsumerStatefulWidget {
  const SwapShellScreen({super.key});

  @override
  ConsumerState<SwapShellScreen> createState() => _SwapShellScreenState();
}

class _SwapShellScreenState extends ConsumerState<SwapShellScreen> {
  String? selectedFromId;
  String? selectedToId;

  void _handleFromChanged(String id) {
    setState(() {
      selectedFromId = id;
    });
  }

  void _handleToChanged(String id) {
    setState(() {
      selectedToId = id;
    });
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(requireUserProvider);
    final fromNetwork = user.networks.networkFor(selectedFromId ?? "1");
    final toNetwork = user.networks.networkFor(selectedToId ?? "2");

    return SafeArea(
      child: SingleChildScrollView(
        child: CustomPaint(
          painter: TopBarBlueBackgroundPainter(
            overflow: TopBarBlueBackgroundOverflowLevel.overflowLarge,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TopBar(),
              Container(
                width: double.infinity,
                margin: const EdgeInsets.symmetric(horizontal: 20),
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(6),
                  boxShadow: const [
                    BoxShadow(
                      color: Color.fromARGB(30, 0, 0, 0),
                      blurRadius: 6,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: CryptoSwapWidget(
                  networks: user.networks,
                  onFromChanged: _handleFromChanged,
                  onToChanged: _handleToChanged,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                width: double.infinity,
                margin: const EdgeInsets.symmetric(horizontal: 20),
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(6),
                  boxShadow: const [
                    BoxShadow(
                      color: Color.fromARGB(30, 0, 0, 0),
                      blurRadius: 6,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        _buildRowItem("Rate",
                            "0 ${fromNetwork?.symbol} = 0 ${toNetwork?.symbol}"),
                        const SizedBox(height: 8),
                        _buildRowItem("Inverse rate",
                            "0 ${fromNetwork?.symbol} = 0 ${toNetwork?.symbol}"),
                        const SizedBox(height: 8),
                        _buildRowItem("Gas fee",
                            "0 ${toNetwork?.symbol} (${toNetwork?.amount.toString()})"),
                      ],
                    )),
              ),
              SizedBox(
                height: 60,
              ),
              BlueButton(
                text: 'Swap',
                onPressed: () {
                  showSwapRestrictedDialog(context);
                },
              ),
              SizedBox(
                height: 20,
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRowItem(String left, String right) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          left,
          style: Theme.of(context).textTheme.bodyMedium?.gray(),
        ),
        Text(
          right,
          style: Theme.of(context).textTheme.bodyMedium?.black(),
        ),
      ],
    );
  }

  void showSwapRestrictedDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.white,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          insetPadding: const EdgeInsets.symmetric(horizontal: 32),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SvgPicture.asset(
                  'assets/images/404.svg',
                  width: 120,
                  height: 120,
                ),
                const SizedBox(height: 24),
                Text(
                  'This Swap future works only viviswap users',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyMedium?.black(),
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: 90,
                  child: ElevatedButton(
                    onPressed: () => Navigator.of(context).pop(),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      'Close',
                      style: Theme.of(context).textTheme.bodyMedium?.white(),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
