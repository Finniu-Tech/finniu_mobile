import 'dart:async';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:finniu/constants/colors.dart';
import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:finniu/presentation/providers/timer_counterdown_provider.dart';
import 'package:finniu/presentation/screens/activate_account_v2.dart/helpers/add_token.dart';
import 'package:finniu/presentation/screens/catalog/widgets/text_poppins.dart';
import 'package:flutter/material.dart';
import 'package:flutter_verification_code/flutter_verification_code.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:loader_overlay/loader_overlay.dart';

class VerificationCodeV2 extends HookConsumerWidget {
  const VerificationCodeV2({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeProvider = ref.watch(settingsNotifierProvider);
    // final userProfile = ref.watch(userProfileNotifierProvider);

    void onComplete(String code) async {
      context.loaderOverlay.show();
      addToken(context, ref, code);
    }

    return Center(
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.transparent,
          ),
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: VerificationCode(
          fullBorder: true,
          textStyle: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            color: themeProvider.isDarkMode
                ? Colors.white
                : const Color(primaryDark),
          ),
          keyboardType: TextInputType.number,
          underlineColor: const Color(
            0xff9381FF,
          ),
          underlineUnfocusedColor: Color(
            themeProvider.isDarkMode ? primaryLight : primaryDark,
          ),
          length: 4,
          itemSize: 50,
          cursorColor: Colors.blue,
          onCompleted: (code) => onComplete(code),
          onEditing: (bool value) {},
        ),
      ),
    );
  }
}

class CircularCountdownV2 extends ConsumerWidget {
  const CircularCountdownV2({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentTheme = ref.watch(settingsNotifierProvider);
    final duration = ref.watch(timerCounterDownProvider);
    const width = 92.0;
    const height = 91.0;
    const int iconDark = 0xffFFFFFF;
    const int iconLight = 0xff0D3A5C;
    const int ringColor = 0xff9381FF;
    return SizedBox(
      width: width,
      height: height,
      child: Stack(
        alignment: FractionalOffset.center,
        children: [
          CircularCountDownTimer(
            width: 92,
            height: 92,
            duration: duration,
            // ringColor: Colors.grey[300]!,
            fillColor: currentTheme.isDarkMode
                ? const Color(primaryLight)
                : const Color(primaryDark),
            ringColor: const Color(ringColor),
            isReverse: true,

            // isReverseAnimation: true,
            // backgroundColor: const Color(cardBackgroundColorLight),
            backgroundColor: Colors.transparent,
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
                  Icons.timer_outlined,
                  size: 26.0,
                  color: currentTheme.isDarkMode
                      ? const Color(iconDark)
                      : const Color(iconLight),
                ),
                NumberAlarmV2(duration: duration, currentTheme: currentTheme),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class NumberAlarmV2 extends StatefulWidget {
  const NumberAlarmV2({
    super.key,
    required this.duration,
    required this.currentTheme,
  });

  final int duration;
  final SettingsProviderState currentTheme;

  @override
  State<NumberAlarmV2> createState() => _NumberAlarmV2State();
}

class _NumberAlarmV2State extends State<NumberAlarmV2> {
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
    return TextPoppins(
      text: "$_remainingDuration segundos",
      fontSize: 10.0,
    );
  }
}
