import 'package:finniu/constants/colors/home_v4_colors.dart';
import 'package:finniu/presentation/providers/eye_home_provider.dart';
import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:finniu/presentation/screens/catalog/widgets/text_poppins.dart';
import 'package:finniu/widgets/switch.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
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
      padding: const EdgeInsets.only(
        left: 20,
        right: 20,
      ),
      height: 360,
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
          const RowSwitchAndEye(),
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

class RowSwitchAndEye extends ConsumerWidget {
  const RowSwitchAndEye({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(settingsNotifierProvider).isDarkMode;
    final eyeOpen = ref.watch(eyeHomeProvider);
    final eyeNotifier = ref.read(eyeHomeProvider.notifier);

    return SizedBox(
      height: 35,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SwitchMoney(
            switchHeight: 30,
            switchWidth: 67,
          ),
          IconButton(
            icon: Icon(
              !eyeOpen
                  ? Icons.visibility_off_outlined
                  : Icons.visibility_outlined,
              color: isDarkMode
                  ? const Color(HomeV4Colors.iconEyeDark)
                  : const Color(HomeV4Colors.iconEyeLight),
              size: 20,
            ),
            onPressed: () {
              eyeNotifier.toggleEyeHome();
            },
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                "assets/svg_icons/calendar_home_icon.svg",
                width: 25,
                height: 25,
                color: isDarkMode
                    ? const Color(HomeV4Colors.paymentsTextDark)
                    : const Color(HomeV4Colors.paymentsTextLight),
              ),
              const SizedBox(
                width: 10,
              ),
              const TextPoppins(
                text: "Mis pagos",
                fontSize: 12,
                textDark: HomeV4Colors.paymentsTextDark,
                textLight: HomeV4Colors.paymentsTextLight,
              ),
            ],
          ),
        ],
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
    void onTap() {
      Navigator.pushNamed(context, '/v4/products');
    }

    final isDarkMode = ref.watch(settingsNotifierProvider).isDarkMode;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: isDarkMode
              ? const Color(HomeV4Colors.interestButtonDark)
              : const Color(HomeV4Colors.interestButtonLight),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  "assets/svg_icons/money_home_icon.svg",
                  width: 25,
                  height: 25,
                  color: isDarkMode
                      ? const Color(HomeV4Colors.interestTextDark)
                      : const Color(HomeV4Colors.interestTextLight),
                ),
                const SizedBox(
                  width: 10,
                ),
                const TextPoppins(
                  text: "Quiero invertir",
                  fontSize: 12,
                  textDark: HomeV4Colors.interestTextDark,
                  textLight: HomeV4Colors.interestTextLight,
                ),
              ],
            ),
          ],
        ),
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
    final eyeOpen = ref.watch(eyeHomeProvider);
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset(
                "assets/svg_icons/chart_home_icon.svg",
                width: 20,
                height: 20,
                color: isDarkMode
                    ? const Color(HomeV4Colors.interestGeneratedDark)
                    : const Color(HomeV4Colors.interestGeneratedLight),
              ),
              const TextPoppins(
                text: "Interes generados",
                fontSize: 8,
                textDark: HomeV4Colors.interestGeneratedTextDark,
                textLight: HomeV4Colors.interestGeneratedTextLight,
              ),
            ],
          ),
          Skeletonizer(
            enabled: isLoaded,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextPoppins(
                  text: "+S/${eyeOpen ? "10.500" : "****"}",
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  textDark: HomeV4Colors.interestGeneratedTextDark,
                  textLight: HomeV4Colors.interestGeneratedTextLight,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 6,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: isDarkMode
                        ? const Color(HomeV4Colors.interestGeneratedContDark)
                        : const Color(HomeV4Colors.interestGeneratedContLight),
                  ),
                  child: const TextPoppins(
                    text: "+1.40",
                    fontSize: 10,
                    fontWeight: FontWeight.w500,
                    textDark: HomeV4Colors.interestGeneratedDark,
                    textLight: HomeV4Colors.interestGeneratedLight,
                  ),
                ),
              ],
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
    final eyeOpen = ref.watch(eyeHomeProvider);
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
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset(
                "assets/svg_icons/money_home_icon.svg",
                width: 20,
                height: 20,
                color: isDarkMode
                    ? const Color(HomeV4Colors.capitalTextDark)
                    : const Color(HomeV4Colors.capitalTextLight),
              ),
              const TextPoppins(
                text: "Capital invertido",
                fontSize: 10,
              ),
            ],
          ),
          Skeletonizer(
            enabled: isLoaded,
            child: TextPoppins(
              text: "S/${eyeOpen ? "10.500" : "****"}",
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
              : HomeV4Colors.gradientLight,
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
