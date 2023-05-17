import 'package:finniu/constants/colors.dart';
import 'package:finniu/widgets/buttons.dart';
import 'package:finniu/widgets/fonts.dart';
import 'package:flutter/material.dart';

class Section2 extends StatelessWidget {
  const Section2({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        // const SizedBox(height: 110),
        SizedBox(
          width: double.infinity,
          height: MediaQuery.of(context).size.height * 0.5,
          child: Image.asset('assets/welcome/welcome2.png'),
        ),
        const SizedBox(height: 15),
        const TextPoppins(
          text: 'Multiplica tu dinero de forma sencilla',
          colorText: primaryDark,
          fontSize: 24,
          fontWeight: FontWeight.w600,
        ),
        const SizedBox(height: 11),
        Container(
          width: MediaQuery.of(context).size.width * 0.7,
          constraints: const BoxConstraints(maxWidth: 500),
          child: const TextPoppins(
            text:
                'Puedes invertir en plazos de 6 y 12 meses con intereses mensuales. ',
            colorText: primaryDark,
            fontSize: 16,
            fontWeight: FontWeight.w400,
          ),
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}
