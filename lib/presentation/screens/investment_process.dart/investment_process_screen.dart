import 'dart:async';

import 'package:finniu/constants/colors.dart';
import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:finniu/widgets/scaffold.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class InvestmentProcess extends ConsumerWidget {
  const InvestmentProcess({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentTheme = ref.watch(settingsNotifierProvider);
    return CustomScaffoldReturnLogo(
        body: SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(children: [
              SizedBox(
                child: Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Text(
                    'Mis inversiones',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                      color:
                          Color(Theme.of(context).colorScheme.secondary.value),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Image.asset(
                'assets/icons/dollar.png',
                width: 20,
                height: 20,
              ),
              const SizedBox(
                width: 80,
              ),
              const Spacer(),
              Image.asset(
                'assets/icons/calendar.png',
                width: 20,
                height: 20,
                color: currentTheme.isDarkMode
                    ? const Color(primaryLight)
                    : const Color(primaryDark),
              ),
            ]),
            const SizedBox(
              height: 30,
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 170,
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
                        color: currentTheme.isDarkMode
                            ? const Color(primaryDark)
                            : const Color(whiteText),
                      ),
                    ),
                  ),
                ),
                Container(
                  width: 170,
                  height: 40,
                  decoration: BoxDecoration(
                    color: currentTheme.isDarkMode
                        ? const Color(primaryDark)
                        : const Color(primaryLight),
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
                          Navigator.pushNamed(context, '/investment_history');
                        },
                        child: Text(
                          "Mi historial",
                          style: TextStyle(
                            color: currentTheme.isDarkMode
                                ? const Color(whiteText)
                                : const Color(primaryDark),
                          ),
                        )),
                  ),
                ),
              ],
            ),

            const LineReportHomeWidget(
              initialAmount: 550,
              finalAmount: 583,
              revenueAmount: 33,
            ),
            // const Flexible(
            //   flex: 10,
            //   fit: FlexFit.tight,
            //   child: CardTable(),
            // ),
            // SizedBox(
            //   height: 40,
            // ),
            Padding(
              padding: const EdgeInsets.only(right: 30, top: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment
                    .start, // Alinear widgets en el centro horizontalmente
                children: [
                  Container(
                    width: 15,
                    height: 15,
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 1,
                        color: currentTheme.isDarkMode
                            ? const Color(primaryDark)
                            : const Color(primaryDark),
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
                      fontSize: 10,
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
                      fontSize: 10,
                      color: currentTheme.isDarkMode
                          ? const Color(whiteText)
                          : const Color(blackText),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              'Distribucion de mi patrimonio',
              style: TextStyle(
                fontSize: 16,
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
                Container(
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: currentTheme.isDarkMode
                            ? const Color(secondary)
                            : const Color(primaryLight), // color del subrayado
                        width: 5.0, // ancho del subrayado
                      ),
                    ),
                  ),
                  child: Text(
                    'Inversiones en Curso',
                    style: TextStyle(
                      fontSize: 12,
                      color: currentTheme.isDarkMode
                          ? const Color(primaryLight)
                          : const Color(primaryDark),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 90,
                ),
                Spacer(),
                Padding(
                  padding: const EdgeInsets.only(right: 12),
                  child: Text(
                    'Inversiones finalizadas',
                    style: TextStyle(
                      fontSize: 12,
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

            const TableCard(),
            const SizedBox(
              height: 10,
            ),
            const TableCard()
          ],
        ),
      ),
    ));
  }
}

class LineReportHomeWidget extends ConsumerStatefulWidget {
  final double initialAmount;
  final double finalAmount;
  final double revenueAmount;

  const LineReportHomeWidget({
    super.key,
    required this.initialAmount,
    required this.finalAmount,
    required this.revenueAmount,
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
    return Stack(
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
              width: MediaQuery.of(context).size.width * 0.9,
              fit: BoxFit.cover,
              gaplessPlayback: true,
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
                    'S/7620',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: currentTheme.isDarkMode
                          ? const Color(primaryLight)
                          : const Color(primaryDark),
                    ),
                  ),
                  const SizedBox(
                    width: 22,
                  ),
                  Text(
                    'S/597.34',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: currentTheme.isDarkMode
                          ? const Color(primaryLight)
                          : const Color(primaryDark),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Text(
                    'Dinero total',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 10,
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
                '3 planes',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
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
    );
  }
}

class TableCard extends ConsumerWidget {
  const TableCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentTheme = ref.watch(settingsNotifierProvider);
    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
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
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Plan estable',
                style: TextStyle(
                  color: currentTheme.isDarkMode
                      ? const Color(primaryLight)
                      : const Color(primaryDark),
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.39,
              ),
              Image.asset(
                alignment: Alignment.center,
                'assets/images/circle_green.png',
                height: 15,
              ),
              const SizedBox(
                width: 5,
              ),
              Text(
                'En curso',
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
          const Padding(
            padding: EdgeInsets.only(left: 15),
            child: Text(
              'Plazo de 12 meses:14%',
              style: TextStyle(fontSize: 11, color: Color(grayText2)),
            ),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 14),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
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
                            height: 60,
                            width: 5,
                          ),
                        ]),
                        Column(
                          children: [
                            Text(
                              'Dinero invertido',
                              style: TextStyle(
                                color: currentTheme.isDarkMode
                                    ? const Color(whiteText)
                                    : const Color(blackText),
                                fontSize: 7,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              'S/1500',
                              style: TextStyle(
                                color: currentTheme.isDarkMode
                                    ? const Color(primaryLight)
                                    : const Color(primaryDark),
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
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
                              height: 60,
                              width: 5,
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            const Text(
                              'Intereses generados',
                              style: TextStyle(
                                fontSize: 7,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              'S/150.15',
                              style: TextStyle(
                                fontSize: 14,
                                color: currentTheme.isDarkMode
                                    ? const Color(primaryLight)
                                    : const Color(primaryDark),
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 10),
                child: Container(
                  width: 216,
                  height: 112,
                  decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 1,
                          blurRadius: 7,
                          offset:
                              const Offset(0, 3), // changes position of shadow
                        ),
                      ],
                      color: currentTheme.isDarkMode
                          ? const Color(primaryDark)
                          : const Color(primaryLightAlternative),
                      borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                    padding: const EdgeInsets.all(13.0),
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
                            fontWeight: FontWeight.bold,
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
                              'S/1650.15',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
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
                            const Text(
                              '+10.01%',
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: Color(colorgreen)),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              'Inicio',
                              style: TextStyle(
                                fontSize: 6,
                                color: currentTheme.isDarkMode
                                    ? const Color(whiteText)
                                    : const Color(blackText),
                              ),
                            ),
                            Text(
                              '29 Mayo',
                              style: TextStyle(
                                fontSize: 6,
                                fontWeight: FontWeight.bold,
                                color: currentTheme.isDarkMode
                                    ? const Color(whiteText)
                                    : const Color(blackText),
                              ),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.07,
                            ),
                            Text(
                              'Finaliza',
                              style: TextStyle(
                                fontSize: 6,
                                color: currentTheme.isDarkMode
                                    ? const Color(whiteText)
                                    : const Color(blackText),
                              ),
                            ),
                            Text(
                              '29 Mayo 2023',
                              style: TextStyle(
                                fontSize: 7,
                                fontWeight: FontWeight.bold,
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
    );
  }
}
