import 'package:finniu/presentation/providers/v2_simulator_slider_provider.dart';
import 'package:finniu/presentation/screens/catalog/widgets/text_poppins.dart';
import 'package:finniu/presentation/screens/simulator_v2/widgets/slider_month_select.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

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
              text: "¿Por cuánto tiempo?",
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
