import 'package:hooks_riverpod/hooks_riverpod.dart';

class TimerCounterDownProvider extends StateNotifier<int> {
  TimerCounterDownProvider(super.state);
  static const int _initialTime = 60;

  void startTimer() {
    state = _initialTime;
    Future<void>.delayed(const Duration(seconds: 1), () {
      if (state > 0) {
        state--;
        startTimer();
      }
    });
  }

  get isTimeOut => state == 0;
  get isTimeNotOut => state > 0;

  void resetTimer() {
    state = 0;
  }
}

final timerCounterDownProvider =
    StateNotifierProvider<TimerCounterDownProvider, int>(
        (ref) => TimerCounterDownProvider(0));
