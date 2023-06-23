import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:finniu/presentation/screens/settings/widgets.dart';
import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:finniu/constants/colors.dart';
import 'package:finniu/widgets/scaffold.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

class HelpScreen extends ConsumerWidget {
  const HelpScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentTheme = ref.watch(settingsNotifierProvider);
    // final currentTheme = Provider.of<SettingsProvider>(context, listen: false);

    return CustomScaffoldReturnLogo(
      hideReturnButton: false,
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/help/circle.png',
                    width: 90,
                    height: 90,
                  ),
                  Text(
                    "Ayuda",
                    style: TextStyle(
                        fontSize: 24,
                        color: currentTheme.isDarkMode
                            ? const Color(primaryLight)
                            : const Color(primaryDark),
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.2,
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
                          width: 46.48,
                          height: 34.87,
                          decoration: BoxDecoration(
                            color: Color(primaryDark),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: IconContainer(
                            image: 'assets/help/message.png',
                          ),
                        ),
                        SizedBox(
                          width: 7,
                        ),
                        Text('Preguntas Frecuentes',
                            style: TextStyle(
                                fontSize: 14,
                                color: currentTheme.isDarkMode
                                    ? const Color(whiteText)
                                    : const Color(blackText),
                                fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ],
                )),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.8,
                height: 3,
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: currentTheme.isDarkMode
                          ? const Color(gradient_primary)
                          : const Color(gradient_secondary_option),
                      width: 2,
                    ),
                  ),
                ),
              ),
              // SizedBox(height: 2),
              Padding(
                padding: const EdgeInsets.all(22.0),
                child: Text(
                  'En el FQA podrás encontrar a detalle todas las preguntas frecuentes',
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
              SizedBox(
                height: 5,
              ),

              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                  side: BorderSide(
                    color: currentTheme.isDarkMode
                        ? const Color(gradient_primary)
                        : const Color(blackText),
                  ),
                ),
                color: currentTheme.isDarkMode
                    ? const Color(primaryDark)
                    : const Color(primaryLightAlternative),
                child: ExpansionTile(
                  title: Text(
                    '¿Por qué se llama Finniu?',
                    style: TextStyle(
                      fontSize: 12,
                      color: currentTheme.isDarkMode
                          ? const Color(gradient_primary)
                          : const Color(blackText),
                    ),
                  ),
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Container(
                        // width: 249,
                        // height: 81,
                        decoration: BoxDecoration(
                          color: currentTheme.isDarkMode
                              ? const Color(primaryDarkAlternative)
                              : const Color(primaryLight),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                              color: currentTheme.isDarkMode
                                  ? const Color(primaryDarkAlternative)
                                  : const Color(primaryLight),
                              width: 2.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text(
                            textAlign: TextAlign.justify,
                            'Al momento de fundarse la empresa se llamaba Finniu Way, luego se redujo a Finniu, es un juego de palabras entre Finnance y Niu del inglés New',
                            style: TextStyle(
                              fontSize: 12,
                              color: currentTheme.isDarkMode
                                  ? const Color(whiteText)
                                  : const Color(blackText),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(
                height: 5,
              ),

              Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                    side: BorderSide(
                      color: currentTheme.isDarkMode
                          ? const Color(gradient_primary)
                          : const Color(blackText),
                    ),
                  ),
                  color: currentTheme.isDarkMode
                      ? const Color(primaryDark)
                      : const Color(primaryLightAlternative),
                  child: ExpansionTile(
                      title: Text(
                        'Sobre Finniu',
                        style: TextStyle(
                          fontSize: 12,
                          color: currentTheme.isDarkMode
                              ? const Color(gradient_primary)
                              : const Color(blackText),
                        ),
                      ),
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Container(
                            // width: 249,
                            // height: 81,
                            decoration: BoxDecoration(
                              color: currentTheme.isDarkMode
                                  ? const Color(primaryDarkAlternative)
                                  : const Color(primaryLight),
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                  color: currentTheme.isDarkMode
                                      ? const Color(primaryDarkAlternative)
                                      : const Color(primaryLight),
                                  width: 2.0),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Text(
                                textAlign: TextAlign.justify,
                                'Finniu es una app que ayuda a incrementar tus ahorros con planes de inversion y tomar el control de tus finanzas con una herramienta de presupuestos',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: currentTheme.isDarkMode
                                      ? const Color(whiteText)
                                      : const Color(blackText),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ])),

              SizedBox(
                height: 5,
              ),

              Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                    side: BorderSide(
                      color: currentTheme.isDarkMode
                          ? const Color(gradient_primary)
                          : const Color(blackText),
                    ),
                  ),
                  color: currentTheme.isDarkMode
                      ? const Color(primaryDark)
                      : const Color(primaryLightAlternative),
                  child: ExpansionTile(
                      title: Text(
                        '¿Que necesitamos para empezar Finniu?',
                        style: TextStyle(
                          fontSize: 12,
                          color: currentTheme.isDarkMode
                              ? const Color(gradient_primary)
                              : const Color(blackText),
                        ),
                      ),
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Container(
                            // width: 249,
                            // height: 81,
                            decoration: BoxDecoration(
                              color: currentTheme.isDarkMode
                                  ? const Color(primaryDarkAlternative)
                                  : const Color(primaryLight),
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                  color: currentTheme.isDarkMode
                                      ? const Color(primaryDarkAlternative)
                                      : const Color(primaryLight),
                                  width: 2.0),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Text(
                                textAlign: TextAlign.justify,
                                'Finniu puede ser utilizada para cualquier persona dentro del Perú, ya sea de nacionalidad peruana con DNI o nacionalidad extranjera con CE.',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: currentTheme.isDarkMode
                                      ? const Color(whiteText)
                                      : const Color(blackText),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ])),

              const SizedBox(height: 12),
              SizedBox(
                width: 108,
                height: 32,
                child: TextButton(
                  onPressed: () {
                    launch(
                        'https://diegomallqui.notion.site/Finniu-FAQ-s-cd27189be3dd430b95b84dd2751de67a');
                  },
                  child: Container(
                    color: currentTheme.isDarkMode
                        ? const Color(primaryLight)
                        : const Color(primaryDark),
                    child: Text(
                      'Ir a FQA',
                      style: TextStyle(
                        fontSize: 12,
                        decoration: TextDecoration.underline,
                        color: currentTheme.isDarkMode
                            ? const Color(primaryDark)
                            : const Color(whiteText),
                      ),
                    ),
                  ),
                ),
              ),

              Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(children: [
                    Row(
                      children: [
                        Container(
                            padding: const EdgeInsets.all(10),
                            width: 46.48,
                            height: 34.87,
                            decoration: BoxDecoration(
                              color: Color(primaryDark),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: IconContainer(
                              image: 'assets/help/messagesinstant.png',
                            )),
                        SizedBox(
                          width: 7,
                        ),
                        Text('Contactos de Finniu',
                            style: TextStyle(
                                fontSize: 14,
                                color: currentTheme.isDarkMode
                                    ? const Color(whiteText)
                                    : const Color(blackText),
                                fontWeight: FontWeight.bold)),
                      ],
                    ),
                    SizedBox(height: 10),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.8,
                      height: 3,
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: currentTheme.isDarkMode
                                ? const Color(gradient_primary)
                                : const Color(gradient_secondary_option),
                            width: 2,
                          ),
                        ),
                      ),
                    ),
                  ])),
              Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.transparent,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Icon(
                                CupertinoIcons.phone,
                                color: currentTheme.isDarkMode
                                    ? const Color(primaryLight)
                                    : const Color(blackText),
                              ),
                            ),
                            SizedBox(
                              width: 7,
                            ),
                            Text('963993305',
                                style: TextStyle(
                                  fontSize: 11,
                                  color: currentTheme.isDarkMode
                                      ? const Color(whiteText)
                                      : const Color(blackText),
                                )),
                          ],
                        ),
                      ),
                    ],
                  )),
              SizedBox(
                height: 10,
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.8,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 20, left: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Icon(
                              CupertinoIcons.chevron_down_square,
                              color: currentTheme.isDarkMode
                                  ? const Color(primaryLight)
                                  : const Color(blackText),
                            ),
                          ),
                          SizedBox(
                            width: 7,
                          ),
                          Text('hola@finniu.com',
                              style: TextStyle(
                                fontSize: 11,
                                color: currentTheme.isDarkMode
                                    ? const Color(whiteText)
                                    : const Color(blackText),
                              )),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
