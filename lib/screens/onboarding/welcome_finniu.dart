import 'package:finniu/constants/colors.dart';
import 'package:finniu/widgets/buttons.dart';
import 'package:finniu/widgets/fonts.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class WelcomeFinniu extends StatefulWidget {
  const WelcomeFinniu({super.key});

  @override
  State<WelcomeFinniu> createState() => _WelcomeFinniuState();
}

class _WelcomeFinniuState extends State<WelcomeFinniu> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(primaryDark),
          elevation: 0,
        ),
        body: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomRight,
                colors: [Color(primaryDark), Color(gradient_primary_alternative)],
              ),
            ),
            child: Column(children: <Widget>[
              SizedBox(
                width: 360,
                height: 362,
                child: Image.asset('assets/welcome/welcome1.png'),
              ),
              const SizedBox(height: 20),
              const TextPoppins(
                text: '¡Bienvenidos a Finniu!',
                colorText: primaryLight,
                fontSize: 24,
                fontWeight: FontWeight.w600,
              ),
              const SizedBox(height: 9),
              const TextPoppins(
                text: 'Somos un equipo con la misión de ayudar a jóvenes profesionales a invertir su dinero de forma sencilla y transparente. ',
                colorText: white_text,
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
              const SizedBox(height: 80),
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: const CustomButtonRoundedDart(pushName: '/on_boarding_start'),
              )
            ])));
  }
}
