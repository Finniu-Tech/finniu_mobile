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
    return Scaffold(
        body: Container(
            decoration: const BoxDecoration(
                gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomRight,
              colors: [Color(gradient_primary), Color(gradient_secondary)],
            )),
            child: Column(children: <Widget>[
              const SizedBox(height: 110),
              Container(
                width: 360,
                height: 362,
                child: Image.asset('assets/welcome/welcome2.png'),
              ),
              const SizedBox(height: 16),
              const TextPoppins(
                text: 'Multiplica tu dinero de forma sencilla',
                colorText: primaryDark,
                fontSize: 24,
                fontWeight: FontWeight.w600,
              ),
              const SizedBox(height: 11),
              const TextPoppins(
                text: 'Puedes invertir en plazos de 6 y 12 meses con intereses mensuales. ',
                colorText: primaryDark,
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
              const SizedBox(
                width: 50,
                height: 50,
              ),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const CusttomButtomRoundedLight(pushName: '/on_boarding_welcome'),
                ),
                const SizedBox(width: 80),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const CustomButtonRoundedDart(pushName: '/on_boarding_middle'),
                )
              ])
            ])));
  }
}
