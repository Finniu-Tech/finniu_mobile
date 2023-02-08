import 'package:finniu/constants/colors.dart';
import 'package:flutter/material.dart';

class Section2 extends StatefulWidget {
  const Section2({super.key});

  @override
  State<Section2> createState() => _Section2State();
}

class _Section2State extends State<Section2> {
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: [
                SizedBox(
                  child: Image.asset('assets/investment/bill.png'),
                ),
              ],
            ),
            Container(
              width: 228,
              height: 95,
              padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
              child: const Text(
                '¿Has invertido tu dinero anteriormente?',
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
          child: const Text("Nunca realicé una inversión", style: TextStyle(color: Color(primaryDark))),
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
          child: const Text("Llevo menos de un año invirtiendo", style: TextStyle(color: Color(primaryDark))),
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
          child: const Text("Llevo más de 5 años invirtiendo ", style: TextStyle(color: Color(primaryDark))),
          style: TextButton.styleFrom(
            backgroundColor: const Color(primaryLightAlternative),
          ),
        ),
      ),
      const SizedBox(
        height: 11,
      ),
    ]);
    ;
  }
}
