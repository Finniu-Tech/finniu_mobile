import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:finniu/presentation/screens/catalog/row_title_amount.dart';
import 'package:finniu/presentation/screens/catalog/widgets/text_poppins.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SliderDraft extends ConsumerWidget {
  const SliderDraft({
    super.key,
    required this.onTap,
    required this.amountNumber,
    required this.isReInvestment,
  });
  final int amountNumber;
  final VoidCallback? onTap;
  final bool isReInvestment;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(settingsNotifierProvider).isDarkMode;
    const int backgroundDark = 0xff08273F;
    const int backgroundLight = 0xffD6F6FF;
    const int iconDark = 0xffA2E6FA;
    const int iconLight = 0xff0D3A5C;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(left: 3, right: 3),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: isDarkMode ? const Color(backgroundDark) : const Color(backgroundLight),
        ),
        width: 330,
        height: 70,
        child: Stack(
          children: [
            const LabelText(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  RowNumber(
                    amountNumber: amountNumber,
                  ),
                  const SizedBox(height: 4),
                  const LineStateInvestment(),
                ],
              ),
            ),
            Positioned(
              left: 20,
              bottom: 5,
              child: Row(
                children: [
                  TextPoppins(
                    text: isReInvestment ? "Reinversión en borrador" : "Inversión en borrador",
                    fontSize: 8,
                  ),
                  Icon(
                    Icons.help_outline,
                    size: 12,
                    color: isDarkMode ? const Color(iconDark) : const Color(iconLight),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class LineStateInvestment extends ConsumerWidget {
  const LineStateInvestment({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(settingsNotifierProvider).isDarkMode;
    const int backgroundDark = 0xff0D3A5C;
    const int backgroundLight = 0xffA2E6FA;
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.8,
      height: 20,
      child: Center(
        child: Stack(
          alignment: Alignment.centerLeft,
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.8,
              height: 3,
              color: isDarkMode ? const Color(backgroundDark) : const Color(backgroundLight),
            ),
            Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: isDarkMode ? Colors.white.withOpacity(0.2) : Colors.black.withOpacity(0.2),
                    spreadRadius: 1,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
                borderRadius: BorderRadius.circular(25),
                color: isDarkMode ? const Color(backgroundDark) : const Color(backgroundLight),
              ),
              width: 20,
              height: 20,
              child: const Padding(
                padding: EdgeInsets.only(left: 3, bottom: 1),
                child: Center(
                  child: TextPoppins(
                    text: '📄',
                    fontSize: 14,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class RowNumber extends ConsumerWidget {
  const RowNumber({
    super.key,
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
