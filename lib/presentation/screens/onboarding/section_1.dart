import 'package:finniu/constants/colors.dart';
import 'package:finniu/widgets/fonts.dart';
import 'package:flutter/material.dart';


class Section1 extends StatelessWidget {
  const Section1({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        children: <Widget>[
          // const SizedBox(
          //   height: 100,
          // ),
          SizedBox(
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.5,
            // flex: BoxFit.fitWidth,
            child: Image.asset(
              'assets/welcome/welcome1.png',
              fit: BoxFit.fitWidth,
            ),
          ),
          const SizedBox(height: 15),
          const TextPoppins(
            text: '¡Bienvenidos a Finniu!',
            colorText: primaryLight,
            fontSize: 24,
            fontWeight: FontWeight.w600,
          ),
          const SizedBox(height: 11),
          const TextPoppins(
            text:
                'Somos un equipo con la misión de ayudar a jóvenes profesionales a invertir su dinero de forma sencilla y transparente. ',
            colorText: whiteText,
            fontSize: 16,
            fontWeight: FontWeight.w400,
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
