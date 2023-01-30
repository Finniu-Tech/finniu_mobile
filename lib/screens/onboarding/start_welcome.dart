import 'package:flutter/material.dart';

import '../../constants/colors.dart';
import '../../widgets/buttons.dart';
import '../../widgets/fonts.dart';

class StartWelcomeFinniu extends StatefulWidget {
  const StartWelcomeFinniu({super.key});

  @override
  State<StartWelcomeFinniu> createState() => _StartWelcomeFinniuState();
}

class _StartWelcomeFinniuState extends State<StartWelcomeFinniu> {
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomRight,
          colors: [const Color(gradient_primary), const Color(gradient_secondary)],
        )),
        child: Column(children: <Widget>[
          SizedBox(height: 110),
          Container(
            width: 360,
            height: 362,
            child: Image.asset('assets/welcome/welcome2.png'),
          ),
          SizedBox(height: 16),
          TextPoppins(
            text: 'Multiplica tu dinero de forma sencilla',
            colorText: primary_dark,
            fontSize: 24,
            fontWeight: FontWeight.w600,
          ),
          SizedBox(height: 11),
          TextPoppins(
            text: 'Puedes invertir en plazos de 6 y 12 meses con intereses mensuales. ',
            colorText: primary_dark,
            fontSize: 16,
            fontWeight: FontWeight.w400,
          ),
          Container(
            width: 50,
            height: 50,
          ),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: CusttomButtomRoundedLight(pushName: '/on_boarding_welcome'),
            ),
            Container(
              width: 80,
              height: 0,
            ),
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: CustomButtonRoundedDart(pushName: '/on_boarding_middle'),
            )
          ])
        ]));
  }
}
