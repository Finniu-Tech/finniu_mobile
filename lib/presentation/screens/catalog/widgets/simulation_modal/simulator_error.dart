import 'package:finniu/presentation/providers/money_provider.dart';
import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:finniu/presentation/screens/catalog/widgets/animated_number.dart';
import 'package:finniu/presentation/screens/catalog/widgets/send_proof_button.dart';
import 'package:finniu/presentation/screens/catalog/widgets/text_poppins.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SimulationError extends ConsumerWidget {
  const SimulationError({
    super.key,
    required this.startingAmount,
    required this.mouthInvestment,
    required this.toInvestPressed,
    required this.recalculatePressed,
  });
  final int startingAmount;
  final int mouthInvestment;
  final VoidCallback? toInvestPressed;
  final VoidCallback? recalculatePressed;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(settingsNotifierProvider).isDarkMode;
    final isSoles = ref.watch(isSolesStateProvider);
    const int numberDark = 0xffFFFFFF;
    const int numberLight = 0xff000000;
    const int percentageDark = 0xffA2E6FA;
    const int percentageLight = 0xff0D3A5C;
    const int monthTextDark = 0xffA2E6FA;
    const int monthTextLight = 0xff44879F;
    const int returnDark = 0xff0D3A5C;
    const int returnLight = 0xffDFF7FF;
    const int monthEveryTextDark = 0xffC79BFF;
    const int monthEveryTextLight = 0xffF0E4FF;
    const int textEveryDark = 0xff000000;
    const int textEveryLight = 0xff000000;
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset(
          "assets/images/logo_simulation${isDarkMode ? "_dark" : "_light"}.png",
          width: 75,
          height: 54,
          fit: BoxFit.fill,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const TextPoppins(
                  text: "Si inviertes",
                  fontSize: 16,
                ),
                const SizedBox(
                  height: 10,
                ),
                AnimationNumber(
                  beginNumber: 0,
                  endNumber: startingAmount,
                  duration: 1,
                  fontSize: 24,
                  colorText: isDarkMode ? numberDark : numberLight,
                ),
              ],
            ),
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextPoppins(
                  text: "con un % de retorno",
                  fontSize: 16,
                ),
                SizedBox(
                  height: 10,
                ),
                TextPoppins(
                  text: "-- %",
                  fontSize: 24,
                  isBold: true,
                  textDark: percentageDark,
                  textLight: percentageLight,
                ),
              ],
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const TextPoppins(
              text: "En ",
              fontSize: 24,
              isBold: true,
            ),
            TextPoppins(
              text: "$mouthInvestment meses ",
              fontSize: 24,
              isBold: true,
              textDark: monthTextDark,
              textLight: monthTextLight,
            ),
            const TextPoppins(
              text: "recibirás 💸",
              fontSize: 24,
              isBold: true,
            ),
          ],
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          height: 55,
          decoration: BoxDecoration(
            color:
                isDarkMode ? const Color(returnDark) : const Color(returnLight),
            borderRadius: const BorderRadius.all(
              Radius.circular(10),
            ),
          ),
          child: const Center(
            child: TextPoppins(
              text: "Error al calcular el retorno",
              fontSize: 24,
              textDark: numberDark,
              textLight: numberLight,
            ),
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          height: 49,
          decoration: BoxDecoration(
            color: isDarkMode
                ? const Color(monthEveryTextDark)
                : const Color(monthEveryTextLight),
            borderRadius: const BorderRadius.all(
              Radius.circular(10),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                Icons.calendar_today_outlined,
                color: isDarkMode
                    ? const Color(textEveryDark)
                    : const Color(textEveryLight),
                size: 20,
              ),
              const SizedBox(
                width: 10,
              ),
              const TextPoppins(
                text: "Cada mes recibirás ",
                fontSize: 16,
                textDark: textEveryDark,
                textLight: textEveryLight,
              ),
              TextPoppins(
                text: "${isSoles ? "S/" : "\$"}--",
                fontSize: 16,
                textDark: textEveryDark,
                textLight: textEveryLight,
                isBold: true,
              ),
            ],
          ),
        ),
        ButtonInvestment(
          text: "Contunuar",
          onPressed: toInvestPressed,
        ),
        GestureDetector(
          onTap: recalculatePressed,
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 30,
            child: const Center(
              child: TextPoppins(
                text: "Editar monto",
                fontSize: 16,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
