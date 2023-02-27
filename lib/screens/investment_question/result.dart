import 'package:finniu/constants/colors.dart';
import 'package:finniu/providers/settings_provider.dart';
import 'package:finniu/widgets/buttons.dart';
import 'package:finniu/widgets/scaffold.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ResultInvestment extends ConsumerWidget {
  const ResultInvestment({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentTheme = ref.watch(settingsNotifierProvider);
    // final currentTheme = Provider.of<SettingsProvider>(context, listen: false);
    return CustomScaffoldReturnLogo(
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              const SizedBox(height: 40),
              Stack(
                children: <Widget>[
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                      width: 272,
                      height: 102,
                      padding: const EdgeInsets.only(
                        left: 45,
                        right: 15,
                        top: 15,
                        bottom: 15,
                      ),
                      decoration: BoxDecoration(
                        color: currentTheme.isDarkMode
                            ? Colors.transparent
                            : const Color(whiteText),
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(
                          color: const Color(primaryLight),
                        ),
                      ),
                      child: Text(
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: 16,
                          color: currentTheme.isDarkMode
                              ? const Color(whiteText)
                              : const Color(blackText),
                          fontWeight: FontWeight.w500,
                        ),
                        "Según la información que nos brindaste te recomendamos el",
                      ),
                    ),
                  ),
                  Positioned(
                    top: 20,
                    left: 20,
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        height: 60,
                        width: 60,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image:
                                AssetImage("assets/investment/avatararrow.png"),
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
                  SizedBox(
                    height: 90,
                    width: 90,
                    child: Image.asset('assets/result/money.png'),
                  ),
                  Container(
                    // padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
                    child: Text(
                      'Plan Origen',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                        color: currentTheme.isDarkMode
                            ? const Color(0xffA2E6FA)
                            : const Color(primaryDark),
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
                        color: currentTheme.isDarkMode
                            ? Colors.white
                            : const Color(primaryDark),
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
                ),
              ),
              const SizedBox(
                height: 13,
              ),
              SizedBox(
                width: 230,
                child: Table(
                  columnWidths: {
                    0: FlexColumnWidth(1),
                    1: FlexColumnWidth(3),
                    2: FlexColumnWidth(2),
                  },
                  // textDirection: TextDirection.ltr,
                  children: [
                    TableRow(
                      children: [
                        TableCell(
                          // width: 24,
                          // height: 24,
                          verticalAlignment: TableCellVerticalAlignment.middle,
                          child: ColorFiltered(
                            colorFilter: ColorFilter.mode(
                              currentTheme.isDarkMode
                                  ? const Color(primaryLight)
                                  : const Color(primaryDark),
                              BlendMode.srcIn,
                            ),
                            child: Image.asset(
                              'assets/investment/dollar-circle.png',
                              height: 24,
                              width: 24,
                            ),
                          ),
                        ),
                        TableCell(
                          verticalAlignment: TableCellVerticalAlignment.middle,
                          child: Text(
                            'Monto mínimo ',
                            // textAlign: TextAlign.left,

                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: currentTheme.isDarkMode
                                  ? const Color(0xffA2E6FA)
                                  : const Color(primaryDark),
                            ),
                          ),
                        ),
                        TableCell(
                          verticalAlignment: TableCellVerticalAlignment.middle,
                          child: Text(
                            'S/500',
                            // textAlign: TextAlign.left,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: currentTheme.isDarkMode
                                  ? const Color(0xffA2E6FA)
                                  : const Color(primaryDark),
                            ),
                          ),
                        ),
                      ],
                    ),
                    TableRow(
                      children: [
                        TableCell(
                          verticalAlignment: TableCellVerticalAlignment.middle,
                          child: ColorFiltered(
                            colorFilter: ColorFilter.mode(
                              currentTheme.isDarkMode
                                  ? const Color(primaryLight)
                                  : const Color(primaryDark),
                              BlendMode.srcIn,
                            ),
                            child: Image.asset(
                              'assets/investment/bitcoin-convert.png',
                            ),
                          ),
                        ),
                        TableCell(
                          verticalAlignment: TableCellVerticalAlignment.middle,
                          child: Text(
                            'Retorno anual ',
                            // textAlign: TextAlign.left,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: currentTheme.isDarkMode
                                  ? const Color(0xffA2E6FA)
                                  : const Color(primaryDark),
                            ),
                          ),
                        ),
                        TableCell(
                          verticalAlignment: TableCellVerticalAlignment.middle,
                          child: Text(
                            '12%',
                            // textAlign: TextAlign.left,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: currentTheme.isDarkMode
                                  ? const Color(0xffA2E6FA)
                                  : const Color(primaryDark),
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 60),
              Wrap(
                // mainAxisAlignment: MainAxisAlignment.center,
                spacing: 10.0,
                runSpacing: 20.0,
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
                        colorBackground: currentTheme.isDarkMode
                            ? (primaryDark)
                            : (primaryLight),
                        text: 'Cambiar',
                        colorText: currentTheme.isDarkMode
                            ? (whiteText)
                            : (primaryDark),
                        // colorBackground: primaryDark,
                        // colorText: white_text,
                        pushName: '/investment_start',
                      ),
                    ),
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
                        colorBackground: currentTheme.isDarkMode
                            ? (primaryLight)
                            : (primaryDark),
                        text: 'Gracias',
                        // colorBackground: primaryDark,
                        // colorText: white_text,

                        colorText: currentTheme.isDarkMode
                            ? (primaryDark)
                            : (whiteText),
                        pushName: '/home_home',
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
