import 'package:hooks_riverpod/hooks_riverpod.dart';

enum V2SimulatorSlider {
  six(6),
  twelve(12),
  twentyFour(24),
  thirtySix(36);

  final int value;
  const V2SimulatorSlider(this.value);
  int getMonthValue() {
    return value;
  }
}

final sliderValueProvider =
    StateProvider<V2SimulatorSlider>((ref) => V2SimulatorSlider.six);

final amountValueProvider = StateProvider<int>((ref) => 0);
