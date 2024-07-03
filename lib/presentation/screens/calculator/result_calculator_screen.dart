import 'package:finniu/constants/colors.dart';
import 'package:finniu/domain/entities/calculate_investment.dart';
import 'package:finniu/infrastructure/models/calculate_investment.dart';
import 'package:finniu/presentation/providers/calculate_investment_provider.dart';
import 'package:finniu/presentation/providers/money_provider.dart';
import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:finniu/presentation/screens/home/widgets/navigation_bar.dart';
import 'package:finniu/widgets/buttons.dart';
import 'package:finniu/widgets/graphics.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:intl/date_symbol_data_local.dart';

class ResultCalculator extends HookConsumerWidget {
  const ResultCalculator({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentTheme = ref.watch(settingsNotifierProvider);
    final themeProvider = ref.watch(settingsNotifierProvider);
    final input = ModalRoute.of(context)!.settings.arguments;
    final isSoles = ref.watch(isSolesStateProvider);

    return Scaffold(
      backgroundColor: currentTheme.isDarkMode
          ? const Color(backgroundColorDark)
          : const Color(whiteText),
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.surface,
        elevation: 0,
        leading: themeProvider.isDarkMode
            ? const CustomReturnButton(
                colorBoxdecoration: primaryDark,
                colorIcon: primaryDark,
              )
            : const CustomReturnButton(),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 14.0),
            child: SizedBox(
              width: 70,
              height: 70,
              child: themeProvider.isDarkMode
                  ? Image.asset('assets/images/logo_small_dark.png')
                  : Image.asset('assets/images/logo_small.png'),
            ),
          ),
        ],
      ),
      bottomNavigationBar: const NavigationBarHome(),
      body: HookBuilder(
        builder: (context) {
          final resultsProvider = ref.watch(
            calculateInvestmentFutureProvider(
              input as CalculatorInput,
            ),
          );
          return resultsProvider.when(
            data: (resultSimulation) {
              return BodyScreen(
                currentTheme: currentTheme,
                resultSimulation: resultSimulation,
              );
            },
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (error, _) => Padding(
              padding: const EdgeInsets.all(15.0),
              child: Center(child: Text(error.toString())),
            ),
          );
        },
      ),
    );
  }
}

class BodyScreen extends StatelessWidget {
  final SettingsProviderState currentTheme;
  final PlanSimulation resultSimulation;
  late final DateTime date;

  BodyScreen({
    super.key,
    required this.resultSimulation,
    required this.currentTheme,
  });

  @override
  Widget build(BuildContext context) {
    final returnDate = resultSimulation.plan?.returnEstimatedDate;
    final formattedReturnDate = returnDate != null
        ? DateFormat('d ' 'MMMM', 'es').format(returnDate)
        : '';

    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Container(
              alignment: Alignment.centerLeft,
              child: Text(
                resultSimulation.plan!.name,
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(Theme.of(context).colorScheme.secondary.value),
                ),
              ),
            ),
          ),
          const SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                alignment: Alignment.center,
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    CircularImageSimulation(
                      resultSimulation.months,
                      resultSimulation.plan?.imageUrl,
                    ),
                    Positioned(
                      right: 125,
                      child: Align(
                        alignment: Alignment.center,
                        child: Container(
                          width: 60,
                          height: 35,
                          // padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: currentTheme.isDarkMode
                                ? const Color(primaryLight)
                                : const Color(primaryDark),
                            border: Border.all(
                              width: 4,
                              color: currentTheme.isDarkMode
                                  ? const Color(primaryLight)
                                  : const Color(primaryDark),
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          // color: Color(primaryDark),

                          child: Column(
                            children: [
                              Center(
                                child: Text(
                                  resultSimulation.months == 12
                                      ? '${resultSimulation.plan!.twelveMonthsReturn.toString()} %'
                                      : '${resultSimulation.plan!.sixMonthsReturn.toString()} %',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: currentTheme.isDarkMode
                                        ? const Color(primaryDark)
                                        : const Color(primaryLight),
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                              Text(
                                textAlign: TextAlign.center,
                                'Rentabilidad',
                                style: TextStyle(
                                  color: currentTheme.isDarkMode
                                      ? const Color(blackText)
                                      : const Color(whiteText),
                                  fontSize: 7,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          SizedBox(
            width: 210,
            child: Text(
              textAlign: TextAlign.center,
              resultSimulation.plan?.description ?? '',
              style: TextStyle(
                height: 1.5,
                color: currentTheme.isDarkMode
                    ? const Color(whiteText)
                    : const Color(primaryDark),
                fontSize: 12,
              ),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          LineReportCalculatorWidget(
            initialAmount: resultSimulation.initialAmount.toDouble(),
            finalAmount: resultSimulation.profitability!.toDouble(),
            revenueAmount: resultSimulation.profitability! -
                resultSimulation.initialAmount,
            months: resultSimulation.months,
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8, right: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: InkWell(
                    onTap: () => showDialog<String>(
                      barrierColor: Colors.transparent,
                      context: context,
                      builder: (BuildContext context) => ConstrainedBox(
                        constraints: const BoxConstraints(),
                        child: Padding(
                          padding: const EdgeInsets.only(top: 200, left: 90),
                          child: DialogInfoInvestmentWidget(),
                        ),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(right: 20),
                      child: Row(
                        children: [
                          Text(
                            'Declaración a la Sunat 5%',
                            style: TextStyle(
                              fontSize: 14,
                              height: 1.5,
                              color: currentTheme.isDarkMode
                                  ? const Color(whiteText)
                                  : const Color(blackText),
                            ),
                          ),
                          SizedBox(width: 5),
                          ImageIcon(
                            const AssetImage('assets/icons/questions.png'),
                            size: 20,
                            color: currentTheme.isDarkMode
                                ? const Color(primaryLight)
                                : const Color(primaryDark),
                          ),
                          const SizedBox(width: 5),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            width: 390,
            height: 150,
            // padding: const EdgeInsets.all(20),
            child: Stack(
              alignment: Alignment.center,
              children: <Widget>[
                Container(
                  width: 330,
                  height: 110,
                  decoration: BoxDecoration(
                    color: currentTheme.isDarkMode
                        ? const Color(backgroundColorDark)
                        : const Color(whiteText),
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(
                      color: const Color(gradient_secondary_option),
                      width: 2,
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 200,
                        child: Text(
                          "Fecha estimada de tu retorno si empiezas a invertir desde hoy.",
                          textAlign: TextAlign.justify,
                          style: TextStyle(
                            fontSize: 12,
                            height: 1.5,
                            color: currentTheme.isDarkMode
                                ? const Color(whiteText)
                                : const Color(blackText),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 7,
                      ),
                      Text(
                        '$formattedReturnDate',
                        // "${resultSimulation.plan?.returnEstimatedDate}",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: currentTheme.isDarkMode
                              ? const Color(primaryLight)
                              : const Color(primaryDark),
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: 35,
                  left: -0,
                  child: SizedBox(
                    height: 81,
                    width: 86,
                    child: Image.asset(
                      "assets/images/calendar.png",
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            width: 224,
            height: 50,
            child: TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/plan_list');
              },
              child: const Text(
                'Comenzar a invertir',
              ),
            ),
          ),
          const SizedBox(
            height: 30,
          )
        ],
      ),
    );
  }
}

class DialogInfoInvestmentWidget extends StatelessWidget {
  const DialogInfoInvestmentWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: const Color(primaryLightAlternative),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 90,
                // constraints:
                //     const BoxConstraints(maxHeight: 10),
                child: Align(
                  alignment: Alignment.topRight,
                  child: InkWell(
                    onTap: () => Navigator.of(context).pop(),
                    child: IconButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      alignment: Alignment.topRight,
                      icon: const Padding(
                        padding: EdgeInsets.only(left: 20, bottom: 20),
                        child: Icon(Icons.close, size: 30, color: Colors.black),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Container(
            // width:
            //     MediaQuery.of(context).size.width * 0.3,
            child: const Text(
              'Este 5% es la tributación correspondiente por renta de 2da categoria (inversiones).Aplica sobre tus intereses ganados. ',
              textAlign: TextAlign.justify,
              style: TextStyle(
                fontSize: 14,
                height: 1.5,
                color: Color(blackText),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class CircularImageSimulation extends ConsumerWidget {
  final months;
  final planImage;

  const CircularImageSimulation(this.months, this.planImage, {super.key});

  @override
  Widget build(BuildContext context, ref) {
    final themeProvider = ref.watch(settingsNotifierProvider);
    return Container(
      alignment: Alignment.center,
      child: CircularPercentIndicator(
        circularStrokeCap: CircularStrokeCap.round,
        radius: 75.0,
        lineWidth: 10.0,
        percent: 0.5,
        center: CircleAvatar(
          radius: 50,
          backgroundColor: themeProvider.isDarkMode
              ? const Color(backgroundColorDark)
              : Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                alignment: Alignment.topCenter,
                child: SizedBox(
                    child: planImage != '' && planImage != null
                        ? Image.network(
                            planImage,
                            fit: BoxFit.contain,
                            width: 55,
                            height: 60,
                          )
                        : Image.asset(
                            'assets/result/money.png',
                            width: 55,
                            height: 60,
                          )
                    // child:  Image.asset(
                    //   'assets/result/money.png',
                    //   width: 55,
                    //   height: 60,
                    // ),
                    ),
              ),
              const SizedBox(height: 8),
              Text(
                "$months meses",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: themeProvider.isDarkMode
                        ? const Color(primaryLight)
                        : const Color(primaryDark)),
              ),
            ],
          ),
        ),
        progressColor:
            Color(themeProvider.isDarkMode ? primaryLight : primaryDark),
        backgroundColor:
            Color(themeProvider.isDarkMode ? primaryDark : primaryLight),
        fillColor: themeProvider.isDarkMode
            ? const Color(backgroundColorDark)
            : Colors.white,
      ),
    );
  }
}
