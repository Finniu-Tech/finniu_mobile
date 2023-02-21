import 'package:finniu/constants/colors.dart';
import 'package:finniu/screens/home/widgets/modals.dart';
// import 'package:finniu/screens/my_investment/widgets/card.dart';
import 'package:finniu/widgets/buttons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import 'widgets/card.dart';

class InvestmentStart extends HookWidget {
  const InvestmentStart({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const BottomNavigationBarHome(),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
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
                    child: InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, '/home_notification');
                      },
                      child: Icon(
                        CupertinoIcons.bell,
                      ),
                    ),
                  ),
                  Container(
                    height: 43,
                    width: 41,
                    alignment: Alignment.topRight,
                    child: InkWell(
                        onTap: () {
                          showSettingsDialog(context);
                        },
                        child: Image.asset('assets/home/avatar.png')),
                  ),
                ],
              ),
              Container(
                alignment: Alignment.topLeft,
                child: const Text(
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
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Color(gradient_secondary_option),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Row(
                  children: [
                    SizedBox(
                      height: 103,
                      width: 100,
                      child: Image.asset('assets/investment/investment.png'),
                    ),
                    SizedBox(
                      width: 180,
                      child: Text(
                        'Hola Mari, puedes visualizar nuestros planes y simular tu inversión para comenzar a invertir desde hoy.',
                        textAlign: TextAlign.justify,
                        style: TextStyle(
                          height: 1.5,
                          fontSize: 12,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  const Text(
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
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(borderRadius: BorderRadius.circular(13))),
                      backgroundColor: MaterialStateProperty.all<Color>(Color(gradient_primary)),
                    ),
                    onPressed: () {},
                    child: const Text(
                      "Agendar sesión 1:1",
                      style: TextStyle(
                        color: Color(primaryDark),
                        decoration: TextDecoration.underline,
                        decorationColor: Color(primaryDark),
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 12,
              ),
              ExpandableCard(
                image: 'assets/result/money.png',
                textTiledCard: 'Plan Origen',
                textPercentage: '12%',
                textinvestment: '500',
                textDeclaration: '5%',
                textContainer: 'Esta inversión prioriza la estabilidad generando una rentabilidad moderada. Si recién empiezas a invertir, este plan es perfecto para ti',
              ),
              SizedBox(
                height: 10,
              ),
              ExpandableCard(
                image: 'assets/investment/billsmoney.png',
                textTiledCard: 'Plan Estable',
                textPercentage: '14% ',
                textDeclaration: '8%',
                textinvestment: 'S/1,000 ',
                textContainer: ' Esta inversión brinda una rentabilidad atractiva',
              )
            ],
          ),
        ),
      ),
    );
  }
}
