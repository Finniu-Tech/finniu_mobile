import 'package:finniu/constants/colors.dart';
import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:finniu/presentation/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import '../../../../domain/entities/calculate_investment.dart';

class CircularImage extends ConsumerWidget {
  final int months;
  const CircularImage({required this.months, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final themeProvider = ref.watch(settingsNotifierProvider);
    return Container(
      // margin: EdgeInsets.only(left: 63.0),
      child: CircularPercentIndicator(
        circularStrokeCap: CircularStrokeCap.round,
        radius: 65.0,
        lineWidth: 10.0,
        percent: 0.5,
        center: CircleAvatar(
          radius: 50,
          backgroundColor: themeProvider.isDarkMode
              ? Color(backgroundColorDark)
              : Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                alignment: Alignment.topCenter,
                child: SizedBox(
                  child: Image.asset(
                    'assets/result/money.png',
                    width: 55,
                    height: 60,
                  ),
                ),
              ),
              SizedBox(height: 8),
              Text(
                '$months%',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: themeProvider.isDarkMode
                        ? Color(primaryLight)
                        : Color(primaryDark)),
              )
            ],
          ),
        ),
        progressColor:
            Color(themeProvider.isDarkMode ? primaryLight : primaryDark),
        backgroundColor:
            Color(themeProvider.isDarkMode ? primaryDark : primaryLight),
        fillColor: themeProvider.isDarkMode
            ? Color(backgroundColorDark)
            : Colors.white,
      ),
    );
  }
}
