import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:finniu/presentation/screens/catalog/widgets/blue_gold_card/buttons_card.dart';
import 'package:finniu/presentation/screens/catalog/widgets/text_poppins.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void showTablePay(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return const ProfitabilityTable();
    },
  );
}

class ProfitabilityTable extends ConsumerWidget {
  const ProfitabilityTable({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(settingsNotifierProvider).isDarkMode;
    const int backgroundDark = 0xff1A1A1A;
    const int backgroundLight = 0xffFFFFFF;
    const int titleDark = 0xffA2E6FA;
    const int titleLight = 0xff0D3A5C;
    return Dialog(
      insetPadding: const EdgeInsets.all(20.0),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 0.6,
        decoration: BoxDecoration(
          color: isDarkMode
              ? const Color(backgroundDark)
              : const Color(backgroundLight),
          borderRadius: const BorderRadius.all(Radius.circular(20)),
        ),
        child: Stack(
          children: [
            Dialog(
              insetPadding: const EdgeInsets.all(20.0),
              backgroundColor: isDarkMode
                  ? const Color(backgroundDark)
                  : const Color(backgroundLight),
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  TextPoppins(
                    text: "Tabla de mis rentabilidades ",
                    fontSize: 16,
                    isBold: true,
                    textDark: titleDark,
                    textLight: titleLight,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TitleData(),
                ],
              ),
            ),
            const CloseButtonModal(),
          ],
        ),
      ),
    );
  }
}

class TitleData extends ConsumerWidget {
  const TitleData({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(settingsNotifierProvider).isDarkMode;
    const int titleTableDark = 0xffFFFFFF;
    const int titleTableLight = 0xff000000;
    const int backgroundColorDark = 0xff0D3A5C;
    const int backgroundColorLight = 0xffE3F9FF;
    const int borderColorDark = 0xffD0D0D0;
    const int borderColorLight = 0xffD0D0D0;

    return Container(
      width: 277,
      height: 38,
      decoration: BoxDecoration(
        color: isDarkMode
            ? const Color(backgroundColorDark)
            : const Color(backgroundColorLight),
        border: Border.all(
          width: 1,
          color: isDarkMode
              ? const Color(borderColorDark)
              : const Color(borderColorLight),
        ),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Row(
            children: [
              Icon(
                Icons.calendar_today_outlined,
                size: 15,
                color: isDarkMode
                    ? const Color(titleTableDark)
                    : const Color(titleTableLight),
              ),
              const SizedBox(
                width: 5,
              ),
              const TextPoppins(
                text: "Mes",
                fontSize: 16,
                isBold: true,
                textDark: titleTableDark,
                textLight: titleTableLight,
              ),
            ],
          ),
          VerticalDivider(
            thickness: 1,
            color: isDarkMode
                ? const Color(borderColorDark)
                : const Color(borderColorLight),
          ),
          Row(
            children: [
              SvgPicture.asset(
                'assets/svg_icons/status_up_two.svg',
                width: 17,
                height: 17,
                color: isDarkMode
                    ? const Color(titleTableDark)
                    : const Color(titleTableLight),
              ),
              const SizedBox(
                width: 5,
              ),
              const TextPoppins(
                text: "Rentabilidad",
                fontSize: 16,
                isBold: true,
                textDark: titleTableDark,
                textLight: titleTableLight,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
