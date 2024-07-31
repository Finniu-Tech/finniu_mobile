import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:finniu/presentation/screens/catalog/row_title_amount.dart';
import 'package:finniu/presentation/screens/catalog/widgets/text_poppins.dart';
import 'package:finniu/presentation/screens/lot_detail_v2/widget/harvest_status.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class LotDetailLoader extends StatelessWidget {
  const LotDetailLoader({super.key});

  @override
  Widget build(BuildContext context) {
    const String title = "--";
    const String dayToday = "-- de ----- ----";
    const String harvestNumber = "--";
    const String passedDays = "--";
    const String missingDays = "--";
    const double progress = 0.0;
    const int investmentAmount = 8200;
    const int profitabilityAmount = 255;
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 25, vertical: 15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _TitleBody(
            title: title,
          ),
          SizedBox(
            height: 20,
          ),
          _HarvestDate(day: dayToday),
          SizedBox(
            height: 20,
          ),
          HarvestStatus(
            harvestNumber: harvestNumber,
            passedDays: passedDays,
            missingDays: missingDays,
            progress: progress,
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                _InvestmentAmount(
                  investmentAmount: investmentAmount,
                  isLoader: true,
                ),
                SizedBox(
                  height: 30,
                ),
                _ProfitabilityToday(
                  profitabilityAmount: profitabilityAmount,
                  isLoader: true,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _InvestmentAmount extends StatelessWidget {
  const _InvestmentAmount({
    required this.investmentAmount,
    required this.isLoader,
  });
  final int investmentAmount;
  final bool isLoader;
  @override
  Widget build(BuildContext context) {
    const int amountDark = 0xffFFFFFF;
    const int amountLight = 0xff000000;
    const int lineRow = 0xffC3DFFF;
    return RowTitleAmount(
      height: 74,
      lineRow: lineRow,
      textTitle: "Monto invertido",
      titleSize: 16,
      titleColorDark: amountDark,
      titleColorLight: amountLight,
      amountNumber: investmentAmount,
      amountSize: 36,
      amountColorDark: amountDark,
      amountColorLight: amountLight,
      isLoader: isLoader,
    );
  }
}

class _HarvestDate extends ConsumerWidget {
  const _HarvestDate({
    required this.day,
  });
  final String day;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(settingsNotifierProvider).isDarkMode;
    const int subTitleDark = 0xffFFFFFF;
    const int subTitleLight = 0xff000000;
    return Row(
      children: [
        Icon(
          Icons.calendar_today_outlined,
          color: isDarkMode
              ? const Color(subTitleDark)
              : const Color(subTitleLight),
        ),
        const SizedBox(
          width: 5,
        ),
        TextPoppins(
          text: day,
          fontSize: 16,
          textDark: subTitleDark,
          textLight: subTitleLight,
          isBold: true,
        ),
      ],
    );
  }
}

class _TitleBody extends StatelessWidget {
  const _TitleBody({
    required this.title,
  });
  final String title;
  @override
  Widget build(BuildContext context) {
    const int titleDark = 0xffA2E6FA;
    const int titleLight = 0xff0D3A5C;
    return TextPoppins(
      text: "Cosecha Lote $title",
      fontSize: 24,
      isBold: true,
      textDark: titleDark,
      textLight: titleLight,
    );
  }
}

class _ProfitabilityToday extends StatelessWidget {
  const _ProfitabilityToday({
    required this.profitabilityAmount,
    required this.isLoader,
  });
  final int profitabilityAmount;
  final bool isLoader;
  @override
  Widget build(BuildContext context) {
    const int amountDark = 0xffFFFFFF;
    const int amountLight = 0xff000000;
    const int lineRow = 0xff83BF4F;
    return RowTitleAmount(
      height: 74,
      lineRow: lineRow,
      textTitle: "Mi rendimiento hasta hoy",
      titleSize: 16,
      titleColorDark: amountDark,
      titleColorLight: amountLight,
      amountNumber: profitabilityAmount,
      amountSize: 36,
      amountColorDark: amountDark,
      amountColorLight: amountLight,
      isLoader: isLoader,
    );
  }
}
