import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:finniu/presentation/screens/catalog/widgets/blue_gold_card/buttons_card.dart';
import 'package:finniu/presentation/screens/catalog/widgets/text_poppins.dart';
import 'package:finniu/presentation/screens/catalog/widgets/validation_modal.dart';
import 'package:finniu/presentation/screens/pay_out/widgets/modal_receive_ask.dart';
import 'package:finniu/presentation/screens/pay_out/widgets/title_subtitle_pay.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void showPayBounced({
  required BuildContext context,
}) {
  showDialog(
    context: context,
    builder: (context) {
      return const BoncedBody();
    },
  );
}

class BoncedBody extends ConsumerWidget {
  const BoncedBody({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(settingsNotifierProvider).isDarkMode;
    const String title = "¡Tu pago ha rebotado!";
    const String text =
        "Notamos que tu pago aún no se ha procesado dentro de las 24 horas. Estamos investigando la situación y trabajaremos para resolverlo lo antes posible. Agradecemos tu paciencia y te mantendremos informado";
    const int tanksDark = 0xffA2E6FA;
    const int tanksLight = 0xff0D3A5C;

    void contact() {
      print("contact");
    }

    const int backgroundDark = 0xff1A1A1A;
    const int backgroundLight = 0xffFFFFFF;
    return Dialog(
      backgroundColor: isDarkMode
          ? const Color(backgroundDark)
          : const Color(backgroundLight),
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
                        lines: 6,
                        align: TextAlign.center,
                      ),
                    ],
                  ),
                  const RowDivider(),
                  ButtonIconDialog(
                    text: "Hablar con un asesor",
                    onPressed: () => contact(),
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
