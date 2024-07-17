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
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextPoppins(
            text: "Elegiste lo siguiente",
            fontSize: 12,
            textDark: textDark,
            textLight: textLight,
            isBold: true,
          ),
          SelectedInstallments(
            installment: 6,
          ),
          SelectedPlots(
            plots: null,
          ),
          SelectedMonthlyFee(
            monthly: 1000,
          ),
        ],
      ),
    );
  }
}

class SelectedInstallments extends HookConsumerWidget {
  const SelectedInstallments({
    super.key,
    required this.installment,
  });
  final int? installment;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(settingsNotifierProvider).isDarkMode;

    bool isSelected = installment != null;
    int avatarDark = isSelected ? 0xff4579E3 : 0xff222222;
    int avatarLight = isSelected ? 0xffB0D5FF : 0xffEAEAEA;
    int textDark = isSelected ? 0xffFFFFFF : 0xff828282;
    int textLight = isSelected ? 0xff000000 : 0xff000000;

    return Row(
      children: [
        SizedBox(
          width: 32,
          height: 32,
          child: CircleAvatar(
            backgroundColor: Color(isDarkMode ? avatarDark : avatarLight),
            child: Image.asset(
              "assets/blue_gold/calendar/calendar_blank_${isSelected ? "selected" : "unselected"}_${isDarkMode ? "dark" : "light"}.png",
              width: 16,
              height: 16,
            ),
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextPoppins(
              text: "Cuotas",
              fontSize: 12,
              textDark: textDark,
              textLight: textLight,
            ),
            TextPoppins(
              text: "${installment ?? "-"} cuotas",
              fontSize: 16,
              isBold: true,
              textDark: textDark,
              textLight: textLight,
            ),
          ],
        ),
      ],
    );
  }
}

class SelectedMonthlyFee extends HookConsumerWidget {
  const SelectedMonthlyFee({
    super.key,
    required this.monthly,
  });
  final int? monthly;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(settingsNotifierProvider).isDarkMode;

    bool isSelected = monthly != null;
    int avatarDark = isSelected ? 0xff4579E3 : 0xff222222;
    int avatarLight = isSelected ? 0xffB0D5FF : 0xffEAEAEA;
    int textDark = isSelected ? 0xffFFFFFF : 0xff828282;
    int textLight = isSelected ? 0xff000000 : 0xff000000;

    return Row(
      children: [
        SizedBox(
          width: 32,
          height: 32,
          child: CircleAvatar(
            backgroundColor: Color(isDarkMode ? avatarDark : avatarLight),
            child: Image.asset(
              "assets/blue_gold/money/money_${isSelected ? "selected" : "unselected"}_${isDarkMode ? "dark" : "light"}.png",
              width: 16,
              height: 16,
            ),
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextPoppins(
              text: "Cuota mensual",
              fontSize: 12,
              textDark: textDark,
              textLight: textLight,
            ),
            AnimationNumber(
              beginNumber: 0,
              endNumber: monthly ?? 0,
              duration: 1,
              fontSize: 16,
              colorText: isDarkMode ? textDark : textLight,
            ),
          ],
        ),
      ],
    );
  }
}

class SelectedPlots extends HookConsumerWidget {
  const SelectedPlots({
    super.key,
    required this.plots,
  });
  final int? plots;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(settingsNotifierProvider).isDarkMode;

    bool isSelected = plots != null;
    int avatarDark = isSelected ? 0xff4579E3 : 0xff222222;
    int avatarLight = isSelected ? 0xffB0D5FF : 0xffEAEAEA;
    int textDark = isSelected ? 0xffFFFFFF : 0xff828282;
    int textLight = isSelected ? 0xff000000 : 0xff000000;

    return Row(
      children: [
        SizedBox(
          width: 32,
          height: 32,
          child: CircleAvatar(
            backgroundColor: Color(isDarkMode ? avatarDark : avatarLight),
            child: Image.asset(
              "assets/blue_gold/leaf/leaf_${isSelected ? "selected" : "unselected"}_${isDarkMode ? "dark" : "light"}.png",
              width: 16,
              height: 16,
            ),
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextPoppins(
              text: "Cantidad",
              fontSize: 12,
              textDark: textDark,
              textLight: textLight,
            ),
            TextPoppins(
              text: "${plots ?? "-"} parcelas",
              fontSize: 16,
              isBold: true,
              textDark: textDark,
              textLight: textLight,
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
