import 'package:finniu/constants/colors/home_v4_colors.dart';
import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:finniu/widgets/switch.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class InvestContainer extends ConsumerWidget {
  const InvestContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(settingsNotifierProvider).isDarkMode;
    return Container(
      padding: const EdgeInsets.all(20),
      height: 380,
      decoration: BoxDecoration(
        color: isDarkMode
            ? const Color(HomeV4Colors.investContainerDark)
            : const Color(HomeV4Colors.investContainerLight),
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(25),
          bottomRight: Radius.circular(25),
        ),
      ),
      child: const Column(
        children: [
          SwitchMoney(
            switchHeight: 30,
            switchWidth: 67,
          ),
          SizedBox(
            height: 15,
          ),
          SizedBox(
            height: 200,
            child: Row(
              children: [
                Expanded(
                  child: ActiveInvestmentContainer(),
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Column(
                    children: [
                      Expanded(
                        child: InvestCapital(),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Expanded(
                        child: Interest(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 15,
          ),
          SizedBox(
            height: 70,
            child: Row(
              children: [
                Expanded(
                  child: InterestButton(),
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: PaymentsButton(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class PaymentsButton extends ConsumerWidget {
  const PaymentsButton({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(settingsNotifierProvider).isDarkMode;
    return Container(
      decoration: BoxDecoration(
        color: isDarkMode
            ? const Color(HomeV4Colors.paymentsButtonDark)
            : const Color(HomeV4Colors.paymentsButtonLight),
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
}

class InterestButton extends ConsumerWidget {
  const InterestButton({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(settingsNotifierProvider).isDarkMode;
    return Container(
      decoration: BoxDecoration(
        color: isDarkMode
            ? const Color(HomeV4Colors.interestButtonDark)
            : const Color(HomeV4Colors.interestButtonLight),
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
}

class Interest extends ConsumerWidget {
  const Interest({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(settingsNotifierProvider).isDarkMode;
    return Container(
      decoration: BoxDecoration(
        color: isDarkMode
            ? const Color(HomeV4Colors.interestContainerDark)
            : const Color(HomeV4Colors.interestContainerLight),
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
}

class InvestCapital extends ConsumerWidget {
  const InvestCapital({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(settingsNotifierProvider).isDarkMode;
    return Container(
      decoration: BoxDecoration(
        color: isDarkMode
            ? const Color(HomeV4Colors.capitalContainerDark)
            : const Color(HomeV4Colors.capitalContainerLight),
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
}

class ActiveInvestmentContainer extends ConsumerWidget {
  const ActiveInvestmentContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(settingsNotifierProvider).isDarkMode;
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: isDarkMode
              ? HomeV4Colors.gradientDark
              : HomeV4Colors.gradientDark,
          stops: const [0.2, 0.7],
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
}
