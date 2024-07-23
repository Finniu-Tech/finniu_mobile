import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:finniu/presentation/providers/v2_simulator_slider_provider.dart';
import 'package:finniu/presentation/screens/simulator_v2/widgets/custom_slider_thumb.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'dart:ui' as ui;
import 'package:flutter/services.dart';

class SliderMonthSelect extends ConsumerStatefulWidget {
  const SliderMonthSelect({super.key});

  @override
  ConsumerState<SliderMonthSelect> createState() => _SliderMonthSelectState();
}

class _SliderMonthSelectState extends ConsumerState<SliderMonthSelect> {
  ui.Image? _thumbImage;

  @override
  void initState() {
    super.initState();
    _loadImage();
  }

  Future<void> _loadImage() async {
    final ByteData data = await rootBundle.load('assets/home/money_wings.png');
    final Uint8List list = data.buffer.asUint8List();
    final ui.Image image = await decodeImageFromList(list);

    setState(() {
      _thumbImage = image;
    });
  }

  @override
  Widget build(BuildContext context) {
    V2SimulatorSlider sliderValue = ref.watch(sliderValueProvider);
    final isDarkMode = ref.watch(settingsNotifierProvider).isDarkMode;
    const int sliderDark = 0xffA2E6FA;
    const int sliderLight = 0xff1A3A5A;
    const int monthDark = 0xffFFFFFF;
    const int monthLight = 0xff000000;
    const int monthSelectedDark = 0xffA2E6FA;
    const int monthSelectedLight = 0xff0D3A5C;

    Color getColorForValue(V2SimulatorSlider value) {
      if (value == sliderValue) {
        return Color(isDarkMode ? monthSelectedDark : monthSelectedLight);
      } else {
        return Color(isDarkMode ? monthDark : monthLight);
      }
    }

    return Column(
      children: [
        SliderTheme(
          data: SliderTheme.of(context).copyWith(
            trackHeight: 6.0,
            activeTrackColor:
                isDarkMode ? const Color(sliderDark) : const Color(sliderLight),
            inactiveTrackColor:
                isDarkMode ? const Color(sliderDark) : const Color(sliderLight),
            thumbColor:
                isDarkMode ? const Color(sliderLight) : const Color(sliderDark),
            overlayColor: isDarkMode
                ? const Color(sliderDark).withAlpha(32)
                : const Color(sliderLight).withAlpha(32),
            thumbShape: _thumbImage == null
                ? const RoundSliderThumbShape(enabledThumbRadius: 14.0)
                : EmojiSliderThumbShape(
                    "💸",
                    backgroundColor:
                        Color(isDarkMode ? sliderLight : sliderDark),
                  ),
          ),
          child: Slider(
            value: sliderValue.value.toDouble(),
            min: 6,
            max: 36,
            divisions: 3,
            onChanged: (double value) {
              V2SimulatorSlider newValue;
              if (value <= 9) {
                newValue = V2SimulatorSlider.six;
              } else if (value <= 18) {
                newValue = V2SimulatorSlider.twelve;
              } else if (value <= 30) {
                newValue = V2SimulatorSlider.twentyFour;
              } else {
                newValue = V2SimulatorSlider.thirtySix;
              }
              if (newValue != sliderValue) {
                ref.read(sliderValueProvider.notifier).state = newValue;
              }
            },
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "6 meses",
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontFamily: "Poppins",
                fontSize: 12,
                color: getColorForValue(V2SimulatorSlider.six),
                fontWeight: FontWeight.w400,
              ),
            ),
            Text(
              "12 meses",
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontFamily: "Poppins",
                fontSize: 12,
                color: getColorForValue(V2SimulatorSlider.twelve),
                fontWeight: FontWeight.w400,
              ),
            ),
            Text(
              "24 meses",
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontFamily: "Poppins",
                fontSize: 12,
                color: getColorForValue(V2SimulatorSlider.twentyFour),
                fontWeight: FontWeight.w400,
              ),
            ),
            Text(
              "36 meses",
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontFamily: "Poppins",
                fontSize: 12,
                color: getColorForValue(V2SimulatorSlider.thirtySix),
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
