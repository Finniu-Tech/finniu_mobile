import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:circular_countdown_timer/countdown_text_format.dart';
import 'package:finniu/constants/colors.dart';
import 'package:finniu/providers/settings_provider.dart';
import 'package:finniu/screens/investment_confirmation/step_1.dart';
import 'package:finniu/screens/investment_confirmation/step_2.dart';
import 'package:finniu/screens/investment_confirmation/widgets/image_circle.dart';
import 'package:finniu/widgets/buttons.dart';
import 'package:finniu/widgets/scaffold.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class Step_3 extends ConsumerWidget {
  const Step_3({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentTheme = ref.watch(settingsNotifierProvider);

    return CustomScaffoldReturnLogo(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            const StepBar(),
            const SizedBox(height: 30),
            Container(
              alignment: Alignment.centerLeft,
              width: 310,
              height: 40,
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
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  // height: 100,
                  width: MediaQuery.of(context).size.width * 0.6,
                  // width: double.maxFinite,
                  alignment: Alignment.center,

                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      const CircularImage(),
                      Positioned(
                        right: 90,
                        child: Align(
                          alignment: Alignment.center,
                          child: Container(
                            width: 59.49,
                            height: 31.15,
                            // padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: currentTheme.isDarkMode ? Color(primaryLight) : Color(primaryDark),
                              border: Border.all(
                                width: 4,
                                color: currentTheme.isDarkMode ? Color(primaryLight) : Color(primaryDark),
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            // color: Color(primaryDark),

                            child: Column(
                              children: [
                                Center(
                                  child: Text(
                                    textAlign: TextAlign.center,
                                    '6%',
                                    style: TextStyle(
                                      color: currentTheme.isDarkMode ? Color(primaryDark) : Color(primaryLight),
                                      fontSize: 7,
                                    ),
                                  ),
                                ),
                                Text(
                                  textAlign: TextAlign.center,
                                  'Rentabilidad',
                                  style: TextStyle(
                                    color: currentTheme.isDarkMode ? Color(blackText) : Color(whiteText),
                                    fontSize: 7,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  children: [
                    Container(
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
                            textAlign: TextAlign.right,
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
                    SizedBox(height: 10),
                    Container(
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
                            textAlign: TextAlign.right,
                            style: TextStyle(
                              fontSize: 10,
                              color: Color(blackText),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 15),
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
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        content: Stack(
                          children: [
                            Positioned(
                              top: 30,
                              left: 0,
                              right: 0,
                              child: Center(
                                child: Image.asset(
                                  'assets/images/magnifying_glass.png',
                                  width: 60,
                                  height: 60,
                                ),
                              ),
                            ),
                            Positioned(
                              // top: 0,
                              // right: 0,
                              child: IconButton(
                                icon: Icon(Icons.close),
                                color: Color(primaryDark),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 80, left: 20, right: 20),
                              child: Text(
                                  textAlign: TextAlign.justify,
                                  'Hola Mari, de acuerdo al articulo 1646 del codigo Civil, el pago de los intereses del contrato de mutuo se deben realizar en la misma cuenta bancaria desde donde se realizo la transferencia, por eso es importante, para nosotros, conocer tu cuenta bancaria o CCI.',
                                  style: TextStyle(fontSize: 12, color: Color(primaryDark))),
                            ),
                          ],
                        ),
                      ),
                    ),
                    child: Icon(
                      Icons.quiz_outlined, // Icono que deseas utilizar
                      size: 20, // Tamaño del icono
                      color: currentTheme.isDarkMode ? Color(primaryLight) : const Color(primaryDark), // Color del icono
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.9,
              height: 200,

              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15),
                  topRight: Radius.circular(21),
                  bottomLeft: Radius.circular(4),
                  bottomRight: Radius.circular(4),
                ),
                color: Colors.transparent,
                border: Border.all(
                  color: currentTheme.isDarkMode ? Color(primaryLight) : const Color(primaryDark),
                  width: 1,
                ),
              ),
              // padding: EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(right: 10, left: 10),
                    child: Icon(
                      Icons.credit_score_outlined,
                      color: currentTheme.isDarkMode ? Color(primaryLight) : const Color(primaryDark),
                      size: MediaQuery.of(context).size.width * 0.07,
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * 0.55,
                        child: Text(
                          textAlign: TextAlign.center,
                          'Banco donde realizamos tu transferencia',
                          style: TextStyle(color: currentTheme.isDarkMode ? Color(whiteText) : const Color(primaryDark), fontWeight: FontWeight.bold),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      SizedBox(height: 30),
                      Text(
                        textAlign: TextAlign.center,
                        'Cuentas agregadas',
                        style: TextStyle(color: currentTheme.isDarkMode ? Color(whiteText) : const Color(primaryDark), fontWeight: FontWeight.bold),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                  const Spacer(),
                  Container(
                    decoration: BoxDecoration(
                        color: currentTheme.isDarkMode ? Color(primaryLight) : const Color(primaryDark),
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(20),
                          bottomLeft: Radius.circular(10),
                        )),
                    width: MediaQuery.of(context).size.width * 0.21,
                    height: 71,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () {
                            getModal(context, ref);
                          },
                          child: Icon(
                            Icons.loupe_rounded,
                            size: MediaQuery.of(context).size.width * 0.05,
                            color: currentTheme.isDarkMode ? Color(primaryDark) : const Color(primaryLight),
                          ),
                        ),
                        Text(
                            textAlign: TextAlign.center,
                            'Agregar cuenta',
                            style: TextStyle(
                              fontSize: 8,
                              color: currentTheme.isDarkMode ? Color(primaryDark) : const Color(primaryLight),
                            )),
                      ],
                    ),
                  ),
                ],
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
          ],
        ),
      ),
    );
  }
}
