import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:finniu/presentation/screens/catalog/widgets/send_proof_button.dart';
import 'package:finniu/presentation/screens/catalog/widgets/text_poppins.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class PageOneTour extends ConsumerWidget {
  const PageOneTour({
    super.key,
    required this.initTour,
    required this.seeLaterTour,
  });
  final VoidCallback initTour;
  final VoidCallback seeLaterTour;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(settingsNotifierProvider).isDarkMode;
    const int backgroundColorDark = 0xff0E0E0E;
    const int backgroundColorLight = 0xffFFFFFF;
    const String icon = "📲";
    const String title = "Descubre las nuevas funcionalidades";
    const String text =
        "Descubre las nuevas Te guiaremos paso a paso para que puedas conocer las nuevas funcionalidades en la app";

    return Container(
      alignment: Alignment.center,
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        color: isDarkMode
            ? const Color(backgroundColorDark)
            : const Color(backgroundColorLight),
      ),
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.8,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const TextPoppins(
              text: icon,
              fontSize: 96,
            ),
            const SizedBox(height: 15),
            const TextPoppins(
              text: title,
              fontSize: 20,
              fontWeight: FontWeight.w600,
              align: TextAlign.start,
              lines: 2,
            ),
            const SizedBox(height: 15),
            const TextPoppins(
              text: text,
              fontSize: 16,
              fontWeight: FontWeight.w500,
              align: TextAlign.start,
              lines: 3,
            ),
            const SizedBox(height: 150),
            ButtonInvestment(
              text: "Comencemos",
              onPressed: initTour,
            ),
            const SizedBox(height: 15),
            GestureDetector(
              onTap: seeLaterTour,
              child: const Center(
                child: TextPoppins(
                  text: "Ver mas tarde",
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  align: TextAlign.start,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
