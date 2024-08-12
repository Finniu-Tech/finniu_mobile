import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:finniu/presentation/screens/catalog/row_title_amount.dart';
import 'package:finniu/presentation/screens/catalog/widgets/text_poppins.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SliderDraftModal extends ConsumerWidget {
  const SliderDraftModal({
    super.key,
    required this.amountNumber,
    required this.isReinvest,
    required this.profitability,
    required this.termMonth,
  });
  final int amountNumber;
  final bool isReinvest;
  final int profitability;
  final int termMonth;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(settingsNotifierProvider).isDarkMode;
    const int backgroundDark = 0xff08273F;
    const int backgroundLight = 0xffD6F6FF;

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: isDarkMode
            ? const Color(backgroundDark)
            : const Color(backgroundLight),
      ),
      width: MediaQuery.of(context).size.width * 0.9,
      height: 156,
      child: Stack(
        children: [
          const LabelText(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                _RowNumber(
                  amountNumber: amountNumber,
                ),
                const SizedBox(height: 10),
                _InvestmentData(
                  isReinvest: isReinvest,
                  profitability: profitability,
                  termMonth: termMonth,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _InvestmentData extends ConsumerWidget {
  const _InvestmentData({
    required this.isReinvest,
    required this.profitability,
    required this.termMonth,
  });
  final bool isReinvest;
  final int profitability;
  final int termMonth;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(settingsNotifierProvider).isDarkMode;
    const int backgroundContainer = 0xffA2E6FA;
    const int textContainer = 0xff000000;
    const int iconDark = 0xffA2E6FA;
    const int iconLight = 0xff08273F;
    const int alertDark = 0xffFFFFFF;
    const int alertLight = 0xff08273F;
    const int alertIconDark = 0xffFFFFFF;
    const int alertIconLight = 0xff000000;

    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.7,
      height: 90,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          if (isReinvest)
            Container(
              decoration: BoxDecoration(
                color: const Color(backgroundContainer),
                borderRadius: BorderRadius.circular(20),
              ),
              width: 204,
              height: 24,
              child: const Center(
                child: TextPoppins(
                  text: "Reinversión con monto agregado",
                  fontSize: 11,
                  textDark: textContainer,
                  textLight: textContainer,
                ),
              ),
            ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  SvgPicture.asset(
                    "assets/svg_icons/calendar_blank.svg",
                    width: 20,
                    height: 20,
                    color: isDarkMode
                        ? const Color(iconDark)
                        : const Color(iconLight),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  TextPoppins(text: "Plazo $termMonth meses", fontSize: 12),
                ],
              ),
              Row(
                children: [
                  SvgPicture.asset(
                    "assets/svg_icons/status_up_icon_draft.svg",
                    width: 20,
                    height: 20,
                    color: isDarkMode
                        ? const Color(iconDark)
                        : const Color(iconLight),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  TextPoppins(
                    text: "$profitability% rentabilidad",
                    fontSize: 12,
                  ),
                ],
              ),
            ],
          ),
          Row(
            children: [
              SvgPicture.asset(
                "assets/svg_icons/alert_circle.svg",
                width: 20,
                height: 20,
                color: isDarkMode
                    ? const Color(alertIconDark)
                    : const Color(alertIconLight),
              ),
              const SizedBox(
                width: 5,
              ),
              const TextPoppins(
                text: "Solo te faltaba realizar la transferencia",
                fontSize: 11,
                textDark: alertDark,
                textLight: alertLight,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _RowNumber extends ConsumerWidget {
  const _RowNumber({
    required this.amountNumber,
  });
  final int amountNumber;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const int lineColor = 0xffA2E6FA;
    const int titleColorDark = 0xffFFFFFF;
    const int titleColorLight = 0xff000000;
    const int amountColorDark = 0xffA2E6FA;
    const int amountColorLight = 0xff0D3A5C;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            width: 160,
            child: RowTitleAmount(
              lineRow: lineColor,
              textTitle: 'Inversión empresarial',
              height: 40,
              titleSize: 12,
              titleColorDark: titleColorDark,
              titleColorLight: titleColorLight,
              amountNumber: amountNumber,
              amountSize: 14,
              amountColorDark: amountColorDark,
              amountColorLight: amountColorLight,
              isLoader: false,
            ),
          ),
          Image.asset(
            "assets/reinvestment/reinvestment_image.png",
            width: 40,
            height: 40,
          ),
        ],
      ),
    );
  }
}

class LabelText extends ConsumerWidget {
  const LabelText({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(settingsNotifierProvider).isDarkMode;
    const int labelDark = 0xff114E7C;
    const int labelLight = 0xffA2E6FA;
    return Positioned(
      right: 0,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
            topRight: Radius.circular(10),
            bottomLeft: Radius.circular(10),
          ),
          color: isDarkMode ? const Color(labelDark) : const Color(labelLight),
        ),
        width: 112,
        height: 24,
        child: const Center(
          child: TextPoppins(text: "Proceso por completar", fontSize: 8),
        ),
      ),
    );
  }
}
