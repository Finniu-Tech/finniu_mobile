import 'dart:async';
import 'dart:ui';

import 'package:finniu/constants/colors.dart';
import 'package:finniu/domain/entities/investment_rentability_report_entity.dart';
import 'package:finniu/infrastructure/mappers/calculate_investment_mapper.dart';
import 'package:finniu/presentation/providers/investment_status_report_provider.dart';
import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:finniu/presentation/screens/home/widgets/empty_message.dart';
import 'package:finniu/presentation/screens/investment_status/widgets/empty_message.dart';
import 'package:finniu/widgets/scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

class InvestmentProcess extends StatefulHookConsumerWidget {
  @override
  InvestmentProcessState createState() => InvestmentProcessState();
}

class InvestmentProcessState extends ConsumerState<InvestmentProcess>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final currentTheme = ref.watch(settingsNotifierProvider);

    return WillPopScope(
      onWillPop: () => Future.value(false),
      child: CustomScaffoldReturnLogo(
        hideReturnButton: true,
        body: HookBuilder(
          builder: (context) {
            final reportFuture =
                ref.watch(investmentStatusReportFutureProvider);
            return reportFuture.when(
              data: (report) {
                if (report.totalPlans == 0) {
                  return SizedBox(
                    height: MediaQuery.of(context).size.height * 0.6,
                    child: Center(
                      child: EmptyHistoryMessage(
                        is_history_screen: false,
                      ),
                    ),
                  );
                } else {
                  return InvestmentStatusScreenBody(
                    currentTheme: currentTheme,
                    tabController: _tabController,
                    report: report,
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
                    is_history_screen: false,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class InvestmentStatusScreenBody extends StatelessWidget {
  const InvestmentStatusScreenBody({
    super.key,
    required this.currentTheme,
    required TabController tabController,
    required this.report,
  }) : _tabController = tabController;

  final SettingsProviderState currentTheme;
  final TabController _tabController;
  final InvestmentRentabilityResumeEntity report;

  @override
  Widget build(BuildContext context) {
    DateFormat dateFormat = DateFormat.MMMM('es');
    return Center(
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.9,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Row(children: [
              SizedBox(
                child: Text(
                  ' Mis inversiones 💸 ',
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                    color: Color(Theme.of(context).colorScheme.secondary.value),
                  ),
                ),
              ),
              // SizedBox(
              //   width: MediaQuery.of(context).size.width * 0.58,
              // ),
              const Spacer(),
              GestureDetector(
                onTap: () {
                  // modalsPlan(context);
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
            ]),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    // Navigator.pushNamed(context, '/process_investment');
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.45,
                    height: 40,
                    decoration: BoxDecoration(
                      color: currentTheme.isDarkMode
                          ? const Color(primaryLight)
                          : const Color(primaryDark),
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
                              ? const Color(primaryDark)
                              : const Color(whiteText),
                        ),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/investment_history');
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
                        bottomRight: Radius.circular(20),
                        bottomLeft: Radius.circular(20),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        "Mi historial",
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
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            LineReportHomeWidget(
              totalAmount: report.totalAmount,
              revenueAmount: report.totalRentabilityAmount,
              planCount: report.totalPlans,
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment
                  .start, // Alinear widgets en el centro horizontalmente
              children: [
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
                        ? const Color(primaryDark)
                        : const Color(primaryLight),
                  ),
                  // Si desea agregar un icono dentro del círculo
                ),
                const SizedBox(
                    width: 5), // Separación entre el círculo y el texto
                Text(
                  'Dinero invertido',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: currentTheme.isDarkMode
                        ? const Color(whiteText)
                        : const Color(blackText),
                  ),
                ),

                const Spacer(),

                Container(
                  width: 15,
                  height: 15,
                  decoration: BoxDecoration(
                    border:
                        Border.all(width: 1, color: const Color(primaryDark)),
                    shape: BoxShape.circle,
                    color: currentTheme.isDarkMode
                        ? const Color(primaryLight)
                        : const Color(secondary),
                  ),
                  // Si desea agregar un icono dentro del círculo
                ),
                // Separación entre el círculo y el texto
                const SizedBox(width: 5),
                Text(
                  'Intereses generados',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
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
              'Distribución de mi patrimonio',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 16,
                color: currentTheme.isDarkMode
                    ? const Color(whiteText)
                    : const Color(blackText),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  TabBar(
                    isScrollable: true,
                    unselectedLabelColor: currentTheme.isDarkMode
                        ? const Color(whiteText)
                        : const Color(primaryDark),
                    labelColor: currentTheme.isDarkMode
                        ? const Color(primaryLight)
                        : const Color(primaryDark),
                    tabs: const [
                      Tab(
                        text: "Inversiones en curso",
                      ),
                      Tab(
                        text: "Inversiones finalizadas",
                      )
                    ],
                    controller: _tabController,
                    indicatorSize: TabBarIndicatorSize.label,
                    indicatorColor: currentTheme.isDarkMode
                        ? const Color(secondary)
                        : const Color(primaryLight),
                    indicatorWeight: 6,
                    indicatorPadding: const EdgeInsets.only(bottom: 12),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  ListView(
                    children: report.investmentsInCourse!
                        .map(
                          (investment) => TableCardInCourse(
                            textButton: investment.reinvestmentAvailable,
                            planName: investment.planName!,
                            termText:
                                'Plazo de ${investment.deadLineValue} meses: ${investment.rentabilityPercent}%',
                            amountInvested: 'S/ ${investment.amount}',
                            interestGenerated:
                                'S/ ${investment.rentabilityAmount}',
                            currentMoney:
                                'S/ ${investment.amount + investment.rentabilityAmount}',
                            moneyGrowth: '+${investment.rentabilityPercent}%',
                            startDate:
                                '${investment.startDateInvestment?.day} ${dateFormat.format(investment.startDateInvestment!)}',
                            endDate:
                                '${investment.endDateInvestment?.day} ${dateFormat.format(investment.endDateInvestment!)} ${investment.endDateInvestment?.year}',
                          ),
                        )
                        .toList(),
                  ),
                  ListView(
                    children: report.investmentsFinished!
                        .map(
                          (investment) => TableCardInvestFinished(
                            planName: investment.planName!,
                            endDate:
                                '${investment.endDateInvestment?.day} ${dateFormat.format(investment.endDateInvestment!)} ${investment.endDateInvestment?.year}',
                            amountInvested: 'S/ ${investment.amount}',
                            totalRevenue:
                                'S/ ${investment.rentabilityAmount + investment.amount}',
                            growText:
                                '${investment.deadLineValue} meses: ${investment.rentabilityPercent}%',
                          ),
                        )
                        .toList(),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class LineReportHomeWidget extends ConsumerStatefulWidget {
  final double totalAmount;
  final double revenueAmount;
  final int planCount;

  const LineReportHomeWidget({
    super.key,
    required this.totalAmount,
    required this.revenueAmount,
    required this.planCount,
  });

  @override
  _LineReportHomeWidgetState createState() => _LineReportHomeWidgetState();
}

class _LineReportHomeWidgetState extends ConsumerState<LineReportHomeWidget> {
  final List<String> _darkImages = [
    "assets/report_home/dark/step_1.png",
    "assets/report_home/dark/step_2.png",
    "assets/report_home/dark/step_3.png",
    "assets/report_home/dark/step_4.png",
  ];
  final List<String> _lightImages = [
    "assets/report_home/light/step_1.png",
    "assets/report_home/light/step_2.png",
    "assets/report_home/light/step_3.png",
    "assets/report_home/light/step_4.png",
  ];
  int _currentPageIndex = 0;
  Timer? _timer;
  List<String>? images;

  @override
  void initState() {
    super.initState();
    // final settings = ref.watch(settingsNotifierProvider);
    // images = ref.watch(settingsNotifierProvider).isDarkMode
    //     ? _darkImages
    //     : _lightImages;
    _timer = Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      setState(() {
        if (_currentPageIndex < 3) {
          _currentPageIndex++;
        } else {
          _currentPageIndex = 0;
        }
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final currentTheme = ref.watch(settingsNotifierProvider);
    final theme = ref.watch(settingsNotifierProvider);
    final images = theme.isDarkMode ? _darkImages : _lightImages;
    return SizedBox(
      width: MediaQuery.of(context).size.width * 1,
      child: Stack(
        alignment: Alignment.center,
        children: [
          ...images.map((image) {
            int index = images.indexOf(image);
            return AnimatedOpacity(
              duration: const Duration(milliseconds: 500),
              opacity: index == _currentPageIndex ? 1.0 : 0.0,
              child: Image.asset(
                image,
                // height: MediaQuery.of(context).size.height * 0.4,
                width: MediaQuery.of(context).size.width * 0.6,
                fit: BoxFit.cover,
                gaplessPlayback: true,
                alignment: Alignment.center,
              ),
            );
          }).toList(),
          Positioned(
            top: 30,
            left: 16,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      'S/${widget.totalAmount.toStringAsFixed(2)}',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: currentTheme.isDarkMode
                            ? const Color(primaryLight)
                            : const Color(primaryDark),
                      ),
                    ),
                    const SizedBox(
                      width: 22,
                    ),
                    Text(
                      'S/${widget.revenueAmount.toStringAsFixed(2)}',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: currentTheme.isDarkMode
                            ? const Color(primaryLight)
                            : const Color(primaryDark),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Text(
                      'Dinero total',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w400,
                        color: currentTheme.isDarkMode
                            ? const Color(whiteText)
                            : const Color(blackText),
                      ),
                    ),
                    const SizedBox(
                      width: 22,
                    ),
                    Text(
                      'Intereses generados',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w400,
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
                  '${widget.planCount} planes',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: currentTheme.isDarkMode
                        ? const Color(primaryLight)
                        : const Color(primaryDark),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Text(
                      'Mis inversiones en curso',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w400,
                        color: currentTheme.isDarkMode
                            ? const Color(whiteText)
                            : const Color(blackText),
                      ),
                    ),
                    const SizedBox(
                      width: 22,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class TableCardInCourse extends ConsumerWidget {
  final String planName;
  final String termText;
  final String amountInvested;
  final String interestGenerated;
  final String currentMoney;
  final String moneyGrowth;
  final String startDate;
  final String endDate;
  final bool? textButton;

  const TableCardInCourse({
    super.key,
    required this.planName,
    required this.termText,
    required this.amountInvested,
    required this.interestGenerated,
    required this.currentMoney,
    required this.moneyGrowth,
    required this.startDate,
    required this.endDate,
    this.textButton,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentTheme = ref.watch(settingsNotifierProvider);
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      constraints: const BoxConstraints(minWidth: 200, maxWidth: 200),
      width: MediaQuery.of(context).size.width * 0.8,
      height: 200,
      decoration: BoxDecoration(
        color: currentTheme.isDarkMode
            ? Colors.transparent
            : const Color(whiteText),
        border: Border.all(
          color: currentTheme.isDarkMode
              ? const Color(primaryLight)
              : const Color(primaryDark),
          width: 2,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  planName,
                  style: TextStyle(
                    color: currentTheme.isDarkMode
                        ? const Color(primaryLight)
                        : const Color(primaryDark),
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const Spacer(),
                Image.asset(
                  alignment: Alignment.center,
                  'assets/images/circle_green.png',
                  height: 15,
                ),
                const SizedBox(
                  width: 5,
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: Text(
                    'En curso',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w400,
                      color: currentTheme.isDarkMode
                          ? const Color(whiteText)
                          : const Color(blackText),
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              children: [
                Text(
                  termText,
                  style: const TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w400,
                    color: Color(grayText2),
                  ),
                ),
                const Spacer(),
                if (textButton == true)
                  Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: SizedBox(
                      width: 82,
                      height: 30,
                      child: TextButton(
                        onPressed: () {
                          Navigator.pushNamed(
                            context,
                            '/reinvest',
                            arguments: {
                              'planName': planName,
                              'amountInvested': amountInvested,
                            },
                          );
                        },
                        child: const Text(
                          'Reinvertir',
                        ),
                      ),
                    ),
                  )
              ],
            ),
            const SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Column(children: [
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: currentTheme.isDarkMode
                                    ? const Color(primaryDark)
                                    : const Color(primaryLight),
                                border: Border.all(
                                  color: currentTheme.isDarkMode
                                      ? const Color(whiteText)
                                      : const Color(blackText),
                                )),
                            height: 30,
                            width: 5,
                          ),
                        ]),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Text(
                                'Dinero invertido',
                                style: TextStyle(
                                  color: currentTheme.isDarkMode
                                      ? const Color(whiteText)
                                      : const Color(blackText),
                                  fontSize: 7,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                amountInvested,
                                style: TextStyle(
                                  color: currentTheme.isDarkMode
                                      ? const Color(primaryLight)
                                      : const Color(primaryDark),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
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
                    Row(
                      children: [
                        Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: currentTheme.isDarkMode
                                      ? const Color(primaryLight)
                                      : const Color(secondary),
                                  border: Border.all(
                                    color: currentTheme.isDarkMode
                                        ? const Color(whiteText)
                                        : const Color(blackText),
                                  )),
                              height: 30,
                              width: 5,
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              const Text(
                                'Intereses generados',
                                style: TextStyle(
                                  fontSize: 7,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                interestGenerated,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: currentTheme.isDarkMode
                                      ? const Color(primaryLight)
                                      : const Color(primaryDark),
                                  fontWeight: FontWeight.w600,
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 10, top: 10),
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.47,
                    height: 100,
                    decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.6),
                            spreadRadius: 0,
                            blurRadius: 2,
                            offset: const Offset(
                                0, 3), // changes position of shadow
                          ),
                        ],
                        color: currentTheme.isDarkMode
                            ? const Color(primaryDark)
                            : const Color(primaryLightAlternative),
                        borderRadius: BorderRadius.circular(10)),
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Dinero actual',
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w500,
                              color: currentTheme.isDarkMode
                                  ? const Color(whiteText)
                                  : const Color(blackText),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Text(
                                currentMoney,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: currentTheme.isDarkMode
                                      ? const Color(primaryLight)
                                      : const Color(blackText),
                                ),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.03,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Image.asset(
                                alignment: Alignment.center,
                                'assets/images/arrow.png',
                                //  width: 15,
                                height: 30,
                              ),
                              Text(
                                moneyGrowth,
                                style: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: Color(colorgreen)),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                'Inicio',
                                style: TextStyle(
                                  fontSize: 7,
                                  fontWeight: FontWeight.w600,
                                  color: currentTheme.isDarkMode
                                      ? const Color(whiteText)
                                      : const Color(blackText),
                                ),
                              ),
                              Text(
                                startDate,
                                style: TextStyle(
                                  fontSize: 7,
                                  fontWeight: FontWeight.w600,
                                  color: currentTheme.isDarkMode
                                      ? const Color(whiteText)
                                      : const Color(blackText),
                                ),
                              ),
                              const Spacer(),
                              Text(
                                'Finaliza',
                                style: TextStyle(
                                  fontSize: 7,
                                  fontWeight: FontWeight.w600,
                                  color: currentTheme.isDarkMode
                                      ? const Color(whiteText)
                                      : const Color(blackText),
                                ),
                              ),
                              Text(
                                endDate,
                                style: TextStyle(
                                  fontSize: 7,
                                  fontWeight: FontWeight.w600,
                                  color: currentTheme.isDarkMode
                                      ? const Color(whiteText)
                                      : const Color(blackText),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class TableCardInvestFinished extends ConsumerWidget {
  String planName;
  String endDate;
  String amountInvested;
  String totalRevenue;
  String growText;

  TableCardInvestFinished({
    Key? key,
    required this.planName,
    required this.endDate,
    required this.amountInvested,
    required this.totalRevenue,
    required this.growText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentTheme = ref.watch(settingsNotifierProvider);
    return Container(
      width: MediaQuery.of(context).size.width * 0.87,
      margin: const EdgeInsets.only(bottom: 10),
      height: 200,
      decoration: BoxDecoration(
        color: currentTheme.isDarkMode
            ? Colors.transparent
            : const Color(whiteText),
        border: Border.all(
          color: currentTheme.isDarkMode
              ? const Color(primaryLight)
              : const Color(primaryDark),
          width: 2,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            // mainAxisAlignment: MainAxisAlignment.start,
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text(
                  planName,
                  style: TextStyle(
                    color: currentTheme.isDarkMode
                        ? const Color(primaryLight)
                        : const Color(primaryDark),
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Spacer(),
              Image.asset(
                alignment: Alignment.center,
                'assets/images/circle_purple.png',
                height: 15,
              ),
              const SizedBox(
                width: 5,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 10),
                child: Text(
                  'Finalizado',
                  style: TextStyle(
                    fontSize: 11,
                    color: currentTheme.isDarkMode
                        ? const Color(whiteText)
                        : const Color(blackText),
                  ),
                ),
              )
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15),
            child: Text(
              'Finalizó: $endDate',
              style: TextStyle(
                  fontSize: 11,
                  color: currentTheme.isDarkMode
                      ? const Color(whiteText)
                      : const Color(blackText),
                  fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 14),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: const Color(primaryLight),
                                  border: Border.all(
                                    color: const Color(primaryLight),
                                  )),
                              height: 60,
                              width: 5,
                            ),
                          ],
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Column(
                          children: [
                            Text(
                              'Comenzaste con',
                              style: TextStyle(
                                color: currentTheme.isDarkMode
                                    ? const Color(whiteText)
                                    : const Color(blackText),
                                fontSize: 10,
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              '${amountInvested}',
                              style: TextStyle(
                                color: currentTheme.isDarkMode
                                    ? const Color(whiteText)
                                    : const Color(primaryDark),
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.1,
                        ),
                        Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: const Color(gradient_secondary_option),
                                border: Border.all(
                                  color: const Color(gradient_secondary_option),
                                ),
                              ),
                              height: 60,
                              width: 5,
                            ),
                          ],
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Column(
                          children: [
                            Text(
                              'Dinero+ intereses',
                              style: TextStyle(
                                color: currentTheme.isDarkMode
                                    ? const Color(primaryLight)
                                    : const Color(primaryDark),
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              '${totalRevenue}',
                              style: TextStyle(
                                color: currentTheme.isDarkMode
                                    ? const Color(primaryLight)
                                    : const Color(primaryDark),
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            alignment: Alignment.center,
            child: Text(
              textAlign: TextAlign.center,
              'Rentabilidad generada en $growText',
              style: TextStyle(
                color: Color(grayText2),
                fontSize: 10,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// void modalsPlan(BuildContext ctx) {
//   showDialog(
//     context: ctx,
//     builder: (BuildContext context) => AlertDialog(
//       backgroundColor: Colors.transparent,
//       content: BackdropFilter(
//         filter: ImageFilter.blur(
//             sigmaX: 2,
//             sigmaY: 2), // Aquí se establece la cantidad de borrosidad
//         child: Container(
//           width: MediaQuery.of(context).size.width * 0.96,
//           height: 290,
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(30),
//             color: Color(primaryLight),
//           ),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Image.asset(
//                 'assets/images/billsdollars.png',
//                 width: 130,
//                 height: 130,
//               ),
//               const SizedBox(
//                 width: 260,
//                 child: Text(
//                   '¿Quieres comenzar a construir tu patrimonio? ',
//                   textAlign: TextAlign.justify,
//                   style: TextStyle(
//                     fontSize: 21,
//                     fontWeight: FontWeight.bold,
//                     color: Color(
//                       primaryDark,
//                     ),
//                   ),
//                 ),
//               ),
//               const SizedBox(
//                 height: 30,
//               ),
//               SizedBox(
//                 width: 150,
//                 height: 45,
//                 child: TextButton(
//                   onPressed: () {
//                     Navigator.pushNamed(context, '/plan_list');
//                   },
//                   child: const Text(
//                     'Ver planes',
//                     style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//                   ),
//                 ),
//               )
//             ],
//           ),
//         ),
//       ),
//     ),
//   );
// }
