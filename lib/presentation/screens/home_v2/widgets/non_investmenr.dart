import 'package:finniu/constants/colors.dart';
import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class NonInvestmentContainer extends ConsumerWidget {
  const NonInvestmentContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(settingsNotifierProvider).isDarkMode;
    const String textTitle = "¿Estás listo para explorar\nnuestras opciones de\ninversión?";
    const String textBody = "Descubre nuestros fondos y comienza\na invertir de manera inteligente";

    return GestureDetector(
      onTap: () {
        print("precione para navegar a la pantalla de inversión");
      },
      child: Container(
        decoration: BoxDecoration(
          color: isDarkMode ? const Color(0xff1A1A1A) : const Color(0xffFFFFFF),
          borderRadius: BorderRadius.circular(20),
        ),
        width: 316,
        height: 196,
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      const SizedBox(
                        height: 15,
                      ),
                      Image.asset(
                        "assets/home/money_wings.png",
                        width: 32,
                        height: 32,
                      ),
                    ],
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        textTitle,
                        maxLines: 3,
                        style: TextStyle(
                          fontSize: 16,
                          color: isDarkMode ? const Color(labelTextDarkColor) : const Color(labelTextLightColor),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        textBody,
                        maxLines: 2,
                        style: TextStyle(fontSize: 12),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Center(
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'Visualiza nuestros ',
                      style: TextStyle(
                        fontSize: 11,
                        color: isDarkMode ? Colors.white : Colors.black,
                      ),
                    ),
                    TextSpan(
                      text: 'Fondos de inversión',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: isDarkMode ? const Color(labelTextDarkColor) : const Color(labelTextLightColor),
                      ),
                    ),
                    TextSpan(
                      text: ' aquí 👇🏻',
                      style: TextStyle(
                        fontSize: 11,
                        color: isDarkMode ? Colors.white : Colors.black,
                      ),
                    ),
                  ],
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
