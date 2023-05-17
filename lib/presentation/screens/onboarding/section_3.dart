import 'package:finniu/constants/colors.dart';
import 'package:finniu/widgets/fonts.dart';
import 'package:flutter/material.dart';

class Section3 extends StatelessWidget {
  const Section3({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        // const SizedBox(height: 110),
        SizedBox(
          width: double.infinity,
          // height: 362,
          height: MediaQuery.of(context).size.height * 0.5,
          child: Image.asset('assets/welcome/welcome3.png'),
        ),
        const SizedBox(height: 15),
        const TextPoppins(
          text: 'Invierte de manera segura y transparente',
          colorText: whiteText,
          fontSize: 24,
          fontWeight: FontWeight.w600,
        ),
        const SizedBox(height: 11),
        Container(
          width: MediaQuery.of(context).size.width * 0.7,
          constraints: const BoxConstraints(maxWidth: 300),
          child: const TextPoppins(
            text: 'Invierte con nosotros desde S/500 y sin comisiones',
            colorText: whiteText,
            fontSize: 16,
            fontWeight: FontWeight.w400,
          ),
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}
