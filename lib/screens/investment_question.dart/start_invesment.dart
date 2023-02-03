import 'package:flutter/material.dart';

import '../../constants/colors.dart';
import '../../widgets/buttons.dart';
import '../../widgets/fonts.dart';
import '../../widgets/scaffold.dart';
import '../../widgets/textfield.dart';

class StartInvestment extends StatefulWidget {
  const StartInvestment({super.key});

  @override
  State<StartInvestment> createState() => _StartInvestmentState();
}

class _StartInvestmentState extends State<StartInvestment> {
  @override
  Widget build(BuildContext context) {
    return CustomScaffoldReturnLogo(
        body: Center(
            child: Column(children: <Widget>[
      Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: const [
          SizedBox(height: 90),
        ],
      ),
      SizedBox(
        width: 70,
        height: 70,
        child: Image.asset('assets/investment/logo.png'),
      ),
      const TextPoppins(
        text: 'Queremos conocerte para ofrecerte lo mejor',
        colorText: primaryDark,
        fontSize: 24,
        fontWeight: FontWeight.w600,
      ),
      const SizedBox(height: 20),
      Row(mainAxisAlignment: MainAxisAlignment.end, children: <Widget>[
        SizedBox(
          width: 40,
          height: 40,
          child: Image.asset('assets/investment/arrow.png'),
        ),
      ]),
      Stack(children: <Widget>[
        SizedBox(
          width: 99,
          height: 99,
          child: Image.asset('assets/investment/avatar.png'),
        ),
      ]),
      Container(
        width: 276,
        height: 163,
        decoration: BoxDecoration(color: const Color(primaryLightAlternative), borderRadius: BorderRadius.circular(15)),
        child: const Align(
          alignment: Alignment(-0.0, -0.0),
          child: SizedBox(
            width: 184,
            height: 103,
            child: Text(
              'Hola,Mari queremos conocer tus metas que quieres lograr invirtiendo y poder ayudarte a recomendarte la mejor opción.',
              textAlign: TextAlign.right,
              style: TextStyle(
                color: Colors.black,
                fontSize: 14,
                fontWeight: FontWeight.w400,
                height: 1.5,
              ),
            ),
          ),
        ),
      ),
      const SizedBox(
        height: 60,
      ),
      GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: const CustomButton(
              text: 'Continuar',
              // colorBackground: primaryDark,
              // colorText: white_text,
              width: 224,
              height: 50,
              pushName: '/investment_start')),
    ])));
  }
}
