import 'package:finniu/constants/colors.dart';
import 'package:finniu/screens/onboarding/section_2.dart';
import 'package:finniu/widgets/buttons.dart';
import 'package:finniu/widgets/scaffold.dart';
import 'package:finniu/widgets/step_bar.dart';
import 'package:flutter/material.dart';

class Section1 extends StatefulWidget {
  PageController controller = PageController();
  Section1({super.key, required this.controller});

  @override
  State<Section1> createState() => _Section1State();
}

class _Section1State extends State<Section1> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              child: Image.asset('assets/investment/star.png'),
            ),
            const SizedBox(
              width: 228,
              height: 95,
              child: Text(
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
        ButtonQuestions(text: "18-25 años", controller: widget.controller),
        const SizedBox(
          height: 11,
        ),
        ButtonQuestions(text: "25-35 años", controller: widget.controller),

        const SizedBox(
          height: 11,
        ),
        ButtonQuestions(text: "35-45 años", controller: widget.controller),

        const SizedBox(
          height: 11,
        ),
        ButtonQuestions(text: "45-50 años", controller: widget.controller),

        const SizedBox(
          height: 11,
        ),
        ButtonQuestions(text: "55-65 años", controller: widget.controller),

        const SizedBox(
          height: 5,
        ),
        // const CustomButton(
        //   text: 'Continuar',
        //   width: 224,
        //   height: 50,
        //   pushName: '/investment_result',
        // ),
      ],
    );
    ;
  }
}
