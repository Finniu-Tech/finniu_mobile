import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:finniu/constants/colors.dart';
import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:finniu/presentation/providers/timer_counterdown_provider.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CircularCountdown extends ConsumerWidget {
  const CircularCountdown({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentTheme = ref.watch(settingsNotifierProvider);
    final duration = ref.watch(timerCounterDownProvider);
    const width = 92.0;
    const height = 91.0;
    return SizedBox(
      width: width,
      height: height,
      child: Stack(
        alignment: FractionalOffset.center,
        children: [
          CircularCountDownTimer(
            width: MediaQuery.of(context).size.width / 2,
            height: MediaQuery.of(context).size.height / 2,
            duration: duration,
            // ringColor: Colors.grey[300]!,
            fillColor: currentTheme.isDarkMode
                ? const Color(primaryLight)
                : const Color(primaryDark),
            ringColor: const Color(0xff9381FF),
            isReverse: true,

            // isReverseAnimation: true,
            // backgroundColor: const Color(cardBackgroundColorLight),
            backgroundColor: currentTheme.isDarkMode
                ? const Color(primaryDark)
                : Colors.transparent,
            strokeWidth: 6.0,
            textStyle: const TextStyle(
              fontSize: 15.0,
              color: Colors
                  .transparent, // Color transparente para ocultar el número
              fontWeight: FontWeight.bold,
            ),
            onComplete: () {
              debugPrint('Countdown Ended');
              ref.read(timerCounterDownProvider.notifier).resetTimer();
            },
          ),
          Positioned(
            height: height / 2,
            child: Column(
              children: [
                Icon(
                  Icons.alarm,
                  size: 24.0,
                  color: currentTheme.isDarkMode
                      ? const Color(primaryLight)
                      : const Color(primaryDark),
                ),
                Text(
                  duration.toString(),
                  style: TextStyle(
                    fontSize: 15.0,
                    color: currentTheme.isDarkMode
                        ? const Color(whiteText)
                        : const Color(primaryDark),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
