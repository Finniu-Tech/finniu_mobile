import 'package:finniu/constants/colors.dart';
import 'package:finniu/widgets/fonts.dart';
import 'package:flutter/material.dart';

class Section4 extends StatelessWidget {
  const Section4({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        // const SizedBox(height: 120),
        SizedBox(
          width: double.infinity,
          // height: 362,
          height: MediaQuery.of(context).size.height * 0.5,
          child: Image.asset('assets/welcome/welcome4.png'),
        ),
        const SizedBox(height: 15),
        const TextPoppins(
          text: 'Recibe tus pagos de manera segura y puntual',
          colorText: primaryDark,
          fontSize: 24,
          fontWeight: FontWeight.w600,
        ),
        const SizedBox(height: 11),
        TextPoppins(
          text:
              'Recibe tu capital y tus intereses garantizado en la fecha establecida',
          colorText: primaryDark,
          fontSize: 16,
          fontWeight: FontWeight.w400,
        ),

        // const SizedBox(height: 10),
      ],
    );
  }
}
