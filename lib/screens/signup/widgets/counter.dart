import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:finniu/constants/colors.dart';
import 'package:finniu/providers/settings_provider.dart';
import 'package:finniu/providers/timer_counterdown_provider.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CircularCountdown extends ConsumerWidget {
  const CircularCountdown({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentTheme = ref.watch(settingsNotifierProvider);
    return SizedBox(
      width: 70.0,
      height: 70.0,
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          CircularCountDownTimer(
            width: MediaQuery.of(context).size.width / 2,
            height: MediaQuery.of(context).size.height / 2,
            duration: ref.watch(timerCounterDownProvider),
            // ringColor: Colors.grey[300]!,
            fillColor: currentTheme.isDarkMode
                ? const Color(primaryLight)
                : const Color(primaryDark),
            ringColor: Color(0xff9381FF),
            isReverse: true,
            // isReverseAnimation: true,
            // backgroundColor: const Color(cardBackgroundColorLight),
            backgroundColor: currentTheme.isDarkMode
                ? const Color(primaryDark)
                : const Color(cardBackgroundColorLight),
            strokeWidth: 6.0,
            textStyle: TextStyle(
              fontSize: 25.0,
              // color: Color(primaryDark),
              color: currentTheme.isDarkMode
                  ? const Color(whiteText)
                  : const Color(primaryDark),
              fontWeight: FontWeight.bold,
            ),
            textFormat: CountdownTextFormat.S,
            onComplete: () {
              debugPrint('Countdown Ended');
            },
          ),
          Padding(
            padding: const EdgeInsets.all(9.0),
            child: Icon(
              Icons.alarm,
              size: 12.0,
              color: currentTheme.isDarkMode
                  ? const Color(primaryLight)
                  : const Color(primaryDark),
            ),
          ),
        ],
      ),
    );
  }
}
