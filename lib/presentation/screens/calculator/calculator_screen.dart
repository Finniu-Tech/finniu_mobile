import 'package:finniu/constants/colors.dart';
import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:finniu/widgets/buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../widgets/custom_select_button.dart';

class Calculator extends HookConsumerWidget {
  const Calculator({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentTheme = ref.watch(settingsNotifierProvider);
    final termController = useTextEditingController();
    final amountController = useTextEditingController();

    List<Color> dayColors = [
      const Color(gradient_primary),
      const Color(gradient_secondary)
    ];
    List<Color> nightColors = [
      const Color(primaryDark),
      const Color(primaryDarkAlternative),
      const Color(primaryDark)
    ];

    return Scaffold(
      bottomNavigationBar: const BottomNavigationBarHome(),
      body: Container(
        alignment: Alignment.centerRight,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: currentTheme.isDarkMode ? nightColors : dayColors)),
        child:SingleChildScrollView(
          child:
         Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              alignment: Alignment.topCenter,
              child: SizedBox(
                child: Image.asset(
                  'assets/images/logo_small.png',
                  width: 70,
                  height: 70,
                  color: currentTheme.isDarkMode
                      ? const Color(whiteText)
                      : const Color(blackText),
                ),
              ),
            ),
            SizedBox(
              child: Container(
                alignment: Alignment.center,
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: Text(
                    textAlign: TextAlign.center,
                    'Simula tu inversión de manera rápida y sencilla',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: currentTheme.isDarkMode
                          ? const Color(primaryLight)
                          : const Color(primaryDark),
                    ),
                  ),
                ),
              ),
            ),
            Container(
              width: double.infinity,
              height: 190,
              constraints: const BoxConstraints(
                maxWidth: 450,
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    child: Image.asset(
                      alignment: Alignment.center,
                      'assets/images/money.png',
                      width: 141,
                      height: 143,
                    ),
                  ),
                  Positioned(
                    right: 0,
                    top: 10,
                    child: SizedBox(
                      child: Image.asset(
                        alignment: Alignment.center,
                        'assets/images/arm.png',
                        width: 202,
                        height: 164,
                      ),
                    ),
                  ),
                ],
              ),
            ),
         
            SizedBox(
              width: 224,
              // height: 38,
              child: TextFormField(
                key: const Key('monto'),
                controller: amountController,
                onChanged: (value) {
                  _calculatePercentage('monto');
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Este dato es requerido';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  hintText: 'Ingrese su monto de inversion',
                  hintStyle: TextStyle(
                    color: currentTheme.isDarkMode
                        ? const Color(whiteText)
                        : const Color(grayText1),
                  ),
                  suffixIconConstraints: const BoxConstraints(
                    maxHeight: 38,
                    minWidth: 38,
                  ),
                  label: const Text(
                    "Monto",
                  ),
                ),
              ),
            ),
            const SizedBox(height: 5),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Text(
                '',
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
              textEditingController: termController,
              items: const ['6 meses', '12 meses'],
              labelText: "Plazo",
              hintText: 'Seleccione su plazo de inversion',
            ),
            const SizedBox(height: 5),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Text(
                '',
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
           
           
            Container(
              width: 224,
              height: 67,
              decoration: BoxDecoration(
                color: const Color(primaryLightAlternative),
                borderRadius: BorderRadius.circular(
                    15.0), // Cambia el valor para ajustar el radio
              ),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(
                            width: 5), // Espacio entre el icono y el texto
                        const Text(
                          'Tu plan recomendado es',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 12,
                            color: Color(blackText),
                          ),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        InkWell(
                          onTap: () => showDialog<String>(
                            barrierColor: Colors.transparent,
                            context: context,
                            builder: (BuildContext context) => ConstrainedBox(
                              constraints: const BoxConstraints(
                                maxWidth: 100.0,
                                maxHeight: 250.0,
                              ),
                              child: AlertDialog(
                                backgroundColor: const Color(primaryDark),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                                content: SizedBox(
                                  height: 300,
                                  width: 350,
                                  child: Column(
                                    children: [
                                      Align(
                                        alignment: Alignment.topRight,
                                        child: IconButton(
                                          alignment: Alignment.topRight,
                                          icon: const Icon(Icons.close),
                                          color: const Color(whiteText),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                      ),
                                      Center(
                                        child: Image.asset(
                                          'assets/result/money.png',
                                          width: 70,
                                          height: 70,
                                        ),
                                      ),
                                      const Text(
                                        'Plan Origen',
                                        textAlign: TextAlign.justify,
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Color(primaryLight),
                                          height: 1.5,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      const Padding(
                                        padding: EdgeInsets.all(10.0),
                                        child: Text(
                                            textAlign: TextAlign.justify,
                                            'Esta inversion prioriza la estabilidad generando una rentabilidad moderada.Si recien empiezas a invertir, este plan es perfecto para ti.',
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: Color(whiteText),
                                              height: 1.5,
                                            )),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          child: const Icon(
                              Icons.quiz_outlined, // Icono que deseas utilizar
                              size: 20, // Tamaño del icono
                              color: Color(primaryDark)
                              // Color del icono
                              ),
                        ),
                      ],
                    ),
                    const Text(
                      'Plan Origen',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Color(primaryDark),
                      ),
                    ),
                  ],
                ),
              ),
            ),
             const SizedBox(height: 10,),
             const SizedBox(width: 200,
               child: Text(
                        '*Recuerda que puedes retirar tus intereses desde el 1er mes',
                        textAlign: TextAlign.justify,
                        style: TextStyle(
                          fontSize: 10,
                          color: Color(blackText),
                        ),
                      ),
             ),
            
            
            
            Container(
              margin: const EdgeInsets.only(top: 10),
              child: CustomButton(
                  height: 44,
                  text: 'Continuar',
                  colorBackground:
                      currentTheme.isDarkMode ? (primaryLight) : primaryDark,
                  colorText:
                      currentTheme.isDarkMode ? (primaryDark) : whiteText,
                  pushName: '/calculator_result'),
            )
          ],
        ),
      ),
    ),
    );
  }
}

void _calculatePercentage(String s) {}
