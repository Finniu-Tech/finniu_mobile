import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:finniu/presentation/screens/catalog/widgets/blue_gold_card/buttons_card.dart';
import 'package:finniu/presentation/screens/catalog/widgets/text_poppins.dart';
import 'package:finniu/presentation/screens/catalog/widgets/validation_modal.dart';
import 'package:finniu/presentation/screens/pay_out/widgets/title_subtitle_pay.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void showReceiveAdk({
  required BuildContext context,
}) {
  showDialog(
    context: context,
    builder: (context) {
      return const ReceiveAskBody();
    },
  );
}

class ReceiveAskBody extends StatelessWidget {
  const ReceiveAskBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    const String title = "¿Recibiste tu pago? 🕓";
    const String text =
        "Estimado, recuerda que los pagos llegan en un plazo max de 24hr";
    const String textTanks = "Gracias por tu comprensión!";
    const int tanksDark = 0xffA2E6FA;
    const int tanksLight = 0xff0D3A5C;

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Stack(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.8,
            height: 350,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 25,
                vertical: 40,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const PayOutIconsRow(),
                  const TextPoppins(
                    text: title,
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                    textDark: tanksDark,
                    textLight: tanksLight,
                  ),
                  const Column(
                    children: [
                      TextPoppins(
                        text: text,
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        lines: 3,
                        align: TextAlign.center,
                      ),
                      TextPoppins(
                        text: textTanks,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        align: TextAlign.center,
                        textDark: tanksDark,
                        textLight: tanksLight,
                      ),
                    ],
                  ),
                  const RowDivider(),
                  ButtonIconDialog(
                    text: "Hablar con un asesor",
                    onPressed: () {},
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

class RowDivider extends ConsumerWidget {
  const RowDivider({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(settingsNotifierProvider).isDarkMode;
    const int dividerDark = 0xff323333;
    const int dividerLight = 0xffBFF0FF;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Divider(
            height: 2,
            color: isDarkMode
                ? const Color(dividerDark)
                : const Color(dividerLight),
          ),
        ),
        const SizedBox(width: 10),
        const TextPoppins(
          text: "¿No tuviste ningún pago?",
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Divider(
            height: 2,
            color: isDarkMode
                ? const Color(dividerDark)
                : const Color(dividerLight),
          ),
        ),
      ],
    );
  }
}
