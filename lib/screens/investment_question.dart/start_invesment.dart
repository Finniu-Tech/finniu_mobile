import 'package:finniu/constants/colors.dart';
import 'package:finniu/widgets/buttons.dart';
import 'package:finniu/widgets/fonts.dart';
import 'package:finniu/widgets/scaffold.dart';
import 'package:flutter/material.dart';

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
        ),
        Positioned(
          bottom: -2, // Establece la posición vertical de la imagen
          right: 2, // Establece la posición horizontal de la imagen
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
            height: 80,
            child: Text(
              'Hola,Mari queremos conocer tus metas que quieres lograr invirtiendo y poder ayudarte a recomendarte la mejor opción de plan de inversión para ti.',
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
