import 'package:flutter/material.dart';
import '../../constants/colors.dart';
import '../../widgets/buttons.dart';
import '../../widgets/fonts.dart';

class WelcomeMiddle extends StatefulWidget {
  const WelcomeMiddle({super.key});

  @override
  State<WelcomeMiddle> createState() => _WelcomeMiddleState();
}

class _WelcomeMiddleState extends State<WelcomeMiddle> {
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomRight,
          colors: [const Color(gradient_primary_alternative), const Color(gradient_secondary_alternative), const Color(gradient_third_alternative)],
        )),
        child: Column(children: <Widget>[
          SizedBox(height: 110),
          Container(
            width: 360,
            height: 362,
            child: Image.asset('assets/welcome/welcome3.png'),
          ),
          SizedBox(height: 16),
          TextPoppins(
            text: 'Invierte de manera segura y transparente',
            colorText: white_text,
            fontSize: 24,
            fontWeight: FontWeight.w600,
          ),
          SizedBox(height: 11),
          TextPoppins(
            text: 'Invierte con nosotros desde S/500 y sin comisiones',
            colorText: white_text,
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
              child: CusttomButtomRoundedLight(pushName: '/sign_up_start'),
            ),
            Container(
              width: 80,
              height: 0,
            ),
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: CusttomButtomRoundedDart(pushName: '/sign_up_finally'),
            )
          ])
        ]));
  }
}
