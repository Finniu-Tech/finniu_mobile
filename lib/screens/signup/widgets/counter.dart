import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:finniu/constants/colors.dart';
import 'package:finniu/providers/timer_counterdown_provider.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CircularCountdown extends ConsumerWidget {
  const CircularCountdown({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      width: 70.0,
      height: 70.0,
      child: CircularCountDownTimer(
        width: MediaQuery.of(context).size.width / 2,
        height: MediaQuery.of(context).size.height / 2,
        duration: ref.watch(timerCounterDownProvider),
        ringColor: Colors.grey[300]!,
        fillColor: const Color(primaryDark),
        backgroundColor: const Color(cardBackgroundColorLight),
        strokeWidth: 6.0,
        textStyle: const TextStyle(
          fontSize: 25.0,
          color: Color(primaryDark),
          fontWeight: FontWeight.bold,
        ),
        textFormat: CountdownTextFormat.S,
        onComplete: () {
          debugPrint('Countdown Ended');
        },
      ),
    );
  }
}
