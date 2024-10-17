import 'package:finniu/infrastructure/models/lot_detail.dart';
import 'package:finniu/presentation/providers/lot_detail.dart';
import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:finniu/presentation/screens/business_investments/widgets/app_bar_business.dart';
import 'package:finniu/presentation/screens/catalog/row_title_amount.dart';
import 'package:finniu/presentation/screens/catalog/widgets/text_poppins.dart';
import 'package:finniu/presentation/screens/lot_detail_v2/widget/harvest_status.dart';
import 'package:finniu/presentation/screens/lot_detail_v2/widget/lot_detail_loader.dart';
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
          elevation: const WidgetStatePropertyAll(10),
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
              fontWeight: FontWeight.w500,
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

class _BodyScaffold extends ConsumerWidget {
  const _BodyScaffold();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    AsyncValue<LotDetail> detail = ref.watch(lotDetailProvider);
    return detail.when(
      data: (data) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _TitleBody(
                title: data.title,
              ),
              const SizedBox(
                height: 20,
              ),
              _HarvestDate(day: data.dayToday),
              const SizedBox(
                height: 20,
              ),
              HarvestStatus(
                harvestNumber: data.harvestNumber,
                passedDays: data.passedDays,
                missingDays: data.missingDays,
                progress: data.progress,
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    _InvestmentAmount(
                      investmentAmount: data.investmentAmount,
                      isLoader: false,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    _ProfitabilityToday(
                      profitabilityAmount: data.profitabilityAmount,
                      isLoader: false,
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
      loading: () {
        return const LotDetailLoader();
      },
      error: (error, stack) {
        return const LotDetailLoader();
      },
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
          fontWeight: FontWeight.w500,
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
      fontWeight: FontWeight.w500,
      textDark: titleDark,
      textLight: titleLight,
    );
  }
}
