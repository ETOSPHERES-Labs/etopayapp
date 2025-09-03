import 'package:eto_pay/providers/user_provider.dart';
import 'package:eto_pay/screens/home_and_inner_pages/widgets/top_bar.dart';
import 'package:eto_pay/screens/home_and_inner_pages/widgets/top_bar_blue_background.dart';
import 'package:flutter/material.dart';
import 'package:eto_pay/screens/home_and_inner_pages/home_shell/buy_sell_bridge_buttons_row.dart';
import 'package:eto_pay/screens/home_and_inner_pages/home_shell/receive_send_funds_section.dart';
import 'package:eto_pay/screens/home_and_inner_pages/home_shell/balance_info_card.dart';
import 'package:eto_pay/screens/home_and_inner_pages/home_shell/tokens_nfts_erc20_tab_section.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeShellScreen extends ConsumerWidget {
  const HomeShellScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(requireUserProvider);
    final preferredNetwork = user.networks.networkFor(user.preferredNetwork);
    
    return SafeArea(
      child: SingleChildScrollView(
        child: CustomPaint(
          painter: TopBarBlueBackgroundPainter(overflow: true),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TopBar(),
              const SizedBox(height: 8),
              BalanceInfoCard(
                networkName: preferredNetwork?.name ?? "",
                networkSymbol: preferredNetwork?.symbol ?? "",
                amount: preferredNetwork?.amount ?? 0.00,
                fiatConversionRate: 0.000009,
                fiatSymbol: 'EURO',
              ),
              const SizedBox(height: 18),
              const BuySellBridgeButtonsRow(),
              const ReceiveSendFundsSection(),
              const SizedBox(height: 16),
              ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: 116,
                  maxHeight: 116 + 64 * 3,
                ),
                child: const TokensNfcsErc20TabSection(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
