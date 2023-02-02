import 'package:finniu/widgets/fonts.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../constants/colors.dart';
import '../../widgets/buttons.dart';
import '../../widgets/scaffold.dart';

class WelcomeFinniu extends StatefulWidget {
  const WelcomeFinniu({super.key});

  @override
  State<WelcomeFinniu> createState() => _WelcomeFinniuState();
}

class _WelcomeFinniuState extends State<WelcomeFinniu> {
  @override
  Widget build(BuildContext context) {
    return CustomScaffoldReturn(
        body: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomRight,
                colors: [const Color(primaryDark), const Color(gradient_primary_alternative)],
              ),
            ),
            child: Column(children: <Widget>[
              Container(
                width: 360,
                height: 362,
                child: Image.asset('assets/welcome/welcome1.png'),
              ),
              SizedBox(height: 12),
              TextPoppins(
                text: '¡Bienvenidos a Finniu!',
                colorText: primaryLight,
                fontSize: 24,
                fontWeight: FontWeight.w600,
              ),
              SizedBox(height: 9),
              TextPoppins(
                text: 'Somos un equipo con la misión de ayudar a jóvenes profesionales a invertir su dinero de forma sencilla y transparente. ',
                colorText: white_text,
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
              Container(
                width: 67,
                height: 75,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: CustomButtonRoundedDart(pushName: '/on_boarding_start'),
              )
            ])));
  }
}
