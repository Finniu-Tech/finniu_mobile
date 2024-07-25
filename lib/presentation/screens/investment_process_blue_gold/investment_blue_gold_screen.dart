import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:finniu/presentation/screens/catalog/widgets/text_poppins.dart';
import 'package:finniu/presentation/screens/home_v2/widgets/navigation_bar.dart';
import 'package:finniu/presentation/screens/investment_process_blue_gold/widgets/app_bar_blue_gold.dart';
import 'package:finniu/presentation/screens/investment_process_blue_gold/widgets/header_blue_gold.dart';
import 'package:finniu/presentation/screens/investment_process_blue_gold/widgets/row_items.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class InvestmentBlueGoldScreen extends HookConsumerWidget {
  const InvestmentBlueGoldScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(settingsNotifierProvider).isDarkMode;
    const int backgroundColorDark = 0xff0E0E0E;
    const int backgroundColorLight = 0xffFFFFFF;
    const String title = "Fondo inversión agro \ninmobiliaria";
    const int titleColorDark = 0xffA2E6FA;
    const int titleColorLight = 0xff0D3A5C;
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: const NavigationBarHome(),
      appBar: const AppBarBlueGoldScreen(),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: isDarkMode ? const Color(backgroundColorDark) : const Color(backgroundColorLight),
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              HeaderContainer(),
              TextPoppins(
                text: title,
                fontSize: 20,
                isBold: true,
                lines: 2,
                textDark: titleColorDark,
                textLight: titleColorLight,
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                      child: AmountRow(
                    totalInvestedAmount: 52000,
                  )),
                  SizedBox(width: 20),
                  Expanded(child: SelectedItems()),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
