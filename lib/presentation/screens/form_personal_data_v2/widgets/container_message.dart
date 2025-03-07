import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:finniu/presentation/screens/catalog/widgets/blue_gold_card/buttons_card.dart';
import 'package:finniu/presentation/screens/catalog/widgets/send_proof_button.dart';
import 'package:finniu/presentation/screens/catalog/widgets/text_poppins.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ContainerMessage extends ConsumerWidget {
  const ContainerMessage({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(settingsNotifierProvider).isDarkMode;
    const int backgroundDark = 0xff0D3A5C;
    const int backgroundLight = 0xffE0F8FF;
    const int iconDark = 0xffA2E6FA;
    const int iconLight = 0xff000000;
    const String message = "¿Por qué es importante completar los datos?";
    return GestureDetector(
      onTap: () => messageDialog(context),
      child: Container(
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: isDarkMode ? const Color(backgroundDark) : const Color(backgroundLight),
        ),
        width: MediaQuery.of(context).size.width,
        height: 35,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(
              "assets/svg_icons/alert_circle.svg",
              width: 16,
              height: 16,
              color: isDarkMode ? const Color(iconDark) : const Color(iconLight),
            ),
            const SizedBox(
              width: 5,
            ),
            const TextPoppins(
              text: message,
              fontSize: 12,
            ),
          ],
        ),
      ),
    );
  }
}

class LocationMessage extends ConsumerWidget {
  const LocationMessage({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const int background = 0xffA2E6FA;
    const int iconColor = 0xff0D3A5C;
    const int textColor = 0xff000000;

    const String message = "Recuerda que la dirección que ingreses coincida con la que figura en tu DNI.";
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: const Color(background)),
      width: MediaQuery.of(context).size.width,
      height: 62,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            width: 5,
          ),
          SvgPicture.asset(
            "assets/svg_icons/document_icon.svg",
            width: 35,
            height: 35,
            color: const Color(iconColor),
          ),
          const SizedBox(
            width: 10,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.65,
            child: const TextPoppins(
              text: message,
              fontSize: 14,
              lines: 2,
              textDark: textColor,
              textLight: textColor,
            ),
          ),
        ],
      ),
    );
  }
}

void messageDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) => const MessageCompletingData(),
  );
}

class MessageCompletingData extends ConsumerWidget {
  const MessageCompletingData({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(settingsNotifierProvider).isDarkMode;
    const int backgroundDark = 0xff1A1A1A;
    const int backgroundLight = 0xffFFFFFF;
    const int textDark = 0xffB3B3B3;
    const int textLight = 0xff0D3A5C;
    const String title = "";
    const String text =
        "Es importante completar tus datos para cumplir con las normativas y asegurar un servicio más seguro para ti. Tus datos están seguros y protegidos, así que no te preocupes por eso.";

    void continueLater() {
      Navigator.pushNamedAndRemoveUntil(
        context,
        '/v4/home',
        (Route<dynamic> route) => false,
      );
    }

    return Dialog(
      insetPadding: const EdgeInsets.all(20),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: isDarkMode ? const Color(backgroundDark) : const Color(backgroundLight),
        ),
        width: 329,
        height: 350,
        child: Stack(
          children: [
            const CloseButtonModal(),
            SizedBox(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            "assets/images/modal_message_paper.png",
                            width: 36,
                            height: 41,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Image.asset(
                            "assets/images/modal_message_padlock.png",
                            width: 36,
                            height: 41,
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  const TextPoppins(
                    text: title,
                    fontSize: 14,
                    lines: 1,
                    fontWeight: FontWeight.w600,
                    align: TextAlign.center,
                  ),
                  const TextPoppins(
                    text: text,
                    fontSize: 14,
                    lines: 5,
                    fontWeight: FontWeight.w400,
                    align: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ButtonInvestment(
                    text: "Completar los datos restantes",
                    onPressed: () => Navigator.pop(context),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                    onTap: continueLater,
                    child: const TextPoppins(
                      text: "Continuar al Home",
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      textDark: textDark,
                      textLight: textLight,
                    ),
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
