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
            colorText: primaryDark,
            fontSize: 24,
            fontWeight: FontWeight.w600,
          ),
          SizedBox(height: 11),
          TextPoppins(
            text: 'Recibe tu capital y tus intereses garantizado en la fecha establecida',
            colorText: primaryDark,
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
              child: CusttomButtomRoundedLight(pushName: '/on_boarding_middle'),
            ),
            Container(
              width: 80,
              height: 0,
            ),
            GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: CustomButton(
                    text: 'Comenzar',
                    // colorBackground: primaryDark,
                    // colorText: white_text,
                    width: 116,
                    height: 40,
                    pushName: '/invesment_start')),
          ])
        ]));
  }
}
