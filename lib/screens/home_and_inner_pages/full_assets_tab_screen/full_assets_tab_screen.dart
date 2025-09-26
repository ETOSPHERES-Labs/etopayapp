import 'package:eto_pay/main.dart';
import 'package:eto_pay/models/network_model.dart';
import 'package:eto_pay/screens/home_and_inner_pages/home_shell/tokens_nfts_erc20_tab_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class FullAssetsTabScreen extends StatelessWidget {
  final List<NetworkAsset> allTokens;
  final List<NetworkAsset> allNfts;
  final List<NetworkAsset> allErc20;

  const FullAssetsTabScreen({
    super.key,
    required this.allTokens,
    required this.allNfts,
    required this.allErc20,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Tokens',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Color(0xFF005CA9),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: TokensNfcsErc20TabSection(
        assetsTokens: allTokens,
        assetsNfts: allNfts,
        assetsErc20: allErc20,
        backgroundColor: Colors.white,
        emptyStateBuilder: (tabName) => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                'assets/images/tokens_no_information.svg',
                height: 140,
              ),
              const SizedBox(height: 48),
              Text(
                'No information ($tabName)',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium?.black(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
