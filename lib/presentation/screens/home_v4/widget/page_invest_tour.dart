import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:finniu/presentation/screens/catalog/widgets/send_proof_button.dart';
import 'package:finniu/presentation/screens/catalog/widgets/text_poppins.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class PageOneInvestTour extends ConsumerWidget {
  const PageOneInvestTour({
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
    const String icon = "💸📲";
    const String title = "Descubre como gestionar tus inversiones";
    const String text =
        "Te guiaremos paso a paso para que puedas conocer las nuevas funcionalidades para gestionar tus inversiones";

    return Container(
      alignment: Alignment.center,
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: isDarkMode
            ? const Color(backgroundColorDark)
            : const Color(backgroundColorLight),
      ),
      child: SizedBox(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const TextPoppins(
              text: icon,
              fontSize: 64,
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
            const SizedBox(height: 100),
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
