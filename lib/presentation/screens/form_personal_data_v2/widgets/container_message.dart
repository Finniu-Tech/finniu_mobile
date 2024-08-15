import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:finniu/presentation/screens/catalog/widgets/blue_gold_card/buttons_card.dart';
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
    const String message = "¿Por que es importante completar los datos?";
    return GestureDetector(
      onTap: () => messageDialog(context),
      child: Container(
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: isDarkMode
              ? const Color(backgroundDark)
              : const Color(backgroundLight),
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
              color:
                  isDarkMode ? const Color(iconDark) : const Color(iconLight),
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
    final String text =
        "Necesitamos esta información para cumplir con las normas financieras y confirmar quién eres. Tus datos están seguros y protegidos, así que no te preocupes por eso.";
    return Dialog(
      insetPadding: const EdgeInsets.all(20),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: isDarkMode
              ? const Color(backgroundDark)
              : const Color(backgroundLight),
        ),
        width: 329,
        height: 230,
        child: Stack(
          children: [
            const CloseButtonModal(),
            SizedBox(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
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
                  const SizedBox(
                    height: 5,
                  ),
                  TextPoppins(
                    text: text,
                    fontSize: 14,
                    lines: 5,
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
