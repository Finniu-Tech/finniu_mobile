import 'package:finniu/constants/colors.dart';
import 'package:finniu/widgets/fonts.dart';
import 'package:flutter/material.dart';

class Section4 extends StatelessWidget {
  const Section4({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      // decoration: const BoxDecoration(
      //     gradient: LinearGradient(
      //   begin: Alignment.topCenter,
      //   end: Alignment.bottomRight,
      //   colors: [Color(gradient_secondary), Color(gradient_primary)],
      // )),
      child: Column(
        children: <Widget>[
          SizedBox(height: 120),
          SizedBox(
            width: 360,
            height: 362,
            child: Image.asset('assets/welcome/welcome4.png'),
          ),
          const SizedBox(height: 6),
          const TextPoppins(
            text: 'Recibe tus pagos de manera segura y puntual',
            colorText: primaryDark,
            fontSize: 24,
            fontWeight: FontWeight.w600,
          ),
          SizedBox(
            width: 350,
            child: const TextPoppins(
              text:
                  'Recibe tu capital y tus intereses garantizado en la fecha establecida',
              colorText: primaryDark,
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
