import 'dart:ui';

import 'package:finniu/constants/colors.dart';
import 'package:finniu/widgets/buttons.dart';
import 'package:finniu/widgets/fonts.dart';
import 'package:finniu/widgets/scaffold.dart';
import 'package:flutter/material.dart';

class ResultInvesment extends StatefulWidget {
  const ResultInvesment({super.key});

  @override
  State<ResultInvesment> createState() => _ResultInvesmentState();
}

class _ResultInvesmentState extends State<ResultInvesment> {
  @override
  Widget build(BuildContext context) {
    return CustomScaffoldReturnLogo(
        body: Column(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
      const SizedBox(height: 90),
      Stack(
        children: <Widget>[
          Align(
            alignment: Alignment.center,
            child: Container(
              padding: const EdgeInsets.only(left: 40, right: 10, top: 15, bottom: 15),
              decoration: BoxDecoration(
                color: const Color(whiteText),
                borderRadius: BorderRadius.circular(15),
                border: Border.all(
                  color: const Color(primaryLight),
                ),
              ),
              // height: 102,
              width: 272,
              child: const Text(
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                  ),
                  "Según la información que nos brindaste te recomendamos el"),
            ),
          ),
          Positioned(
            top: 20,
            left: 30,
            child: Align(
              alignment: Alignment.centerLeft,
              child: Container(
                height: 60,
                width: 60,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/result/avatar.png"),
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      const SizedBox(
        height: 20,
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('assets/result/money.png'),
          Container(
            // padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
            child: const Text(
              'Plan Origen',
              textAlign: TextAlign.left,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w700,
                color: Color(primaryDark),
              ),
            ),
          ),
        ],
      ),
      const SizedBox(
        height: 13,
      ),
      Column(
        children: [
          Container(
            padding: EdgeInsets.all(6.0),
            width: 224,
            height: 80,
            child: const Text(
              'Esta inversión prioriza la estabilidad generando una rentabilidad moderada. Si recién empiezas a invertir, este plan es perfecto para ti.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
                height: 1.5,
                fontWeight: FontWeight.w400,
                color: Color(primaryDark),
              ),
            ),
          ),
        ],
      ),
      SizedBox(
        height: 15,
      ),
      Container(
          width: 232.0,
          height: 1,
          decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: Color(gradient_primary_alternative),
                width: 2,
              ),
            ),
          )),
      const SizedBox(
        height: 18,
      ),
      Row(mainAxisAlignment: MainAxisAlignment.center, children: const [
        SizedBox(
          child: Icon(Icons.money_off_csred_outlined),
        ),
        SizedBox(
          child: Text(
            'Monto mínimo ',
            textAlign: TextAlign.left,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: Color(primaryDark),
            ),
          ),
        ),
        SizedBox(
          child: Text(
            'S/500',
            textAlign: TextAlign.left,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Color(primaryDark),
            ),
          ),
        ),
      ]),
      const SizedBox(
        height: 18,
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          SizedBox(
            child: Icon(Icons.money_off_csred),
          ),
          SizedBox(
            child: Text(
              'Retorno anual ',
              textAlign: TextAlign.left,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: Color(primaryDark),
              ),
            ),
          ),
          SizedBox(
            child: Text(
              '12%',
              textAlign: TextAlign.left,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Color(primaryDark),
              ),
            ),
          )
        ],
      ),
      const SizedBox(
        height: 45,
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 50,
            width: 156,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              color: const Color(primaryLight),
            ),
            child: const Center(
                child: CustomButton(
                    colorBackground: primaryLight,
                    text: 'Cambiar',
                    colorText: primaryDark,
                    // colorBackground: primaryDark,
                    // colorText: white_text,
                    pushName: '/investment_result')),
          ),
          const SizedBox(
            width: 7,
          ),
          Container(
            height: 50,
            width: 156,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              color: const Color(primaryDark),
            ),
            child: const Center(
                child: CustomButton(
                    text: 'Gracias',
                    // colorBackground: primaryDark,
                    // colorText: white_text,
                    pushName: '/investment_result')),
          ),
        ],
      ),
    ]));
  }
}
