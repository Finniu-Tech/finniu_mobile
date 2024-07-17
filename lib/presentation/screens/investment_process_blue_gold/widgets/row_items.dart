import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:finniu/presentation/screens/catalog/widgets/animated_number.dart';
import 'package:finniu/presentation/screens/catalog/widgets/text_poppins.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SelectedItems extends ConsumerWidget {
  const SelectedItems({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const int textDark = 0xffFFFFFF;
    const int textLight = 0xff0D3A5C;
    return const SizedBox(
      height: 230,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextPoppins(
            text: "Elegiste lo siguiente",
            fontSize: 12,
            textDark: textDark,
            textLight: textLight,
            isBold: true,
          ),
          SelectedInstallments()
        ],
      ),
    );
  }
}

class SelectedInstallments extends StatefulWidget {
  const SelectedInstallments({
    super.key,
  });

  @override
  State<SelectedInstallments> createState() => _SelectedInstallmentsState();
}

const int installment = 6;

class _SelectedInstallmentsState extends State<SelectedInstallments> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          backgroundColor: const Color(0xffB0D5FF),
          child: Image.asset(
            "assets/blue_gold/calendar/calendar_blank_selected_light.png",
            width: 16,
            height: 16,
          ),
        ),
        const Column(
          children: [
            TextPoppins(
              text: "Cuotas",
              fontSize: 12,
            ),
            TextPoppins(
              text: "$installment cuotas",
              fontSize: 12,
            ),
          ],
        ),
      ],
    );
  }
}

class AmountRow extends ConsumerWidget {
  const AmountRow({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const int amountInvestment = 52000;
    final isDarkMode = ref.watch(settingsNotifierProvider).isDarkMode;
    const int textAmountDark = 0xff0D3A5C;
    const int textAmountLight = 0xff0D3A5C;
    const int containerDark = 0xffA2E6FA;
    const int containerLight = 0xffE2F8FF;

    return SizedBox(
      height: 230,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: isDarkMode
                  ? const Color(containerDark)
                  : const Color(containerLight),
            ),
            width: 200,
            height: 70,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const TextPoppins(
                  text: "Monto",
                  fontSize: 12,
                  textDark: textAmountDark,
                  textLight: textAmountLight,
                  isBold: true,
                ),
                AnimationNumber(
                  beginNumber: 0,
                  endNumber: amountInvestment,
                  duration: 1,
                  fontSize: 20,
                  colorText: isDarkMode ? textAmountDark : textAmountLight,
                ),
              ],
            ),
          ),
          const Expanded(child: SizedBox()),
          Image.asset(
            "assets/blue_gold/growth_blue_gold.png",
            width: 132,
            height: 132,
            fit: BoxFit.fill,
          ),
        ],
      ),
    );
  }
}
