import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:finniu/presentation/screens/catalog/widgets/blue_gold_card/buttons_card.dart';
import 'package:finniu/presentation/screens/catalog/widgets/text_poppins.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

Future<dynamic> unfinishedInvestmentModal(
    BuildContext context, int daysLeft) async {
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (context) => BodyUnfinished(
      daysLeft: daysLeft,
    ),
  );
}

class BodyUnfinished extends ConsumerWidget {
  const BodyUnfinished({
    super.key,
    required this.daysLeft,
  });
  final int daysLeft;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(settingsNotifierProvider).isDarkMode;
    const int backgroundDialogDark = 0xff1A1A1A;
    const int backgroundDialogLight = 0xffFFFFFF;
    const String title = "Aún no ha finalizado tu \nprogreso ";
    const int titleColorDark = 0xff94C7FF;
    const int titleColorLight = 0xff0D3A5C;
    const String bodyText =
        "Cuando haya finalizado podrás descargar el informe y visualizar el voucher del pago realizado";

    return Dialog(
      backgroundColor:
          Color(isDarkMode ? backgroundDialogDark : backgroundDialogLight),
      child: Stack(
        children: [
          SizedBox(
            width: 287,
            height: 215,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const TextPoppins(
                    text: title,
                    fontSize: 16,
                    isBold: true,
                    lines: 2,
                    textDark: titleColorDark,
                    textLight: titleColorLight,
                  ),
                  DaysLeftContainer(
                    daysLeft: daysLeft,
                  ),
                  const TextPoppins(
                    text: bodyText,
                    fontSize: 12,
                    lines: 3,
                  ),
                ],
              ),
            ),
          ),
          const CloseButtonModal(),
        ],
      ),
    );
  }
}

class DaysLeftContainer extends ConsumerWidget {
  const DaysLeftContainer({
    super.key,
    required this.daysLeft,
  });
  final int daysLeft;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(settingsNotifierProvider).isDarkMode;
    const int backgroundDark = 0xff3A66BF;
    const int backgroundLight = 0xffDFEEFF;
    const int containerDark = 0xff94C7FF;
    const int containerLight = 0xff94C7FF;
    const int textDark = 0xff000000;
    const int textLight = 0xff000000;

    return Stack(
      children: [
        Container(
          width: 287,
          height: 31,
          decoration: BoxDecoration(
            color: Color(isDarkMode ? backgroundDark : backgroundLight),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        Container(
          width: 137,
          height: 31,
          decoration: BoxDecoration(
            color: Color(isDarkMode ? containerDark : containerLight),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
            child: TextPoppins(
              text: "Faltan ${daysLeft} días",
              fontSize: 14,
              isBold: true,
              textDark: textDark,
              textLight: textLight,
            ),
          ),
        ),
      ],
    );
  }
}
