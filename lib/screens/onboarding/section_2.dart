import 'package:finniu/constants/colors.dart';
import 'package:finniu/widgets/buttons.dart';
import 'package:finniu/widgets/fonts.dart';
import 'package:flutter/material.dart';

class Section2 extends StatelessWidget {
  const Section2({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      // decoration: const BoxDecoration(
      //     gradient: LinearGradient(
      //   begin: Alignment.topCenter,
      //   end: Alignment.bottomRight,
      //   colors: [Color(gradient_primary), Color(gradient_secondary)],
      // )),
      child: Column(
        children: <Widget>[
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
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
