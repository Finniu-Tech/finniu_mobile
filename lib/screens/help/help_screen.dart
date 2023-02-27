import 'package:finniu/providers/settings_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:finniu/constants/colors.dart';
import 'package:finniu/widgets/scaffold.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class HelpScreen extends ConsumerWidget {
  const HelpScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentTheme = ref.watch(settingsNotifierProvider);
    // final currentTheme = Provider.of<SettingsProvider>(context, listen: false);
    var languageController;
    return CustomScaffoldReturnLogo(
        body: Padding(
            padding: const EdgeInsets.all(30.0),
            child: SingleChildScrollView(
              child: Column(children: [
                Row(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Image.asset(
                      'assets/help/circle.png',
                      width: 90,
                      height: 90,
                    ),
                    // SizedBox(width: 10),
                    Text(
                      "Ayuda",
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
                            width: 46.48,
                            height: 34.87,
                            decoration: BoxDecoration(
                              color: Color(primaryDark),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Image.asset(
                              color: Color(cardBackgroundColorLight),
                              'assets/help/message.png',
                              width: 15,
                              height: 15,
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
                  width: 270,
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
                    )),

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
                      Navigator.of(context).pushNamed('/confirmation');
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
                    child: Container(
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
                            child: Image.asset(
                              color: Color(cardBackgroundColorLight),
                              'assets/help/messagesinstant.png',
                              width: 15,
                              height: 15,
                            ),
                          ),
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
                        width: 270,
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
                    ]))),
                Padding(
                  padding: const EdgeInsets.all(0.0),
                  child: Container(
                      width: 250,
                      child: Column(
                        children: [
                          Row(
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
                        ],
                      )),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.all(0.0),
                  child: Container(
                      width: 250,
                      child: Column(
                        children: [
                          Row(
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
                        ],
                      )),
                ),
              ]),
            )));
  }
}
