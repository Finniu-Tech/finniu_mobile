import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:finniu/presentation/screens/business_investments/widgets/app_bar_business.dart';
import 'package:finniu/presentation/screens/catalog/widgets/text_poppins.dart';
import 'package:finniu/presentation/screens/home_v2/widgets/navigation_bar.dart';
import 'package:finniu/presentation/screens/new_simulator/widgets/icon_found.dart';
import 'package:finniu/presentation/screens/new_simulator/widgets/investment_amount_card.dart';
import 'package:finniu/presentation/screens/new_simulator/widgets/investment_ends.dart';
import 'package:finniu/presentation/screens/new_simulator/widgets/selected_back.dart';
import 'package:finniu/presentation/screens/new_simulator/widgets/term_profitability_row.dart';
import 'package:finniu/presentation/screens/new_simulator/widgets/title_simulator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class V2SummaryScreen extends HookConsumerWidget {
  const V2SummaryScreen({super.key});
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
      bottomNavigationBar: const NavigationBarHome(),
      body: const SingleChildScrollView(
        child: _BodyScaffold(),
      ),
    );
  }
}

class _BodyScaffold extends ConsumerWidget {
  const _BodyScaffold();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(settingsNotifierProvider).isDarkMode;
    const int columnColorDark = 0xff0E0E0E;
    const int columnColorLight = 0xffF8F8F8;
    return Container(
      color: isDarkMode
          ? const Color(columnColorDark)
          : const Color(columnColorLight),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: const Padding(
        padding: EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TitleModal(),
            SizedBox(height: 10),
            IconFund(),
            SizedBox(height: 15),
            InvestmentAmountCardsRow(),
            SizedBox(height: 15),
            RowButtons(),
            SizedBox(height: 15),
            TermProfitabilityRow(),
            SizedBox(height: 15),
            SelectedBank(),
            SizedBox(height: 15),
            InvestmentEnds(),
          ],
        ),
      ),
    );
  }
}

class RowButtons extends ConsumerWidget {
  const RowButtons({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: 130,
          child: ButtonsSimulator(
            text: 'Ver voucher',
            icon: "eye.svg",
            onPressed: null,
          ),
        ),
        SizedBox(
          width: 170,
          child: ButtonsSimulator(
            text: 'Descargar contrato',
            icon: "download.svg",
            onPressed: null,
          ),
        ),
      ],
    );
  }
}

class ButtonsSimulator extends ConsumerWidget {
  const ButtonsSimulator({
    super.key,
    required this.text,
    required this.icon,
    required this.onPressed,
  });
  final String text;
  final String icon;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(settingsNotifierProvider).isDarkMode;
    const int backgroundColorDark = 0xff08273F;
    const int backgroundColorLight = 0xffA2E6FA;
    const int contentColorDark = 0xffFFFFFF;
    const int contentColorLight = 0xff000000;
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        height: 32,
        decoration: BoxDecoration(
          color: Color(isDarkMode ? backgroundColorDark : backgroundColorLight),
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(
              'assets/svg_icons/$icon',
              width: 20,
              height: 20,
              color: Color(isDarkMode ? contentColorDark : contentColorLight),
            ),
            const SizedBox(width: 10),
            TextPoppins(
              text: text,
              fontSize: 14,
              textDark: contentColorDark,
              textLight: contentColorLight,
            ),
          ],
        ),
      ),
    );
  }
}
