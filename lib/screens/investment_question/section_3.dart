import 'package:finniu/constants/colors.dart';
import 'package:finniu/widgets/buttons.dart';
import 'package:flutter/material.dart';

class Section3 extends StatelessWidget {
  const Section3({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
                SizedBox(
                  child: Image.asset('assets/investment/arrow.png'),
                ),
                const Text(
                  'Mari, cuentanos cual es tu meta que buscas lograr con tus inversiones',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    height: 1.5,
                  ),
                )
              ],
            ),
            Container(
              width: 228,
              height: 95,
              padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
              child: const Text(
                '¿Cual es tu meta para invertir ?',
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  color: Color(primaryDark),
                ),
              ),
            ),
          ],
        ),
      ),
      SizedBox(
        width: 320,
        height: 53,
        child: TextButton(
          onPressed: () {},
          child: const Text("Tener dinero para mis emergencias", style: TextStyle(color: Color(primaryDark))),
          style: TextButton.styleFrom(
            backgroundColor: const Color(primaryLightAlternative),
          ),
        ),
      ),
      const SizedBox(
        height: 11,
      ),
      SizedBox(
        width: 320,
        height: 53,
        child: TextButton(
          onPressed: () {},
          child: const Text("Tener dinero para mis gastos de estudios", style: TextStyle(color: Color(primaryDark))),
          style: TextButton.styleFrom(
            backgroundColor: const Color(primaryLightAlternative),
          ),
        ),
      ),
      const SizedBox(
        height: 11,
      ),
      SizedBox(
        width: 320,
        height: 53,
        child: TextButton(
          onPressed: () {},
          child: const Text("Llevo entre 1 a 5 años invirtiendo", style: TextStyle(color: Color(primaryDark))),
          style: TextButton.styleFrom(
            backgroundColor: const Color(primaryLightAlternative),
          ),
        ),
      ),
      const SizedBox(
        height: 11,
      ),
      SizedBox(
        width: 320,
        height: 53,
        child: TextButton(
          onPressed: () {},
          child: const Text("Tener dinero para mis épocas sin trabajo ", style: TextStyle(color: Color(primaryDark))),
          style: TextButton.styleFrom(
            backgroundColor: const Color(primaryLightAlternative),
          ),
        ),
      ),
      SizedBox(
        width: 320,
        height: 53,
        child: TextButton(
          onPressed: () {},
          child: const Text("Tener dinero para viajar ", style: TextStyle(color: Color(primaryDark))),
          style: TextButton.styleFrom(
            backgroundColor: const Color(primaryLightAlternative),
          ),
        ),
      ),
      SizedBox(
        width: 320,
        height: 53,
        child: TextButton(
          onPressed: () {},
          child: const Text("Tener dinero para comprarme una casa", style: TextStyle(color: Color(primaryDark))),
          style: TextButton.styleFrom(
            backgroundColor: const Color(primaryLightAlternative),
          ),
        ),
      ),
      const SizedBox(
        height: 11,
      ),
      const CustomButton(
        text: 'Finalizar',
        width: 224,
        height: 50,
        pushName: '/investment_select',
      ),
    ]);
    ;
  }
}
