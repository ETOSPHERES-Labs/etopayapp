import 'package:flutter/material.dart';
import '../widgets/navbar.dart';
import 'package:provider/provider.dart';
import '../view_models/main_home_header_view_model.dart';
import '../core/colors.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../view_models/main_home_balance_view_model.dart';

class MainHomeScreen extends StatefulWidget {
  const MainHomeScreen({super.key});

  @override
  State<MainHomeScreen> createState() => _MainHomeScreenState();
}

class _MainHomeScreenState extends State<MainHomeScreen> {
  int _selectedIndex = 0;

  void _onNavBarTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
    // TODO: Handle navigation for each tab
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => MainHomeHeaderViewModel()),
        ChangeNotifierProvider(create: (_) => MainHomeBalanceViewModel()),
      ],
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            Column(
              children: [
                Consumer<MainHomeHeaderViewModel>(
                  builder: (context, model, _) {
                    return Container(
                      width: double.infinity,
                      height: 170,
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(24),
                          bottomRight: Radius.circular(24),
                        ),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // Profile picture with green tick
                          Stack(
                            children: [
                              CircleAvatar(
                                radius: 22,
                                backgroundColor: Colors.white,
                                child: SvgPicture.asset(
                                  model.profileImage,
                                  width: 36,
                                  height: 36,
                                ),
                              ),
                              if (model.profileVerified)
                                Positioned(
                                  bottom: 2,
                                  right: 2,
                                  child: Container(
                                    width: 16,
                                    height: 16,
                                    decoration: BoxDecoration(
                                      color: Colors.green,
                                      shape: BoxShape.circle,
                                    ),
                                    child: const Icon(
                                      Icons.check,
                                      color: Colors.white,
                                      size: 12,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                          const SizedBox(width: 16),
                          // Network dropdown
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                              decoration: BoxDecoration(
                                color: AppColors.secondary,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton<String>(
                                  value: model.selectedNetwork,
                                  isDense: true,
                                  icon: const Icon(Icons.keyboard_arrow_down, color: Colors.white),
                                  dropdownColor: AppColors.secondary,
                                  items: model.networks.map((network) {
                                    return DropdownMenuItem<String>(
                                      value: network,
                                      child: Text(
                                        network,
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                  onChanged: (value) {
                                    if (value != null) {
                                      model.selectedNetwork = value;
                                    }
                                  },
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 16),
                          // Notification bell with red dot
                          Stack(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  color: AppColors.primary,
                                  shape: BoxShape.circle,
                                  border: Border.all(color: AppColors.primary, width: 2),
                                ),
                                child: IconButton(
                                  icon: const Icon(Icons.notifications_outlined, color: Colors.white, size: 28),
                                  onPressed: () {
                                    model.markNotificationsViewed();
                                  },
                                ),
                              ),
                              if (model.hasUnviewedNotifications && model.notificationCount > 0)
                                Positioned(
                                  top: 8,
                                  right: 8,
                                  child: Container(
                                    width: 18,
                                    height: 18,
                                    decoration: BoxDecoration(
                                      color: Colors.red,
                                      shape: BoxShape.circle,
                                      border: Border.all(color: Colors.white, width: 1.5),
                                    ),
                                    child: Center(
                                      child: Text(
                                        '${model.notificationCount}',
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 11,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                ),
                // Placeholder for main content
                const Expanded(
                  child: SizedBox.shrink(),
                ),
              ],
            ),
            // Overlay balance container
            Positioned(
              top: 115,
              left: 0,
              right: 0,
              child: Consumer<MainHomeBalanceViewModel>(
                builder: (context, balanceModel, _) {
                  return Center(
                    child: Container(
                      width: 390,
                      height: 125,
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [AppColors.tertiary, Colors.white],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.18),
                            blurRadius: 32,
                            offset: const Offset(0, 12),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Wallet Balance',
                            style: TextStyle(
                              color: AppColors.primary,
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                balanceModel.balanceVisible
                                    ? balanceModel.balance.toStringAsFixed(2)
                                    : '••••',
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 24,
                                ),
                              ),
                              const SizedBox(width: 8),
                              GestureDetector(
                                onTap: balanceModel.toggleVisibility,
                                child: Icon(
                                  balanceModel.balanceVisible
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 6),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Text(
                                '€',
                                style: TextStyle(
                                  color: AppColors.subtext,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              const SizedBox(width: 6),
                              Text(
                                balanceModel.euroValue.toStringAsFixed(2),
                                style: const TextStyle(
                                  color: AppColors.subtext,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              const SizedBox(width: 6),
                              const Text(
                                'EURO',
                                style: TextStyle(
                                  color: AppColors.subtext,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            // Main content placeholder
            Positioned.fill(
              top: 170,
              child: Center(
                child: Text(
                  'Main Home Screen',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
              ),
            ),
          ],
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.only(bottom: 0),
          child: CustomNavBar(
            selectedIndex: _selectedIndex,
            onItemSelected: _onNavBarTap,
          ),
        ),
      ),
    );
  }
} 