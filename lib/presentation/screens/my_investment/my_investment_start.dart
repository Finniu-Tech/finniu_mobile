import 'package:finniu/constants/colors.dart';
import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:finniu/widgets/scaffold.dart';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'widgets/card.dart';

class InvestmentStart extends HookConsumerWidget {
  const InvestmentStart({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentTheme = ref.watch(settingsNotifierProvider);
    // final currentTheme = Provider.of<SettingsProvider>(context, listen: false);
    return CustomScaffoldReturnLogo(
   
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 10,
              ),
              
              SizedBox(width: 220,
                         
                child: Text(
                  'Nuestro planes de inversión',
                  style: TextStyle(
                    color: currentTheme.isDarkMode
                        ? const Color(primaryLight)
                        : const Color(primaryDark),
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
           
              Row(mainAxisAlignment: MainAxisAlignment.center,
                children: [
                
                 const Spacer(),
                  ElevatedButton(
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(13))),
                      backgroundColor: MaterialStateProperty.all<Color>(Color(
                          currentTheme.isDarkMode ? secondary : primaryLight)),
                    ),
                    onPressed: () {},
                    child: const Text(
                      "Quiero conversar",
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
              const SizedBox(
                height: 12,
              ),
              ExpandableCard(
                image: 'assets/result/money.png',
                textTiledCard: 'Plan Origen',
                textPercentage: '12%',
                textinvestment: 'S/500',
                textDeclaration: '5%',
                textContainer:
                    'Esta inversión prioriza la estabilidad generando una rentabilidad moderada. Si recién empiezas a invertir, este plan es perfecto para ti',
              ),
              const SizedBox(
                height: 10,
              ),
              ExpandableCard(
                image: 'assets/investment/billsmoney.png',
                textTiledCard: 'Plan Estable',
                textPercentage: '14% ',
                textDeclaration: '8%',
                textinvestment: 'S/1,000 ',
                textContainer:
                    ' Esta inversión busca relacion de riesgo-beneficio. Recomendable para personas que buscan otra alternativa de inversion de en el mercado.',
              ),
            const SizedBox(
                height: 10,
              ),
            ExpandableCard(
                image: 'assets/images/bills.png',
                textTiledCard: 'Plan Responsable',
                textPercentage: '16% ',
                textDeclaration: '8%',
                textinvestment: 'S/5,000 ',
                textContainer:
                    ' Esta inversión brinda una rentabilidad atractiva mayor a fondos mutuos y factoring. Esencial para aquellos que buscan incrementar sus ahorros.',
              ) ,
              const SizedBox(
                height: 10,
              ),
              
               ExpandableCard(
                image: 'assets/images/increasemoney.png',
                textTiledCard: 'Plan Crecimiento',
                textPercentage: '18% ',
                textDeclaration: '8%',
                textinvestment: 'S/10,000 ',
                textContainer:
                    ' Esta inversión se enfoca en brindar la mejor rentabilidad para aquellos inversionistas que buscan maximizar sus ganancias',
              ) ,
              
              ],
          ),
        ),
      ),
    );
  }
}
