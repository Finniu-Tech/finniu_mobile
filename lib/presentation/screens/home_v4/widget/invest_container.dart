import 'package:finniu/constants/colors/home_v4_colors.dart';
import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:finniu/presentation/screens/catalog/widgets/text_poppins.dart';
import 'package:finniu/widgets/switch.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:skeletonizer/skeletonizer.dart';

class InvestContainer extends ConsumerWidget {
  const InvestContainer({
    super.key,
    required this.isLoaded,
  });
  final bool isLoaded;
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
      child: Column(
        children: [
          const SwitchMoney(
            switchHeight: 30,
            switchWidth: 67,
          ),
          const SizedBox(
            height: 15,
          ),
          SizedBox(
            height: 200,
            child: Row(
              children: [
                Expanded(
                  child: ActiveInvestmentContainer(
                    isLoaded: isLoaded,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Column(
                    children: [
                      Expanded(
                        child: InvestCapital(
                          isLoaded: isLoaded,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Expanded(
                        child: Interest(isLoaded: isLoaded),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          const SizedBox(
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
    required this.isLoaded,
  });
  final bool isLoaded;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(settingsNotifierProvider).isDarkMode;
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: isDarkMode
            ? const Color(HomeV4Colors.interestContainerDark)
            : const Color(HomeV4Colors.interestContainerLight),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(
            height: 10,
          ),
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextPoppins(
                text: "Intereses generados",
                fontSize: 10,
              ),
              SizedBox(
                width: 10,
              ),
              Icon(
                Icons.remove_red_eye_outlined,
                size: 16,
              ),
            ],
          ),
          Skeletonizer(
            enabled: isLoaded,
            child: const TextPoppins(
              text: "+S/320.60",
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

class InvestCapital extends ConsumerWidget {
  const InvestCapital({
    super.key,
    required this.isLoaded,
  });
  final bool isLoaded;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(settingsNotifierProvider).isDarkMode;
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: isDarkMode
            ? const Color(HomeV4Colors.capitalContainerDark)
            : const Color(HomeV4Colors.capitalContainerLight),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(
            height: 10,
          ),
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextPoppins(
                text: "Capital invertido",
                fontSize: 10,
              ),
              SizedBox(
                width: 10,
              ),
              Icon(
                Icons.remove_red_eye_outlined,
                size: 16,
              ),
            ],
          ),
          Skeletonizer(
            enabled: isLoaded,
            child: const TextPoppins(
              text: "S/10.500",
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

class ActiveInvestmentContainer extends ConsumerWidget {
  const ActiveInvestmentContainer({
    super.key,
    required this.isLoaded,
  });
  final bool isLoaded;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(settingsNotifierProvider).isDarkMode;
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: isDarkMode
              ? HomeV4Colors.gradientDark
              : HomeV4Colors.gradientDark,
          stops: const [0.0, 0.7],
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          const SizedBox(
            height: 10,
          ),
          const Row(
            children: [
              Expanded(
                child: TextPoppins(
                  text: "Inversiones activas",
                  fontSize: 10,
                ),
              ),
              Icon(
                Icons.remove_red_eye_outlined,
                size: 16,
              ),
            ],
          ),
          Skeletonizer(
            enabled: isLoaded,
            child: const TextPoppins(
              text: "4 inversiones",
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
          Divider(
            color: isDarkMode
                ? const Color(HomeV4Colors.dividerDark)
                : const Color(HomeV4Colors.dividerLight),
            height: 2,
          ),
          const TextPoppins(
            text: "Rentabilidad promedio",
            fontSize: 10,
            fontWeight: FontWeight.w400,
          ),
          Skeletonizer(
            enabled: isLoaded,
            child: const TextPoppins(
              text: "14%",
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
          const TextPoppins(
            text: "de todas tus inversiones en curso",
            fontSize: 10,
            fontWeight: FontWeight.w400,
            lines: 2,
          ),
        ],
      ),
    );
  }
}
