import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:finniu/constants/colors.dart';
import 'package:finniu/providers/settings_provider.dart';
import 'package:finniu/screens/confirmation_phone/confirmation_phone_screen.dart';
import 'package:finniu/screens/investment_confirmation/step_1.dart';
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
        child: Column(
          children: <Widget>[
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
          ],
        ),
      ),
    );
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
