// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:finniu/presentation/providers/settings_provider.dart';

class LineReportCalculatorWidget extends ConsumerStatefulWidget {
  final double initialAmount;
  final double finalAmount;
  final double revenueAmount;

  const LineReportCalculatorWidget({
    super.key,
    required this.initialAmount,
    required this.finalAmount,
    required this.revenueAmount,
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
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.4,
      width: MediaQuery.of(context).size.width * 0.8,
      child: Stack(
        alignment: Alignment.center,
        children: images.map((image) {
          int index = images.indexOf(image);
          return AnimatedOpacity(
            duration: const Duration(milliseconds: 10),
            opacity: index == _currentPageIndex ? 1.0 : 0.0,
            child: Image.asset(
              image,
              height: MediaQuery.of(context).size.height * 0.4,
              width: MediaQuery.of(context).size.width * 0.8,
              fit: BoxFit.cover,
              gaplessPlayback: true,
            ),
          );
        }).toList(),
      ),
    );
  }
}
