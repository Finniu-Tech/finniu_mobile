// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:finniu/constants/colors.dart';
import 'package:finniu/presentation/providers/money_provider.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:finniu/presentation/providers/settings_provider.dart';

class LineReportCalculatorWidget extends ConsumerStatefulWidget {
  final double initialAmount;
  final double finalAmount;
  final double revenueAmount;
  final int months;

  const LineReportCalculatorWidget({
    super.key,
    required this.initialAmount,
    required this.finalAmount,
    required this.revenueAmount,
    required this.months,
  });

  @override
  _LineReportCalculatorWidgetState createState() =>
      _LineReportCalculatorWidgetState();
}

class _LineReportCalculatorWidgetState
    extends ConsumerState<LineReportCalculatorWidget> {
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
    final theme = ref.watch(settingsNotifierProvider);
    final images = theme.isDarkMode ? _darkImages : _lightImages;
    final isSoles = ref.watch(isSolesStateProvider);
    final String moneySymbol = isSoles ? "S/" : "\$";
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
            children: [
              Container(
                width: 122,
                height: 56,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: const Color(primaryLight),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 1,
                      blurRadius: 7,
                      offset: const Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Si comienzas con',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 10,
                        color: Color(blackText),
                      ),
                    ),
                    Text(
                      '${moneySymbol} ${widget.initialAmount}',
                      textAlign: TextAlign.right,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(primaryDark),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                width: 122,
                height: 56,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: const Color(secondary),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 1,
                      blurRadius: 7,
                      offset: const Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'En ${widget.months} meses tendrías',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 10,
                        color: Color(blackText),
                      ),
                    ),
                    Text(
                      '$moneySymbol ${widget.finalAmount}',
                      textAlign: TextAlign.right,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(primaryDark),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Positioned(
          top: 30,
          right: 25,
          child: Column(
            children: [
              const Text('Intereses ganados'),
              Text(
                '$moneySymbol ${widget.revenueAmount}',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
