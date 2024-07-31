import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:finniu/presentation/screens/business_investments/widgets/app_bar_business.dart';
import 'package:finniu/presentation/screens/catalog/row_title_amount.dart';
import 'package:finniu/presentation/screens/catalog/widgets/text_poppins.dart';
import 'package:finniu/presentation/screens/lot_detail_v2/widget/harvest_status.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class LotDetailScreenV2 extends ConsumerWidget {
  const LotDetailScreenV2({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(settingsNotifierProvider).isDarkMode;
    const int columnColorDark = 0xff0E0E0E;
    const int columnColorLight = 0xffF8F8F8;

    return Scaffold(
      backgroundColor: isDarkMode
          ? const Color(columnColorDark)
          : const Color(columnColorLight),
      appBar: const AppBarBusinessScreen(
        title: "",
      ),
      floatingActionButton: const _FloatingActionButton(),
      body: const SingleChildScrollView(
        child: Stack(
          alignment: Alignment.center,
          children: [
            _BodyScaffold(),
          ],
        ),
      ),
    );
  }
}

class _FloatingActionButton extends ConsumerWidget {
  const _FloatingActionButton();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(settingsNotifierProvider).isDarkMode;
    const int buttonColorDark = 0xffA2E6FA;
    const int buttonColorLight = 0xff0D3A5C;
    const int textColorDark = 0xff000000;
    const int textColorLight = 0xffFFFFFF;
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.9,
      height: 50,
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: isDarkMode
              ? const WidgetStatePropertyAll(
                  Color(buttonColorDark),
                )
              : const WidgetStatePropertyAll(
                  Color(buttonColorLight),
                ),
        ),
        onPressed: () {},
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const TextPoppins(
              text: "Guardar mi progreso",
              fontSize: 16,
              isBold: true,
              textDark: textColorDark,
              textLight: textColorLight,
            ),
            const SizedBox(width: 10),
            Icon(
              Icons.file_download_outlined,
              size: 24,
              color: isDarkMode
                  ? const Color(textColorDark)
                  : const Color(textColorLight),
            ),
          ],
        ),
      ),
    );
  }
}

class _BodyScaffold extends StatelessWidget {
  const _BodyScaffold();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 25, vertical: 15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _TitleBody(),
          SizedBox(
            height: 20,
          ),
          _HarvestDate(),
          SizedBox(
            height: 20,
          ),
          HarvestStatus(),
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
                _InvestmentAmount(),
                SizedBox(
                  height: 30,
                ),
                _ProfitabilityToday(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ProfitabilityToday extends StatelessWidget {
  const _ProfitabilityToday();

  @override
  Widget build(BuildContext context) {
    const int amountDark = 0xffFFFFFF;
    const int amountLight = 0xff000000;
    const int lineRow = 0xff83BF4F;
    return const RowTitleAmount(
      height: 74,
      lineRow: lineRow,
      textTitle: "Mi rendimiento hasta hoy",
      titleSize: 16,
      titleColorDark: amountDark,
      titleColorLight: amountLight,
      amountNumber: 250,
      amountSize: 36,
      amountColorDark: amountDark,
      amountColorLight: amountLight,
    );
  }
}

class _InvestmentAmount extends StatelessWidget {
  const _InvestmentAmount();

  @override
  Widget build(BuildContext context) {
    const int amountDark = 0xffFFFFFF;
    const int amountLight = 0xff000000;
    const int lineRow = 0xffC3DFFF;
    return const RowTitleAmount(
      height: 74,
      lineRow: lineRow,
      textTitle: "Monto invertido",
      titleSize: 16,
      titleColorDark: amountDark,
      titleColorLight: amountLight,
      amountNumber: 82000,
      amountSize: 36,
      amountColorDark: amountDark,
      amountColorLight: amountLight,
    );
  }
}

class _HarvestDate extends ConsumerWidget {
  const _HarvestDate();

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
        const TextPoppins(
          text: "14 de Junio 2024",
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
  const _TitleBody();

  @override
  Widget build(BuildContext context) {
    const int titleDark = 0xffA2E6FA;
    const int titleLight = 0xff0D3A5C;
    return const TextPoppins(
      text: "Cosecha Lote 12",
      fontSize: 24,
      isBold: true,
      textDark: titleDark,
      textLight: titleLight,
    );
  }
}
