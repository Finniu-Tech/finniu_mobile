import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:finniu/presentation/providers/v2_simulator_slider_provider.dart';
import 'package:finniu/presentation/screens/catalog/widgets/text_poppins.dart';
import 'package:finniu/presentation/screens/home_v2/widgets/navigation_bar.dart';
import 'package:finniu/presentation/screens/simulator_v2/widgets/column_how_invest.dart';
import 'package:finniu/presentation/screens/simulator_v2/widgets/simulator_appbar.dart';
import 'package:finniu/presentation/screens/simulator_v2/widgets/title_simulator.dart';
import 'package:finniu/presentation/screens/simulator_v2/widgets/type_investment.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class V2SimulatorScreen extends HookConsumerWidget {
  const V2SimulatorScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(settingsNotifierProvider).isDarkMode;
    const int columnColorDark = 0xff0E0E0E;
    const int columnColorLight = 0xffDCF6FF;

    return Scaffold(
      backgroundColor: isDarkMode
          ? const Color(columnColorDark)
          : const Color(columnColorLight),
      appBar: const AppBarSimulatorScreen(),
      bottomNavigationBar: const NavigationBarHome(),
      body: const SingleChildScrollView(
        child: Column(
          children: [
            TitleSimulator(),
            SimulatorBody(),
          ],
        ),
      ),
    );
  }
}

class SimulatorBody extends ConsumerWidget {
  const SimulatorBody({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(settingsNotifierProvider).isDarkMode;
    const int backgroundDark = 0xff191919;
    const int backgroundLight = 0xffFFFFFF;
    return Container(
      padding: const EdgeInsets.only(right: 20, left: 20, top: 30),
      width: MediaQuery.of(context).size.width,
      height: 563,
      decoration: BoxDecoration(
        color: isDarkMode
            ? const Color(backgroundDark)
            : const Color(backgroundLight),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      child: const Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TypeInvestment(),
          SizedBox(
            height: 20,
          ),
          ColumnHowInvest(),
          SizedBox(
            height: 20,
          ),
          ColumnForHowLong(),
        ],
      ),
    );
  }
}

class ColumnForHowLong extends ConsumerWidget {
  const ColumnForHowLong({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    int sliderValue = ref.watch(sliderValueProvider).value;
    const int monthDark = 0xffA2E6FA;
    const int monthLight = 0xff0D3A5C;
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const TextPoppins(
              text: "¿Por cuento tiempo?",
              fontSize: 17,
              isBold: true,
            ),
            TextPoppins(
              text: "$sliderValue meses",
              fontSize: 17,
              textDark: monthDark,
              textLight: monthLight,
              isBold: true,
            ),
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        const SliderMonthSelect(),
      ],
    );
  }
}

class SliderMonthSelect extends ConsumerStatefulWidget {
  const SliderMonthSelect({super.key});

  @override
  ConsumerState<SliderMonthSelect> createState() => _SliderMonthSelectState();
}

class _SliderMonthSelectState extends ConsumerState<SliderMonthSelect> {
  @override
  Widget build(BuildContext context) {
    V2SimulatorSlider sliderValue = ref.watch(sliderValueProvider);
    final isDarkMode = ref.watch(settingsNotifierProvider).isDarkMode;
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
        Slider(
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
