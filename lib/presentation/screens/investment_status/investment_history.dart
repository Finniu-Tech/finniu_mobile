import 'package:finniu/constants/colors.dart';
import 'package:finniu/constants/number_format.dart';
import 'package:finniu/domain/entities/investment_history_entity.dart';
import 'package:finniu/presentation/providers/investment_status_report_provider.dart';
import 'package:finniu/presentation/providers/money_provider.dart';
import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:finniu/presentation/screens/investment_status/widgets/empty_message.dart';
import 'package:finniu/widgets/scaffold.dart';
import 'package:finniu/widgets/switch.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class InvestmentHistory extends StatefulHookConsumerWidget {
  const InvestmentHistory({super.key});

  @override
  InvestmentHistoryState createState() => InvestmentHistoryState();
}

class InvestmentHistoryState extends ConsumerState<InvestmentHistory>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  @override
  void initState() {
    _tabController = TabController(length: 4, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final currentTheme = ref.watch(settingsNotifierProvider);
    final isSoles = ref.watch(isSolesStateProvider);
    return CustomScaffoldReturnLogo(
      hideReturnButton: true,
      body: HookBuilder(
        builder: (context) {
          final historyFutureResponse =
              ref.watch(investmentHistoryReportFutureProvider);

          return historyFutureResponse.when(
            data: (data) {
              final historySoles = data.solesHistory;
              final historyDollars = data.dollarsHistory;
              final history = isSoles ? historySoles : historyDollars;
              if (historySoles.countTotalHistory() == 0 &&
                  historyDollars.countTotalHistory() == 0) {
                return SizedBox(
                  height: MediaQuery.of(context).size.height * 0.6,
                  child: Center(
                    child: EmptyHistoryMessage(
                      is_history_screen: true,
                    ),
                  ),
                );
              } else {
                return InvestmentHistoryBody(
                  currentTheme: currentTheme,
                  tabController: _tabController,
                  history: history,
                  isSoles: isSoles,
                );
              }
            },
            loading: () => const Center(
              child: CircularProgressIndicator(),
            ),
            error: (error, stack) => SizedBox(
              height: MediaQuery.of(context).size.height * 0.6,
              child: Center(
                child: EmptyHistoryMessage(
                  is_history_screen: true,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class InvestmentHistoryBody extends StatelessWidget {
  final SettingsProviderState currentTheme;
  final TabController _tabController;
  final InvestmentHistoryResumeEntity history;
  final bool isSoles;

  InvestmentHistoryBody({
    super.key,
    required this.currentTheme,
    required TabController tabController,
    required this.history,
    required this.isSoles,
  }) : _tabController = tabController;

  DateFormat dateFormat = DateFormat.MMMM('es');
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.9,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                child: Row(
                  children: [
                    Text(
                      ' Mis inversiones 💸 ',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                        color: Color(
                          Theme.of(context).colorScheme.secondary.value,
                        ),
                      ),
                    ),
                    const Spacer(),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, '/calendar_page');
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(5),
                        child: Image.asset(
                          'assets/icons/calendar.png',
                          width: 20,
                          height: 20,
                          color: currentTheme.isDarkMode
                              ? const Color(primaryLight)
                              : const Color(primaryDark),
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
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      // Navigator.pushNamed(context, '/process_investment');
                      Navigator.pop(context);
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.45,
                      height: 40,
                      decoration: BoxDecoration(
                        color: currentTheme.isDarkMode
                            ? const Color(primaryDark)
                            : const Color(primaryLightAlternative),
                        borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(20),
                          topLeft: Radius.circular(20),
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20),
                        ),
                      ),
                      child: Center(
                        child: Text(
                          "Rentabilidad",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: currentTheme.isDarkMode
                                ? const Color(whiteText)
                                : const Color(primaryDark),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.45,
                    height: 40,
                    decoration: BoxDecoration(
                      color: currentTheme.isDarkMode
                          ? const Color(primaryLight)
                          : const Color(primaryDark),
                      borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(20),
                        topLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20),
                        bottomLeft: Radius.circular(20),
                      ),
                    ),
                    child: Center(
                      child: GestureDetector(
                        onTap: () {
                          // Navigator.pushNamed(context, '/investment_history');
                        },
                        child: Text(
                          "Mi historial",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: currentTheme.isDarkMode
                                ? const Color(primaryDark)
                                : const Color(whiteText),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              const SwitchMoney(
                switchHeight: 34,
                switchWidth: 67,
              ),
              const SizedBox(
                height: 20,
              ),
              // const SizedBox(
              //   height: 20,
              // ),
              CircularImageSimulation(
                amount: history.totalAmount,
                isSoles: isSoles,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Estado de mis inversiones ',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: currentTheme.isDarkMode
                          ? const Color(whiteText)
                          : const Color(blackText),
                    ),
                  ),
                ),
              ),
              Column(
                children: [
                  TabBar(
                    isScrollable: true,
                    unselectedLabelColor: currentTheme.isDarkMode
                        ? const Color(whiteText)
                        : const Color(blackText),
                    labelColor: currentTheme.isDarkMode
                        ? const Color(primaryLight)
                        : const Color(primaryDark),
                    labelStyle: const TextStyle(fontSize: 12),
                    tabs: [
                      Tab(
                        text: (history.investmentsInCourse?.length ?? 0) > 0
                            ? "En curso(${history.investmentsInCourse!.length})"
                            : "En curso",
                      ),
                      Tab(
                        text: (history.investmentsFinished?.length ?? 0) > 0
                            ? "Finalizadas(${history.investmentsFinished!.length})"
                            : "Finalizadas",
                      ),
                      Tab(
                        child: RichText(
                          text: TextSpan(
                            text: (history.investmentsInProcess?.length ?? 0) >
                                    0
                                ? "En proceso(${history.investmentsInProcess!.length})"
                                : "En proceso",
                            style: TextStyle(
                              color: currentTheme.isDarkMode
                                  ? const Color(whiteText)
                                  : const Color(
                                      blackText,
                                    ), // color del texto antes del paréntesis
                              fontSize: 12.0,
                            ),
                          ),
                        ),
                      ),
                      Tab(
                        child: RichText(
                          text: TextSpan(
                            text: (history.investmentsCanceled?.length ?? 0) > 0
                                ? "Rechazados(${history.investmentsCanceled!.length})"
                                : "Rechazados",
                            style: TextStyle(
                              color: currentTheme.isDarkMode
                                  ? const Color(whiteText)
                                  : const Color(
                                      blackText,
                                    ), // color del texto antes del paréntesis
                              fontSize: 12.0,
                            ),
                          ),
                        ),
                      ),
                    ],
                    controller: _tabController,
                    indicatorSize: TabBarIndicatorSize.tab,
                    indicatorColor: currentTheme.isDarkMode
                        ? const Color(secondary)
                        : const Color(primaryLight),
                    indicatorWeight: 4.0,
                    indicatorPadding: const EdgeInsets.only(bottom: 10),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 300,
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    ListView(
                      children: history.investmentsInCourse!
                          .map(
                            (e) => InCourseInvestmentCard(
                              planName: e.planName,
                              termText:
                                  'Plazo de ${e.deadLineValue} meses: ${e.rentabilityPercent}%',
                              initialAmount: e.totalAmount.toString(),
                              startDay:
                                  '${e.startDate?.day} ${dateFormat.format(e.startDate!)}',
                              finishDay:
                                  '${e.endDate?.day} ${dateFormat.format(e.endDate!)} ${e.endDate?.year}',
                              imageStatus: 'assets/images/circle_green.png',
                              isSoles: isSoles,
                              state: 'En curso',
                            ),
                          )
                          .toList(),
                    ),
                    ListView(
                      children: history.investmentsFinished!
                          .map(
                            (e) => InCourseInvestmentCard(
                              planName: e.planName,
                              termText:
                                  'Plazo de ${e.deadLineValue} meses: ${e.rentabilityPercent}%',
                              initialAmount: e.totalAmount.toString(),
                              startDay:
                                  '${e.startDate?.day} ${dateFormat.format(e.startDate!)}',
                              finishDay:
                                  '${e.endDate?.day} ${dateFormat.format(e.endDate!)} ${e.endDate?.year}',
                              imageStatus: 'assets/images/circle_purple.png',
                              isSoles: isSoles,
                              state: 'Finalizado',
                            ),
                          )
                          .toList(),
                    ),
                    ListView(
                      children: history.investmentsInProcess!
                          .map(
                            (e) => TablePlanProcess(
                              planName: e.planName,
                              termText: 'Se esta validando tu transferencia',
                              state: 'En proceso',
                              mounted: e.totalAmount,
                              isSoles: isSoles,
                            ),
                          )
                          .toList(),
                    ),
                    ListView(
                      children: history.investmentsCanceled!
                          .map(
                            (e) => TablePlanProcess(
                              planName: e.planName,
                              termText: 'Su inversión ha sido rechazada',
                              state: 'Rechazado',
                              mounted: e.totalAmount,
                              isSoles: isSoles,
                            ),
                          )
                          .toList(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CircularImageSimulation extends ConsumerWidget {
  final double amount;
  final bool isSoles;
  const CircularImageSimulation({
    super.key,
    required this.amount,
    required this.isSoles,
  });
  // const CircularImageSimulation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final themeProvider = ref.watch(settingsNotifierProvider);
    return Column(
      children: [
        CircularPercentIndicator(
          circularStrokeCap: CircularStrokeCap.round,
          radius: 86.0,
          lineWidth: 12.0,
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
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Dinero invertido",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: themeProvider.isDarkMode
                          ? const Color(whiteText)
                          : const Color(primaryDark),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  isSoles
                      ? formatterSoles.format(amount)
                      : formatterUSD.format(amount),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: themeProvider.isDarkMode
                        ? const Color(primaryLight)
                        : const Color(primaryDark),
                  ),
                ),
              ],
            ),
          ),
          progressColor: Color(
            themeProvider.isDarkMode ? gradient_secondary_option : primaryDark,
          ),
          backgroundColor: Color(
            themeProvider.isDarkMode ? primaryLightAlternative : primaryLight,
          ),
          fillColor: themeProvider.isDarkMode
              ? const Color(backgroundColorDark)
              : Colors.white,
        ),
        const SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 15,
              height: 15,
              decoration: BoxDecoration(
                border: Border.all(
                  width: 1,
                  color: const Color(primaryLight),
                ),
                shape: BoxShape.circle,
                color: const Color(primaryLight),
              ),
              // Si desea agregar un icono dentro del círculo
            ),

            const SizedBox(width: 5), // Separación entre el círculo y el texto
            Text(
              'Plan Origen',
              style: TextStyle(
                fontSize: 10,
                color: themeProvider.isDarkMode
                    ? const Color(whiteText)
                    : const Color(blackText),
              ),
            ),

            const SizedBox(
              width: 20,
            ),
            Container(
              width: 15,
              height: 15,
              decoration: BoxDecoration(
                border: Border.all(width: 1, color: const Color(primaryDark)),
                shape: BoxShape.circle,
                color: themeProvider.isDarkMode
                    ? const Color(gradient_secondary_option)
                    : const Color(primaryDark),
              ),
            ),

            const SizedBox(width: 5),
            Text(
              'Plan Estable',
              style: TextStyle(
                fontSize: 10,
                color: themeProvider.isDarkMode
                    ? const Color(whiteText)
                    : const Color(blackText),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
      ],
    );
  }
}

class InCourseInvestmentCard extends ConsumerWidget {
  final String planName;
  final String termText;
  final String initialAmount;
  final String startDay;
  final String finishDay;
  final String imageStatus;
  final bool isSoles;
  final String state;

  const InCourseInvestmentCard({
    super.key,
    required this.planName,
    required this.termText,
    required this.initialAmount,
    required this.startDay,
    required this.finishDay,
    required this.imageStatus,
    required this.isSoles,
    required this.state,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentTheme = ref.watch(settingsNotifierProvider);
    return Center(
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        width: MediaQuery.of(context).size.width * 0.9,
        height: 120,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.6),
              spreadRadius: 0,
              blurRadius: 2,
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ],
          color: currentTheme.isDarkMode
              ? const Color(primaryDark)
              : const Color(primaryLightAlternative),
          borderRadius: BorderRadius.circular(25),
        ),
        child: Padding(
          padding:
              const EdgeInsets.only(right: 13, left: 13, top: 5, bottom: 5),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Text(
                    planName,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: currentTheme.isDarkMode
                          ? const Color(whiteText)
                          : const Color(blackText),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  // Text(
                  //   '$moneySymbol$initialAmount',
                  //   style: TextStyle(
                  //     fontSize: 16,
                  //     fontWeight: FontWeight.bold,
                  //     color: currentTheme.isDarkMode ? const Color(primaryLight) : const Color(blackText),
                  //   ),
                  // ),
                  const Spacer(),
                  Image.asset(
                    alignment: Alignment.center,
                    imageStatus,
                    height: 15,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    state,
                    style: TextStyle(
                      fontSize: 11,
                      color: currentTheme.isDarkMode
                          ? const Color(whiteText)
                          : const Color(blackText),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 0,
              ),
              Text(
                isSoles
                    ? formatterSoles.format(double.parse(initialAmount))
                    : formatterUSD.format(double.parse(initialAmount)),
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: currentTheme.isDarkMode
                      ? const Color(primaryLight)
                      : const Color(blackText),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                termText,
                style: TextStyle(
                  fontSize: 10,
                  color: currentTheme.isDarkMode
                      ? const Color(graytextalternative)
                      : const Color(grayText),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Text(
                    'Inicio',
                    style: TextStyle(
                      fontSize: 9,
                      fontWeight: FontWeight.bold,
                      color: currentTheme.isDarkMode
                          ? const Color(whiteText)
                          : const Color(blackText),
                    ),
                  ),
                  const SizedBox(
                    width: 2,
                  ),
                  Text(
                    startDay,
                    style: TextStyle(
                      fontSize: 9,
                      fontWeight: FontWeight.bold,
                      color: currentTheme.isDarkMode
                          ? const Color(whiteText)
                          : const Color(blackText),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.03,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Spacer(),
                  Text(
                    'Finaliza:',
                    style: TextStyle(
                      fontSize: 12,
                      color: currentTheme.isDarkMode
                          ? const Color(whiteText)
                          : const Color(blackText),
                    ),
                  ),
                  Text(
                    finishDay,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: currentTheme.isDarkMode
                          ? const Color(whiteText)
                          : const Color(blackText),
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

class TablePlanProcess extends ConsumerWidget {
  final String planName;
  final String termText;
  final String state;
  final double mounted;
  final bool isSoles;

  const TablePlanProcess({
    super.key,
    required this.planName,
    required this.termText,
    required this.state,
    required this.mounted,
    required this.isSoles,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentTheme = ref.watch(settingsNotifierProvider);
    final moneySymbol = isSoles ? "S/" : "\$";
    return Center(
      child: Container(
        width: MediaQuery.of(context).size.width * 0.9,
        margin: const EdgeInsets.only(bottom: 10),
        height: 100,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.6),
              spreadRadius: 0,
              blurRadius: 2,
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ],
          color: currentTheme.isDarkMode
              ? const Color(primaryDark)
              : const Color(primaryLightAlternative),
          borderRadius: BorderRadius.circular(25),
        ),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    planName,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: currentTheme.isDarkMode
                          ? const Color(whiteText)
                          : const Color(blackText),
                    ),
                  ),
                  const SizedBox(
                    width: 4,
                  ),
                  // Text(
                  //   '$moneySymbol$mounted',
                  //   style: TextStyle(
                  //     fontSize: 16,
                  //     fontWeight: FontWeight.bold,
                  //     color: currentTheme.isDarkMode ? const Color(primaryLight) : const Color(blackText),
                  //   ),
                  // ),
                  const SizedBox(
                    width: 10,
                  ),
                  const Spacer(),
                  Container(
                    width: 15,
                    height: 15,
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 1,
                        color: Color(
                          state == 'Rechazado' ? Colors.red.value : primaryDark,
                        ),
                      ),
                      shape: BoxShape.circle,
                      color: Color(
                        state == 'Rechazado' ? Colors.red.value : primaryDark,
                      ),
                      // color: currentTheme.isDarkMode
                      //     ? const Color(primaryLight)
                      //     : const Color(primaryDark),
                    ),
                    // Si desea agregar un icono dentro del círculo
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    state,
                    style: TextStyle(
                      fontSize: 11,
                      color: currentTheme.isDarkMode
                          ? const Color(whiteText)
                          : const Color(blackText),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              //ADD AMOUNT
              Row(
                children: [
                  Text(
                    'Monto invertido: ',
                    style: TextStyle(
                      fontSize: 10,
                      color: currentTheme.isDarkMode
                          ? const Color(whiteText)
                          : const Color(blackText),
                    ),
                  ),
                  Text(
                    isSoles
                        ? formatterSoles.format(mounted)
                        : formatterUSD.format(mounted),
                    style: TextStyle(
                      fontSize: 10,
                      color: currentTheme.isDarkMode
                          ? const Color(primaryLight)
                          : const Color(blackText),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                termText,
                style: TextStyle(
                  fontSize: 10,
                  color: currentTheme.isDarkMode
                      ? const Color(whiteText)
                      : const Color(blackText),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TablePlanProcessRejected extends ConsumerWidget {
  final String planName;
  final String termText;
  final String state;
  final String mounted;

  const TablePlanProcessRejected({
    super.key,
    required this.planName,
    required this.termText,
    required this.state,
    required this.mounted,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentTheme = ref.watch(settingsNotifierProvider);
    return SingleChildScrollView(
      child: Center(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.9,
          height: 90,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.6),
                spreadRadius: 0,
                blurRadius: 2,
                offset: const Offset(0, 3), // changes position of shadow
              ),
            ],
            color: currentTheme.isDarkMode
                ? const Color(primaryDark)
                : const Color(primaryLightAlternative),
            borderRadius: BorderRadius.circular(25),
          ),
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      planName,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: currentTheme.isDarkMode
                            ? const Color(whiteText)
                            : const Color(blackText),
                      ),
                    ),
                    const SizedBox(
                      width: 4,
                    ),
                    Text(
                      mounted,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: currentTheme.isDarkMode
                            ? const Color(primaryLight)
                            : const Color(blackText),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    const Spacer(),
                    Container(
                      width: 15,
                      height: 15,
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 1,
                          color: const Color(redText),
                        ),
                        shape: BoxShape.circle,
                        color: const Color(redText),
                      ),
                      // Si desea agregar un icono dentro del círculo
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      state,
                      style: TextStyle(
                        fontSize: 11,
                        color: currentTheme.isDarkMode
                            ? const Color(whiteText)
                            : const Color(blackText),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  termText,
                  style: TextStyle(
                    fontSize: 10,
                    color: currentTheme.isDarkMode
                        ? const Color(whiteText)
                        : const Color(blackText),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
