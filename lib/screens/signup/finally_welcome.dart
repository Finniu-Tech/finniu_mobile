import 'package:flutter/material.dart';
import '../../constants/colors.dart';
import '../../widgets/buttons.dart';
import '../../widgets/fonts.dart';

class WelcomeFinally extends StatefulWidget {
  const WelcomeFinally({super.key});

  @override
  State<WelcomeFinally> createState() => _WelcomeFinallyState();
}

class _WelcomeFinallyState extends State<WelcomeFinally> {
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomRight,
          colors: [const Color(gradient_secondary), const Color(gradient_primary)],
        )),
        child: Column(children: <Widget>[
          SizedBox(height: 110),
          Container(
            width: 360,
            height: 362,
            child: Image.asset('assets/welcome/welcome4.png'),
          ),
          SizedBox(height: 16),
          TextPoppins(
            text: 'Recibe tus pagos de manera segura y puntual',
            colorText: primary_dark,
            fontSize: 24,
            fontWeight: FontWeight.w600,
          ),
          SizedBox(height: 11),
          TextPoppins(
            text: 'Recibe tu capital y tus intereses garantizado en la fecha establecida',
            colorText: primary_dark,
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
              child: CustomButton(text: 'Comenzar', colorBackground: primary_dark, colorText: white_text, pushName: '/sign_up_finally')),
        ]));
  }
}
