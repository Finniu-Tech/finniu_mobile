import 'package:finniu/constants/colors.dart';
import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:finniu/widgets/scaffold.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class InvestmentHistory extends StatefulHookConsumerWidget {
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
    return CustomScaffoldReturnLogo(
      hideReturnButton: true,
      body: Padding(
        padding: const EdgeInsets.only(top: 20),
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
                              Theme.of(context).colorScheme.secondary.value),
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
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, '/process_investment');
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
                              Navigator.pushNamed(
                                  context, '/investment_history');
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
                            )),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                const SizedBox(
                  height: 20,
                ),
                const CircularImageSimulation(),
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
                          const Tab(
                            text: "En curso",
                          ),
                          const Tab(
                            text: "Finalizadas",
                          ),
                          Tab(
                            child: RichText(
                              text: TextSpan(
                                text: 'En proceso ',
                                style: TextStyle(
                                  color: currentTheme.isDarkMode
                                      ? const Color(whiteText)
                                      : const Color(
                                          blackText), // color del texto antes del paréntesis
                                  fontSize: 12.0,
                                ),
                                children: <TextSpan>[
                                  TextSpan(
                                    text: '(1)',
                                    style: TextStyle(
                                      color: currentTheme.isDarkMode
                                          ? const Color(primaryLight)
                                          : const Color(
                                              bluelight), // color del texto dentro del paréntesis
                                      fontSize: 12.0,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Tab(
                            child: RichText(
                              text: TextSpan(
                                text: 'Rechazados ',
                                style: TextStyle(
                                  color: currentTheme.isDarkMode
                                      ? const Color(whiteText)
                                      : const Color(
                                          blackText), // color del texto antes del paréntesis
                                  fontSize: 12.0,
                                ),
                                children: <TextSpan>[
                                  const TextSpan(
                                    text: '(1)',
                                    style: TextStyle(
                                      color: Color(
                                          redText), // color del texto dentro del paréntesis
                                      fontSize: 16.0,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                        controller: _tabController,
                        indicatorSize: TabBarIndicatorSize.tab,
                        indicatorColor: currentTheme.isDarkMode
                            ? const Color(secondary)
                            : const Color(primaryLight),
                        indicatorWeight: 4.0,
                        indicatorPadding: const EdgeInsets.only(bottom: 10)),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Expanded(
                  child: TabBarView(
                    children: [
                      ListView(children: [
                        const TablePlan(
                          planName: "Plan Estable",
                          termText: "Plazo de 12 meses:14%",
                          mounted: "S/1500",
                          startDay: "29 Mayo",
                          finishDay: "29 Mayo 2023",
                          state: "En Curso",
                          imageLink: "assets/images/circle_green.png",
                        ),
                        const SizedBox(
                          height: 17,
                        ),
                        const TablePlan(
                            planName: "Plan Estable",
                            termText: "Plazo de 12 meses:14%",
                            mounted: "S/720",
                            startDay: "29 Mayo",
                            finishDay: "29 Mayo 2023",
                            state: "En Curso",
                            imageLink: "assets/images/circle_green.png"),
                        const SizedBox(
                          height: 17,
                        ),
                        const TablePlan(
                            planName: "Plan Estable",
                            termText: "Plazo de 12 meses:14%",
                            mounted: "S/5400",
                            startDay: "29 Mayo",
                            finishDay: "13 Abril 2023",
                            state: "En Curso",
                            imageLink: "assets/images/circle_green.png"),
                      ]),
                      const TablePlan(
                        planName: "Plan Estable",
                        termText: "Plazo de 12 meses:14%",
                        mounted: "S/1140",
                        startDay: "29 Enero 2022",
                        finishDay: "29 Enero 2023",
                        state: "Finalizado",
                        imageLink: "assets/images/circle_purple.png",
                      ),
                      const TablePlanProcess(
                        planName: "Plan Origen",
                        termText: "Se esta validando tu transferencia",
                        state: "En proceso",
                        mounted: "S/800",
                      ),
                      const TablePlanProcessRejected(
                        planName: "Plan Origen ",
                        mounted: "S/750",
                        termText:
                            "Tu inversión fue rechazada por el siguiente motivo:(escribir floro de explicación)",
                        state: "Rechazado",
                      ),
                    ],
                    controller: _tabController,
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

class CircularImageSimulation extends ConsumerWidget {
  const CircularImageSimulation({Key? key}) : super(key: key);

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
                            : const Color(primaryDark)),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  "S/4050",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: themeProvider.isDarkMode
                          ? const Color(primaryLight)
                          : const Color(primaryDark)),
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

class TablePlan extends ConsumerWidget {
  final String planName;
  final String termText;
  final String mounted;
  final String startDay;
  final String finishDay;
  final String state;
  final String imageLink;

  const TablePlan({
    super.key,
    required this.planName,
    required this.termText,
    required this.mounted,
    required this.startDay,
    required this.finishDay,
    required this.state,
    required this.imageLink,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentTheme = ref.watch(settingsNotifierProvider);
    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: SingleChildScrollView(
        child: Center(
          child: Container(
            width: MediaQuery.of(context).size.width * 0.9,
            height: 110,
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
                borderRadius: BorderRadius.circular(25)),
            child: Padding(
              padding: const EdgeInsets.all(13.0),
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
                      const Spacer(),
                      Image.asset(
                        alignment: Alignment.center,
                        imageLink,
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
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Plazo de 12 meses: 14%',
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
        ),
      ),
    );
  }
}

class TablePlanProcess extends ConsumerWidget {
  final String planName;
  final String termText;
  final String state;
  final String mounted;

  const TablePlanProcess({
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
              borderRadius: BorderRadius.circular(25)),
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
                            color: const Color(primaryDark),
                          ),
                          shape: BoxShape.circle,
                          color: currentTheme.isDarkMode
                              ? const Color(primaryLight)
                              : const Color(primaryDark),
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
                ]),
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
              borderRadius: BorderRadius.circular(25)),
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
                ]),
          ),
        ),
      ),
    );
  }
}
