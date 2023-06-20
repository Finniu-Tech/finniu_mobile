import 'package:finniu/constants/colors.dart';
import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:finniu/widgets/custom_select_button.dart';
import 'package:finniu/widgets/scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class LanguagesStart extends HookConsumerWidget {
  LanguagesStart({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentTheme = ref.watch(settingsNotifierProvider);

    final languageController = useTextEditingController();
    return CustomScaffoldReturnLogo(
      hideReturnButton: false,
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/languages/land.png',
                  width: 125,
                  height: 150,
                ),
                // SizedBox(width: 10),

                Text(
                  "Lenguajes",
                  style: TextStyle(
                      fontSize: 24,
                      color: currentTheme.isDarkMode
                          ? const Color(primaryLight)
                          : const Color(primaryDark),
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                  child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        // width: 46.48,
                        // height: 34.87,
                        decoration: BoxDecoration(
                          color: Color(primaryDark),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Image.asset(
                          color: Color(cardBackgroundColorLight),
                          'assets/languages/translate.png',
                          width: 15,
                          height: 15,
                        ),
                      ),
                      SizedBox(
                        width: 7,
                      ),
                      Text(
                        'Configuración de lenguaje',
                        style: TextStyle(
                            fontSize: 14,
                            color: currentTheme.isDarkMode
                                ? const Color(whiteText)
                                : const Color(blackText),
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ],
              )),
            ),
            Container(
              // Container(
              width: MediaQuery.of(context).size.width * 0.8,

              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                      color: currentTheme.isDarkMode
                          ? const Color(primaryLight)
                          : const Color(gradient_secondary_option),
                      width: 2),
                ),
              ),
            ),
            SizedBox(height: 2),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Text(
                'Idioma seleccionado de la aplicación',
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 12,
                  height: 1.5,
                  color: currentTheme.isDarkMode
                      ? const Color(whiteText)
                      : const Color(blackText),
                ),
              ),
            ),
            CustomSelectButton(
              textEditingController: languageController,
              items: const ['Español', 'Portugués', 'Inglés'],
              labelText: "Idioma",
            ),
          ],
        ),
      ),
    );
  }
}
