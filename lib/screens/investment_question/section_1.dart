import 'package:finniu/constants/colors.dart';
import 'package:finniu/screens/onboarding/section_2.dart';
import 'package:finniu/widgets/buttons.dart';
import 'package:finniu/widgets/scaffold.dart';
import 'package:finniu/widgets/step_bar.dart';
import 'package:flutter/material.dart';

class Section1 extends StatefulWidget {
  const Section1({super.key});

  @override
  State<Section1> createState() => _Section1State();
}

class _Section1State extends State<Section1> {
  final PageController _controller = PageController();

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 180),
            SizedBox(
              child: Image.asset('assets/investment/star.png'),
            ),
            Container(
              width: 228,
              height: 95,
              padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
              child: const Text(
                'Selecciona tu rango de edad',
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
          child: const Text("18-25 años", style: TextStyle(color: Color(primaryDark))),
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
          child: const Text("25-35 años", style: TextStyle(color: Color(primaryDark))),
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
          child: const Text("35-45 años", style: TextStyle(color: Color(primaryDark))),
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
          child: const Text("45-50 años", style: TextStyle(color: Color(primaryDark))),
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
          child: const Text("55-65 años", style: TextStyle(color: Color(primaryDark))),
          style: TextButton.styleFrom(
            backgroundColor: const Color(primaryLightAlternative),
          ),
        ),
      ),
    ]);
    ;
  }
}
