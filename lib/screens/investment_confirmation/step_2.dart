import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:finniu/constants/colors.dart';
import 'package:finniu/providers/settings_provider.dart';
import 'package:finniu/screens/investment_confirmation/step_1.dart';
import 'package:finniu/screens/investment_confirmation/widgets/alerts.dart';
import 'package:finniu/widgets/buttons.dart';
import 'package:finniu/widgets/scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_verification_code/flutter_verification_code.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class Step_2 extends ConsumerWidget {
  const Step_2({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentTheme = ref.watch(settingsNotifierProvider);

    var MontoController;

    return CustomScaffoldReturnLogo(
        body: SingleChildScrollView(
            child: Column(children: <Widget>[
      const StepBar(),
      const SizedBox(height: 20),
      Container(
        alignment: Alignment.centerLeft,
        width: 310,
        height: 70,
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
      Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 20),
              child: Container(
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
            ),
          ],
        ),
      ),
      Stack(
        children: <Widget>[
          Container(
            child: Row(
              children: [
                Expanded(
                  child: CircularCountdown(),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 10.0, right: 50),
                      child: Container(
                        alignment: Alignment.center,
                        height: 60,
                        width: 116,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Color(primaryLight),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'S/550',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Color(primaryDark),
                              ),
                            ),
                            Text(
                              'Tu monto invertido',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 10,
                                color: Color(blackText),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 10.0, right: 50),
                      child: Container(
                        alignment: Alignment.center,
                        height: 60,
                        width: 116,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Color(secondary),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'S/583',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Color(primaryDark),
                              ),
                            ),
                            Text(
                              'Monto que recibiras',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 10,
                                color: Color(blackText),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
      SizedBox(height: 20),
      Padding(
        padding: const EdgeInsets.all(40.0),
        child: Row(
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
            InkWell(
              onTap: () => showDialog<String>(
                barrierColor: Color(whiteText),
                context: context,
                builder: (BuildContext context) => AlertDialog(
                  backgroundColor: Color(primaryLight),
                  content: Stack(
                    children: [
                      Center(
                        child: Image.asset(
                          'assets/images/magnifying_glass.png',
                          width: 60,
                          height: 60,
                        ),
                      ),
                      Positioned(
                        top: 0,
                        right: 0,
                        child: IconButton(
                          icon: Icon(Icons.close),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 80, left: 20, right: 20),
                        child: Text(
                          textAlign: TextAlign.left,
                          'Hola Mari, de acuerdo al articulo 1646 del codigo Civil, el pago de los intereses del contrato de mutuo se deben realizar en la misma cuenta bancaria desde donde se realizo la transferencia, por eso es importante, para nosotros, conocer tu cuenta bancaria o CCI.',
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              child: Icon(
                Icons.quiz_outlined, // Icono que deseas utilizar
                size: 20, // Tamaño del icono
                color: Color(primaryDark), // Color del icono
              ),
            ),
          ],
        ),
      ),
      Container(
        width: 320,
        height: 71,

        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15),
            topRight: Radius.circular(21),
            bottomLeft: Radius.circular(4),
            bottomRight: Radius.circular(4),
          ),
          color: Colors.white,
          border: Border.all(
            color: Color(primaryDark),
            width: 1,
          ),
        ),
        // padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          // child: Padding(
          //   padding: const EdgeInsets.all(4.0),
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Icon(Icons.aspect_ratio_sharp),
                  SizedBox(
                    width: 10,
                  ),
                  Container(
                    width: 190,
                    child: Text(
                      textAlign: TextAlign.center,
                      'Banco donde realizamos tu transferencia',
                      style: TextStyle(color: Color(primaryDark), fontWeight: FontWeight.bold),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  SizedBox(
                    width: 40,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: Color(primaryDark),
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(20),
                          bottomLeft: Radius.circular(10),
                        )),
                    width: 54,
                    height: 71,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.loupe_rounded, size: 30, color: Color(primaryLight)),
                        Text(
                          textAlign: TextAlign.center,
                          'Agregar cuenta',
                          style: TextStyle(fontSize: 8, color: Color(primaryLight)),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Padding(padding: EdgeInsets.only(top: 70.0)),
            ],
          ),
        ),
      ),
      SizedBox(
        height: 30,
      ),
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
    ])));
  }
}

class CircularCountdown extends StatelessWidget {
  const CircularCountdown({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      // alignment: Alignment.centerLeft,
      width: 125.41,
      height: 127.01,
      child: Stack(
        alignment: Alignment.center,
        children: [
          CircularCountDownTimer(
            width: MediaQuery.of(context).size.width / 2,
            height: MediaQuery.of(context).size.height / 2,
            duration: 60,
            ringColor: Color(primaryLight),
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
