import 'package:finniu/constants/colors.dart';
import 'package:finniu/widgets/fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class Section1 extends StatelessWidget {
  const Section1({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      // decoration: const BoxDecoration(
      //     // gradient: LinearGradient(
      //     //   begin: Alignment.topCenter,
      //     //   end: Alignment.bottomRight,
      //     //   colors: [
      //     //     Color(primaryDark),
      //     //     Color(gradient_primary_alternative)
      //     //   ],
      //     // ),
      //     ),
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 100,
          ),
          SizedBox(
            width: double.infinity,
            // height: 362,
            // flex: BoxFit.fitWidth,
            child: Image.asset(
              'assets/welcome/welcome1.png',
              fit: BoxFit.fitWidth,
            ),
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
            text:
                'Somos un equipo con la misión de ayudar a jóvenes profesionales a invertir su dinero de forma sencilla y transparente. ',
            colorText: whiteText,
            fontSize: 16,
            fontWeight: FontWeight.w400,
          ),
          const SizedBox(height: 10),
          // StepBar(
          //   currentStep: 1,
          //   totalSteps: 4,
          //   // maxSteps: 4,
          // ),
          // const SizedBox(
          //   height: 10,
          // ),
          // GestureDetector(
          //   onTap: () {
          //     Navigator.pop(context);
          //   },
          //   child: const CustomButtonRoundedDark(
          //       pushName: '/on_boarding_start'),
          // )
        ],
      ),
    );
  }
}
