import 'package:finniu/constants/colors.dart';
import 'package:finniu/widgets/fonts.dart';
import 'package:flutter/material.dart';

class Section3 extends StatelessWidget {
  const Section3({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
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
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
