import 'dart:async';
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
              color: Colors.transparent,
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
                NumberAlarm(duration: duration, currentTheme: currentTheme),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class NumberAlarm extends StatefulWidget {
  const NumberAlarm({
    super.key,
    required this.duration,
    required this.currentTheme,
  });

  final int duration;
  final SettingsProviderState currentTheme;

  @override
  State<NumberAlarm> createState() => _NumberAlarmState();
}

class _NumberAlarmState extends State<NumberAlarm> {
  late int _remainingDuration;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _remainingDuration = widget.duration;
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingDuration > 0) {
        setState(() {
          _remainingDuration--;
        });
      } else {
        _timer?.cancel();
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      _remainingDuration.toString(),
      style: TextStyle(
        fontSize: 15.0,
        color: widget.currentTheme.isDarkMode
            ? const Color(whiteText)
            : const Color(
                primaryDark,
              ),
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
