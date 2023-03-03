import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:finniu/constants/colors.dart';
import 'package:finniu/providers/settings_provider.dart';
import 'package:finniu/screens/confirmation_phone/confirmation_phone_screen.dart';
import 'package:finniu/screens/investment_confirmation/step_1.dart';
import 'package:finniu/widgets/buttons.dart';
import 'package:finniu/widgets/scaffold.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class Step_2 extends ConsumerWidget {
  const Step_2({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentTheme = ref.watch(settingsNotifierProvider);
    var MontoController;

    return CustomScaffoldReturnLogo(
        body: SingleChildScrollView(
            child: Padding(
                padding: const EdgeInsets.all(30.0),
                child: Column(children: <Widget>[
                  StepBar(),
                  const SizedBox(height: 40),
                  Stack(
                    children: <Widget>[
                      Container(
                        alignment: Alignment.centerLeft,
                        width: 310,
                        height: 70,
                        padding: const EdgeInsets.only(
                          right: 100,
                        ),
                        child: Text(
                          'Plan Origen',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Color(Theme.of(context).colorScheme.secondary.value),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 15),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 59.49,
                        height: 31.15,
                        // padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Color(primaryDark),
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: Color(primaryDark),
                            width: 1,
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              '6%',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Color(primaryLight),
                              ),
                            ),
                            Text(
                              textAlign: TextAlign.center,
                              'Rentabilidad',
                              style: TextStyle(
                                fontSize: 5,
                                color: Color(primaryLight),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  CircularCountdown(),
                  Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              alignment: Alignment.center,
                              height: 60,
                              width: 116,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Color(primaryLight), // Coloca aquí el color que desees para el primer contenedor
                              ),
                              child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                                Text(
                                  textAlign: TextAlign.center,
                                  'S/550 ',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Color(primaryDark),
                                  ),
                                ),
                                Text(
                                  textAlign: TextAlign.center,
                                  'Tu monto invertido ',
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: Color(blackText),
                                  ),
                                ),
                              ]),
                            ),
                          ),

                          SizedBox(width: 50), // Coloca aquí el espacio que deseas entre los contenedores

                          Expanded(
                              child: Container(
                            alignment: Alignment.center,
                            height: 60,
                            width: 116,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Color(secondary), // Coloca aquí el color que desees para el segundo contenedor
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'S/583 ',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Color(primaryDark),
                                  ),
                                ),
                                Text(
                                  textAlign: TextAlign.center,
                                  'Monto que recibiras ',
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: Color(blackText),
                                  ),
                                ),
                              ],
                            ),
                          ))
                        ],
                      )
                    ],
                  ),
                  SizedBox(height: 50),
                  Row(
                    children: [
                      Container(
                        width: 120,
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Elige tu banco',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Color(Theme.of(context).colorScheme.secondary.value),
                          ),
                        ),
                      ),
                      Image.asset('assets/result/money.png', width: 20.0, height: 20),
                      const Spacer(),
                      Icon(
                        Icons.quiz_rounded, // Icono que deseas utilizar
                        size: 20, // Tamaño del icono
                        color: Color(primaryDark), // Color del icono
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  SizedBox(height: 20),
                  Container(
                    // width: 320,
                    height: 71,

                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15),
                        bottomLeft: Radius.circular(4),
                        bottomRight: Radius.circular(4),
                      ),
                      color: Colors.white,
                      border: Border.all(
                        color: Color(primaryDark),
                        width: 2,
                      ),
                    ),
                    // padding: EdgeInsets.all(16.0),
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: <Widget>[
                              Icon(Icons.aspect_ratio_sharp),
                              SizedBox(
                                width: 10,
                              ),
                              Container(
                                width: 190,
                                child: Text(
                                  'Banco donde realizamos tu transferencia',
                                  style: TextStyle(color: Color(primaryDark)),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              SizedBox(
                                width: 40,
                              ),
                              Column(
                                children: [
                                  Icon(Icons.loupe_rounded, size: 30),
                                  Text(
                                    'Agregar cuenta',
                                    style: TextStyle(fontSize: 8),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 70.0),
                        Container(
                          height: 50,
                          width: 224,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: Color(primaryDark),
                          ),
                          child: Center(
                            child: CustomButton(colorBackground: currentTheme.isDarkMode ? (primaryLight) : (primaryDark), text: "Continuar", colorText: currentTheme.isDarkMode ? (primaryDark) : (whiteText), pushName: '/investment_step1'),
                          ),
                        ),
                      ],
                    ),
                  )
                ]))));
  }
}

class CircularCountdown extends StatelessWidget {
  const CircularCountdown({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerRight,
      width: 125.41,
      height: 127.01,
      child: Stack(
        alignment: Alignment.center,
        children: [
          CircularCountDownTimer(
            width: MediaQuery.of(context).size.width / 2,
            height: MediaQuery.of(context).size.height / 2,
            duration: 60,
            ringColor: Colors.grey[300]!,
            fillColor: Color(primaryDark),
            backgroundColor: Color(whiteText),
            strokeWidth: 6.0,
            textStyle: TextStyle(
              fontSize: 10.0,
              color: Color(primaryDark),
              fontWeight: FontWeight.bold,
            ),
            textFormat: CountdownTextFormat.S,
            onComplete: () {
              debugPrint('Countdown Ended');
            },
          ),
          Positioned(
            top: 20.0,
            child: Column(
              children: [
                Image.asset(
                  'assets/result/money.png',
                  width: 60.0,
                  height: 58.22,
                ),
                SizedBox(height: 10.0),
                Text(
                  '6 meses',
                  style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                    color: Color(primaryDark),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
