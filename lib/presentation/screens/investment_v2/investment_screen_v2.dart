import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:finniu/presentation/screens/blue_gold_investments/blue_gold_investment_screen.dart';
import 'package:finniu/presentation/screens/business_investments/widgets/app_bar_business.dart';
import 'package:finniu/presentation/screens/home_v2/widgets/navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class InvestmentsV2Screen extends HookConsumerWidget {
  const InvestmentsV2Screen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(settingsNotifierProvider).isDarkMode;
    const int columnColorDark = 0xff0E0E0E;
    const int columnColorLight = 0xffF8F8F8;

    return Scaffold(
      backgroundColor: isDarkMode
          ? const Color(columnColorDark)
          : const Color(columnColorLight),
      appBar: const AppBarBusinessScreen(),
      bottomNavigationBar: const NavigationBarHome(
        colorBackground: Colors.transparent,
      ),
      body: const SingleChildScrollView(
        child: BlueGoldBody(),
      ),
    );
  }
}
