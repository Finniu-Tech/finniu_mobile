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
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomRight,
          colors: [Color(gradient_primary_alternative), Color(gradient_secondary_alternative), Color(gradient_third_alternative)],
        )),
        child: Column(
          children: <Widget>[
            const SizedBox(height: 110),
            Container(
              width: 360,
              height: 362,
              child: Image.asset('assets/welcome/welcome3.png'),
            ),
            const SizedBox(height: 16),
            const TextPoppins(
              text: 'Invierte de manera segura y transparente',
              colorText: white_text,
              fontSize: 24,
              fontWeight: FontWeight.w600,
            ),
            const SizedBox(height: 11),
            const TextPoppins(
              text: 'Invierte con nosotros desde S/500 y sin comisiones',
              colorText: white_text,
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
            const SizedBox(height: 50),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const CusttomButtomRoundedLight(pushName: '/on_boarding_start'),
                ),
                const SizedBox(width: 80),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const CustomButtonRoundedDart(pushName: '/on_boarding_finally'),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
