import 'dart:async';

import 'package:finniu/constants/colors.dart';
import 'package:finniu/constants/number_format.dart';
import 'package:finniu/presentation/providers/money_provider.dart';
import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:finniu/widgets/switch.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class LineReportHomeWidget extends ConsumerStatefulWidget {
  final double initialAmount;
  final double finalAmount;
  final double revenueAmount;
  final double totalPlans;
  final bool isSoles;

  const LineReportHomeWidget({
    super.key,
    required this.initialAmount,
    required this.finalAmount,
    required this.revenueAmount,
    required this.totalPlans,
    required this.isSoles,
  });

  @override
  _LineReportHomeWidgetState createState() => _LineReportHomeWidgetState();
}

class _LineReportHomeWidgetState extends ConsumerState<LineReportHomeWidget> {
  final List<String> _darkImages = [
    "assets/reports/night/step_1.png",
    "assets/reports/night/step_3.png",
    "assets/reports/night/step_3.png",
    "assets/reports/night/step_4.png",
    "assets/reports/night/step_5.png",
    "assets/reports/night/step_6.png",
  ];
  final List<String> _lightImages = [
    "assets/reports/light/step_1.png",
    "assets/reports/light/step_2.png",
    "assets/reports/light/step_3.png",
    "assets/reports/light/step_4.png",
    "assets/reports/light/step_5.png",
    "assets/reports/light/step_6.png",
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
        if (_currentPageIndex < 5) {
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
    final isSoles = ref.watch(isSolesStateProvider);
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 15),
          child: Container(
            alignment: Alignment.centerLeft,
            child: Row(
              children: [
                Text(
                  'Resumen de mis inversiones',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: currentTheme.isDarkMode ? const Color(whiteText) : const Color(primaryDark),
                  ),
                ),
                const Spacer(),
                const SwitchMoney(
                  switchHeight: 34,
                  switchWidth: 67,
                ),
              ],
            ),
          ),
        ),
        Stack(
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
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    // width: 130,
                    height: 56,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              isSoles
                                  ? formatterSoles.format(widget.initialAmount)
                                  : formatterUSD.format(widget.initialAmount),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: currentTheme.isDarkMode ? const Color(primaryLight) : const Color(primaryDark),
                              ),
                            ),
                            const SizedBox(
                              width: 30,
                            ),
                            Text(
                              isSoles
                                  ? formatterSoles.format(widget.revenueAmount)
                                  : formatterUSD.format(widget.revenueAmount),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: currentTheme.isDarkMode ? const Color(primaryLight) : const Color(primaryDark),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              'Dinero total',
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                fontSize: 10,
                                color: currentTheme.isDarkMode ? const Color(whiteText) : const Color(blackText),
                              ),
                            ),
                            const SizedBox(
                              width: 40,
                            ),
                            Text(
                              'Intereses generados',
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                fontSize: 10,
                                color: currentTheme.isDarkMode ? const Color(whiteText) : const Color(blackText),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: 125,
                    height: 60,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${widget.totalPlans.toInt()} ${widget.totalPlans.toInt() == 1 ? "plan" : "planes"}',
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: currentTheme.isDarkMode ? const Color(primaryLight) : const Color(primaryDark),
                          ),
                        ),
                        Text(
                          'Mis inversiones en Curso',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 10,
                            color: currentTheme.isDarkMode ? const Color(whiteText) : const Color(blackText),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(right: 30, top: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 1,
                    color: currentTheme.isDarkMode ? const Color(primaryDark) : const Color(primaryDark),
                  ),
                  shape: BoxShape.circle,
                  color: currentTheme.isDarkMode ? const Color(primaryDark) : const Color(primaryLight),
                ),
                // Si desea agregar un icono dentro del círculo
              ),
              const SizedBox(width: 5), // Separación entre el círculo y el texto
              Text(
                'Dinero invertido',
                style: TextStyle(
                  fontSize: 10,
                  color: currentTheme.isDarkMode ? const Color(whiteText) : const Color(blackText),
                ),
              ),
              const SizedBox(
                width: 16,
              ),
              Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(
                  border: Border.all(width: 1, color: const Color(primaryDark)),
                  shape: BoxShape.circle,
                  color: currentTheme.isDarkMode ? const Color(primaryLight) : const Color(secondary),
                ),
                // Si desea agregar un icono dentro del círculo
              ),
              // Separación entre el círculo y el texto
              const SizedBox(width: 5),
              Text(
                'Intereses generados',
                style: TextStyle(
                  fontSize: 10,
                  color: currentTheme.isDarkMode ? const Color(whiteText) : const Color(blackText),
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
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.6),
                    spreadRadius: 0,
                    blurRadius: 0,
                    offset: const Offset(0, 3), // changes position of shadow
                  ),
                ],
                color: const Color(secondary),
              ),
              width: 98,
              height: 65,
              child: GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/plan_list');
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.6),
                        spreadRadius: 0,
                        blurRadius: 0,
                        offset: const Offset(0, 3),
                      ),
                    ],
                    color: const Color(secondary),
                  ),
                  width: 98,
                  height: 65,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/icons/square.png',
                        width: 15,
                        height: 15,
                      ),
                      const SizedBox(height: 5),
                      const Text(
                        'Planes',
                        style: TextStyle(
                          fontSize: 10,
                          color: Color(blackText),
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(
              width: 20,
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.6),
                    spreadRadius: 0,
                    blurRadius: 0,
                    offset: const Offset(0, 3), // changes position of shadow
                  ),
                ],
                color: const Color(secondary),
              ),
              width: 98,
              height: 65,
              child: GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/process_investment');
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.6),
                        spreadRadius: 0,
                        blurRadius: 0,
                        offset: const Offset(0, 3),
                      ),
                    ],
                    color: const Color(secondary),
                  ),
                  width: 98,
                  height: 65,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/icons/dollar.png',
                        width: 15,
                        height: 15,
                      ),
                      const SizedBox(height: 5),
                      const Text(
                        'Mis inversiones',
                        style: TextStyle(
                          fontSize: 10,
                          color: Color(blackText),
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(
              width: 20,
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.6),
                    spreadRadius: 0,
                    blurRadius: 0,
                    offset: const Offset(0, 3), // changes position of shadow
                  ),
                ],
                color: const Color(secondary),
              ),
              width: 98,
              height: 65,
              child: GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/transfers');
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.6),
                        spreadRadius: 0,
                        blurRadius: 0,
                        offset: const Offset(0, 3),
                      ),
                    ],
                    color: const Color(secondary),
                  ),
                  width: 98,
                  height: 65,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/icons/transferences.png',
                        width: 15,
                        height: 15,
                      ),
                      const SizedBox(height: 5),
                      const Text(
                        'Transferencias',
                        style: TextStyle(
                          fontSize: 10,
                          color: Color(blackText),
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
