import 'dart:html';

import 'package:finniu/constants/colors.dart';
import 'package:finniu/widgets/buttons.dart';
import 'package:finniu/widgets/scaffold.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class InvestmentStart extends StatelessWidget {
  const InvestmentStart({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: 60,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: 60,
                  width: 60,
                  alignment: Alignment.topLeft,
                  child: Image.asset('assets/images/logo_small.png'),
                ),
                const Spacer(),
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(
                    CupertinoIcons.bell,
                  ),
                ),
                Container(
                  height: 43,
                  width: 41,
                  alignment: Alignment.topRight,
                  child: Image.asset('assets/home/avatar.png'),
                ),
              ],
            ),
            Container(
              alignment: Alignment.topLeft,
              child: Text(
                'Mis inversiones',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            SizedBox(
              height: 15.0,
            ),
            Container(
              alignment: Alignment.topLeft,
              width: MediaQuery.of(context).size.width * 0.8,
              height: 129.0,
              decoration: BoxDecoration(
                color: Color(gradient_secondary_option),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Row(
                children: [
                  SizedBox(height: 103, width: 109, child: Image.asset('assets/investment/investment.png')),
                  Expanded(
                    child: Text(
                      'Mari, bienvenida a Finniu comienza a vivir financieramente estable desde hoy',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        height: 1.5,
                        fontSize: 14,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Text(
                  'Planes de inversión',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    height: 1.5,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(primaryDark),
                  ),
                ),
                SizedBox(
                  width: 40,
                ),
                ElevatedButton(
                  style: ButtonStyle(
                      fixedSize: MaterialStateProperty.all<Size>(
                    Size(132, 32),
                  )),
                  onPressed: () {},
                  child: Text(
                    "Agendar sesión 1:1",
                    style: TextStyle(
                      color: Color(primaryDark),
                      backgroundColor: Color(primaryLight),
                      fontSize: 12,
                    ),
                  ),

                  // text: "Agendar sesión 1:1",
                  // colorText: primaryDark,
                  // colorBackground: primaryLight,
                  // width: 132,
                  // height: 32,
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
