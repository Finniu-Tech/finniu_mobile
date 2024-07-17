import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:finniu/presentation/screens/catalog/widgets/animated_number.dart';
import 'package:finniu/presentation/screens/catalog/widgets/text_poppins.dart';
import 'package:finniu/presentation/screens/home_v2/widgets/navigation_bar.dart';
import 'package:finniu/presentation/screens/investment_process_blue_gold/widgets/app_bar_blue_gold.dart';
import 'package:finniu/presentation/screens/investment_process_blue_gold/widgets/header_blue_gold.dart';
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
          color: isDarkMode
              ? const Color(backgroundColorDark)
              : const Color(backgroundColorLight),
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
                  Expanded(child: AmountRow()),
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

class SelectedItems extends ConsumerWidget {
  const SelectedItems({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(settingsNotifierProvider).isDarkMode;
    return Container(
      color: Colors.blue,
      height: 230,
    );
  }
}

class AmountRow extends ConsumerWidget {
  const AmountRow({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const int amountInvestment = 52000;
    final isDarkMode = ref.watch(settingsNotifierProvider).isDarkMode;
    const int textAmountDark = 0xff0D3A5C;
    const int textAmountLight = 0xff0D3A5C;
    const int containerDark = 0xffA2E6FA;
    const int containerLight = 0xffE2F8FF;

    return SizedBox(
      height: 230,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: isDarkMode
                  ? const Color(containerDark)
                  : const Color(containerLight),
            ),
            width: 200,
            height: 70,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const TextPoppins(
                  text: "Monto",
                  fontSize: 12,
                  textDark: textAmountDark,
                  textLight: textAmountLight,
                  isBold: true,
                ),
                AnimationNumber(
                  beginNumber: 0,
                  endNumber: amountInvestment,
                  duration: 1,
                  fontSize: 20,
                  colorText: isDarkMode ? textAmountDark : textAmountLight,
                ),
              ],
            ),
          ),
          const Expanded(child: SizedBox()),
          Image.asset(
            "assets/blue_gold/growth_blue_gold.png",
            width: 132,
            height: 132,
            fit: BoxFit.fill,
          ),
        ],
      ),
    );
  }
}
