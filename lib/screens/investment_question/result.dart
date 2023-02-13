import 'package:finniu/constants/colors.dart';
import 'package:finniu/providers/theme_provider.dart';
import 'package:finniu/widgets/buttons.dart';
import 'package:finniu/widgets/fonts.dart';
import 'package:finniu/widgets/scaffold.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ResultInvestment extends StatefulWidget {
  ResultInvestment({super.key});

  @override
  State<ResultInvestment> createState() => _ResultInvestmentState();
}

class _ResultInvestmentState extends State<ResultInvestment> {
  @override
  Widget build(BuildContext context) {
    final currentTheme = Provider.of<ThemeProvider>(context, listen: false);
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
                color: currentTheme.isDarkMode ? Colors.transparent : const Color(whiteText),
                borderRadius: BorderRadius.circular(15),
                border: Border.all(
                  color: const Color(primaryLight),
                ),
              ),
              // height: 102,
              width: 272,
              child: Text(
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 16,
                    color: currentTheme.isDarkMode ? const Color(whiteText) : const Color(blackText),
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
                    image: AssetImage("assets/investment/avatararrow.png"),
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
            child: Text(
              'Plan Origen',
              textAlign: TextAlign.left,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w700,
                color: currentTheme.isDarkMode ? const Color(0xffA2E6FA) : const Color(primaryDark),
              ),
            ),
          ),
        ],
      ),
      Column(
        children: [
          Container(
            padding: EdgeInsets.all(6.0),
            width: 224,
            height: 80,
            child: Text(
              'Esta inversión prioriza la estabilidad generando una rentabilidad moderada. Si recién empiezas a invertir, este plan es perfecto para ti.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
                height: 1.5,
                fontWeight: FontWeight.w400,
                color: currentTheme.isDarkMode ? Colors.white : const Color(primaryDark),
              ),
            ),
          ),
        ],
      ),
      const SizedBox(
        height: 13,
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
        height: 13,
      ),
      SizedBox(
        width: 285,
        child: Table(
          // textDirection: TextDirection.ltr,
          children: [
            TableRow(children: [
              SizedBox(
                width: 24,
                height: 24,
                child: ColorFiltered(colorFilter: ColorFilter.mode(currentTheme.isDarkMode ? const Color(primaryLight) : const Color(primaryDark), BlendMode.srcIn), child: Image.asset('assets/investment/dollar-circle.png')),
              ),
              SizedBox(
                child: Text(
                  'Monto mínimo ',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: currentTheme.isDarkMode ? const Color(0xffA2E6FA) : const Color(primaryDark),
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
                    color: currentTheme.isDarkMode ? const Color(0xffA2E6FA) : const Color(primaryDark),
                  ),
                ),
              ),
            ]),
            TableRow(children: [
              SizedBox(
                width: 24,
                height: 24,
                child: ColorFiltered(colorFilter: ColorFilter.mode(currentTheme.isDarkMode ? const Color(primaryLight) : const Color(primaryDark), BlendMode.srcIn), child: Image.asset('assets/investment/bitcoin-convert.png')),
              ),
              SizedBox(
                child: Text(
                  'Retorno anual ',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: currentTheme.isDarkMode ? const Color(0xffA2E6FA) : const Color(primaryDark),
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
                    color: currentTheme.isDarkMode ? const Color(0xffA2E6FA) : const Color(primaryDark),
                  ),
                ),
              )
            ]),
          ],
        ),
      ),
      const SizedBox(height: 60),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 50,
            width: 156,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              color: Color(primaryLight),
            ),
            child: Center(
                child: CustomButton(
                    colorBackground: currentTheme.isDarkMode ? (primaryDark) : (primaryLight),
                    text: 'Cambiar',
                    colorText: currentTheme.isDarkMode ? (whiteText) : (primaryDark),
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
              color: Color(primaryDark),
            ),
            child: Center(
                child: CustomButton(
                    colorBackground: currentTheme.isDarkMode ? (primaryLight) : (primaryDark),
                    text: 'Gracias',
                    // colorBackground: primaryDark,
                    // colorText: white_text,

                    colorText: currentTheme.isDarkMode ? (primaryDark) : (whiteText),
                    pushName: '/home_home')),
          ),
        ],
      ),
    ]));
  }
}
