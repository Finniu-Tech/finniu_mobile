import 'package:finniu/constants/colors.dart';
import 'package:finniu/providers/settings_provider.dart';
import 'package:finniu/widgets/buttons.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class Section3 extends ConsumerWidget {
  PageController controller = PageController();
  Section3({super.key, required this.controller});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentTheme = ref.watch(settingsNotifierProvider);
    // final currentTheme = Provider.of<SettingsProvider>(context, listen: false);
    return Column(
      children: [
        SizedBox(height: 40),
        SizedBox(
          width: 228,
          height: 85,
          child: Text(
            '¿Cuál es tu meta para invertir?',
            textAlign: TextAlign.left,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w600,
              color: currentTheme.isDarkMode
                  ? const Color(0xffA2E6FA)
                  : const Color(primaryDark),
            ),
          ),
        ),

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              child: Image.asset(
                'assets/investment/arrow.png',
                height: 40,
                width: 40,
              ),
            ),
            Container(
                alignment: Alignment.centerRight,
                width: 184,
                child: const Text(
                  "Mari cuentanos cual es tu meta que buscas lograr con tus inversiones",
                  textAlign: TextAlign.justify,
                ))
          ],
        ),
        const SizedBox(
          height: 17,
        ),
        ButtonQuestions(
            text: "Tener dinero para mis emergencias", controller: controller),
        const SizedBox(
          height: 11,
        ),
        ButtonQuestions(
            text: "Tener dinero para mis gastos de estudios",
            controller: controller),

        const SizedBox(
          height: 11,
        ),
        ButtonQuestions(
            text: "Tener dinero para mis épocas sin trabajo",
            controller: controller),

        const SizedBox(
          height: 15,
        ),
        ButtonQuestions(
            text: "Tener dinero guardado para mi futuro",
            controller: controller),

        const SizedBox(
          height: 15,
        ),
        ButtonQuestions(
            text: "Tener dinero guardado para viajar", controller: controller),
        const SizedBox(
          height: 15,
        ),
        ButtonQuestions(
            text: "Tener dinero para comprarme una casa",
            controller: controller),

        // const CustomButton(
        //   text: 'Continuar',
        //   width: 224,
        //   height: 50,
        //   pushName: '/investment_result',
        // ),
      ],
    );
    ;
  }
}
