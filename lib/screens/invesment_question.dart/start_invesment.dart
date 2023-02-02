import 'package:flutter/material.dart';

import '../../constants/colors.dart';
import '../../widgets/buttons.dart';
import '../../widgets/fonts.dart';
import '../../widgets/scaffold.dart';
import '../../widgets/textfield.dart';

class StartInvesment extends StatefulWidget {
  const StartInvesment({super.key});

  @override
  State<StartInvesment> createState() => _StartInvesmentState();
}

class _StartInvesmentState extends State<StartInvesment> {
  @override
  Widget build(BuildContext context) {
    return CustomScaffoldReturn(
        body: Center(
            child: Column(children: <Widget>[
      SizedBox(height: 90),
      TextPoppins(
        text: 'Queremos conocerte para ofrecerte lo mejor',
        colorText: primaryDark,
        fontSize: 24,
        fontWeight: FontWeight.w600,
      ),
      Container(
        width: 30,
        height: 30,
      ),
      Stack(children: <Widget>[
        Container(
          width: 99,
          height: 99,
          child: Image.asset('assets/investment/logo.png'),
        ),
      ]),
      Container(
        width: 273,
        height: 163,
        decoration: BoxDecoration(color: const Color(primaryLightAlternative), borderRadius: BorderRadius.circular(15)),
        child: Align(
          alignment: Alignment(-0.0, -0.0),
          child: Container(
            width: 184,
            height: 103,
            child: Text(
              'Hola,Mari queremos conocer tus metas que quieres lograr invirtiendo y poder ayudarte a recomendarte la mejor opción.',
              textAlign: TextAlign.right,
              style: TextStyle(
                color: Colors.black,
                fontSize: 11,
                fontWeight: FontWeight.w400,
                height: 1.5,
              ),
            ),
          ),
        ),
      ),
      Container(
        width: 80,
        height: 70,
      ),
      GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: CustomButton(
              text: 'Continuar',
              // colorBackground: primaryDark,
              // colorText: white_text,
              width: 224,
              height: 50,
              pushName: '/invesment_start')),
    ])));
  }
}
