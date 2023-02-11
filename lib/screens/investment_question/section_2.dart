import 'package:finniu/constants/colors.dart';
import 'package:finniu/widgets/buttons.dart';
import 'package:flutter/material.dart';

class Section2 extends StatefulWidget {
  PageController controller = PageController();
  Section2({super.key, required this.controller});

  @override
  State<Section2> createState() => _Section2State();
}

class _Section2State extends State<Section2> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 50),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            SizedBox(
              width: 228,
              height: 95,
              child: Text(
                '¿Has invertido tu dinero anteriormente?',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  color: Color(primaryDark),
                ),
              ),
            ),
          ],
        ),
        Column(
          children: [
            SizedBox(
              child: Image.asset(
                'assets/investment/bills.png',
                width: 124.38,
                height: 89.7,
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 14,
        ),
        ButtonQuestions(text: "Nunca realicé una inversión ", controller: widget.controller),
        const SizedBox(
          height: 11,
        ),
        ButtonQuestions(text: "Llevo menos de un año invirtiendo", controller: widget.controller),

        const SizedBox(
          height: 11,
        ),
        ButtonQuestions(text: "Llevo entre 1 a 5 años invirtiendo", controller: widget.controller),

        const SizedBox(
          height: 15,
        ),
        ButtonQuestions(text: "Llevo más de 5 años invirtiendo", controller: widget.controller),

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
