import 'package:finniu/constants/colors/home_v4_colors.dart';
import 'package:finniu/constants/colors/my_invest_v4_colors.dart';
import 'package:finniu/domain/entities/home_v4_entity.dart';
import 'package:finniu/presentation/providers/eye_home_provider.dart';
import 'package:finniu/presentation/providers/money_provider.dart';
import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:finniu/presentation/screens/catalog/widgets/text_poppins.dart';
import 'package:finniu/presentation/screens/home_v4/my_investments/widgets/modal_active_invest.dart';
import 'package:finniu/widgets/switch.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:skeletonizer/skeletonizer.dart';

class MyInvestmentsContainer extends ConsumerWidget {
  const MyInvestmentsContainer({
    super.key,
    required this.isLoaded,
    required this.data,
  });
  final bool isLoaded;
  final HomeUserInvest data;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(settingsNotifierProvider).isDarkMode;
    final isSoles = ref.watch(isSolesStateProvider);
    final eyeOpen = ref.watch(eyeHomeProvider);

    final AllInvestment investSelect =
        isSoles ? data.investmentInSoles! : data.investmentInDolares!;
    final capitalInCourse = investSelect.capitalInCourse == null
        ? "0.00"
        : investSelect.capitalInCourse.toString();
    final totalBalanceRentabilityIncreased =
        investSelect.totalBalanceRentabilityIncreased == null
            ? "0.00"
            : investSelect.totalBalanceRentabilityIncreased.toString();
    const String? totalBalanceRentabilityActually = null;
    void onTapInvestActive() {
      showModalActiveInvest(context);
    }

    return Container(
      padding: const EdgeInsets.only(
        left: 20,
        right: 20,
      ),
      height: 230,
      decoration: BoxDecoration(
        color: isDarkMode
            ? const Color(MyInvestV4Colors.containerDark)
            : const Color(MyInvestV4Colors.containerLight),
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(25),
          bottomRight: Radius.circular(25),
        ),
      ),
      child: Column(
        children: [
          const RowGoCalendar(),
          SizedBox(
            height: 160,
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: isDarkMode
                          ? const Color(MyInvestV4Colors.totalInvestDark)
                          : const Color(MyInvestV4Colors.totalInvestLight),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(10.0)),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const TextPoppins(
                          text: "Inversión en curso",
                          fontSize: 11,
                          fontWeight: FontWeight.w500,
                          textDark: MyInvestV4Colors.totalInvestTextDark,
                          textLight: MyInvestV4Colors.totalInvestTextLight,
                        ),
                        TextPoppins(
                          text:
                              "+${isSoles ? "S/" : "\$"}${eyeOpen ? capitalInCourse : "****"}",
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          textDark: MyInvestV4Colors.totalInvestTextDark,
                          textLight: MyInvestV4Colors.totalInvestTextLight,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.45,
                  child: Column(
                    children: [
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: isDarkMode
                                ? const Color(
                                    HomeV4Colors.interestContainerDark)
                                : const Color(
                                    HomeV4Colors.interestContainerLight),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const TextPoppins(
                                    text: "Rentabilidad",
                                    fontSize: 11,
                                    textDark:
                                        HomeV4Colors.interestGeneratedTextDark,
                                    textLight:
                                        HomeV4Colors.interestGeneratedTextLight,
                                  ),
                                  const Spacer(),
                                  totalBalanceRentabilityActually == null
                                      ? const SizedBox()
                                      : Container(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 6,
                                            vertical: 2,
                                          ),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            color: isDarkMode
                                                ? const Color(
                                                    HomeV4Colors
                                                        .interestGeneratedContDark,
                                                  )
                                                : const Color(
                                                    HomeV4Colors
                                                        .interestGeneratedContLight,
                                                  ),
                                          ),
                                          child: TextPoppins(
                                            text:
                                                totalBalanceRentabilityActually,
                                            fontSize: 10,
                                            fontWeight: FontWeight.w500,
                                            textDark: HomeV4Colors
                                                .interestGeneratedDark,
                                            textLight: HomeV4Colors
                                                .interestGeneratedLight,
                                          ),
                                        ),
                                ],
                              ),
                              const SizedBox(height: 5),
                              Skeletonizer(
                                enabled: isLoaded,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    TextPoppins(
                                      text:
                                          "+${isSoles ? "S/" : "\$"}${eyeOpen ? totalBalanceRentabilityIncreased : "****"}",
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                      textDark: HomeV4Colors
                                          .interestGeneratedTextDark,
                                      textLight: HomeV4Colors
                                          .interestGeneratedTextLight,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: onTapInvestActive,
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.45,
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: isDarkMode
                                  ? const Color(
                                      MyInvestV4Colors.investActiveDark)
                                  : const Color(
                                      MyInvestV4Colors.investActiveLight),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10.0)),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const TextPoppins(
                                  text: "Inversiones activas",
                                  fontSize: 11,
                                  fontWeight: FontWeight.w400,
                                  textDark:
                                      MyInvestV4Colors.investActiveTextDark,
                                  textLight:
                                      MyInvestV4Colors.investActiveTextLight,
                                ),
                                Row(
                                  children: [
                                    TextPoppins(
                                      text: investSelect.countPlanesActive
                                          .toString(),
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600,
                                      textDark:
                                          MyInvestV4Colors.investActiveTextDark,
                                      textLight: MyInvestV4Colors
                                          .investActiveTextLight,
                                    ),
                                    const TextPoppins(
                                      text: " inversiones",
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      textDark:
                                          MyInvestV4Colors.investActiveTextDark,
                                      textLight: MyInvestV4Colors
                                          .investActiveTextLight,
                                    ),
                                    const Spacer(),
                                    Icon(
                                      Icons.chevron_right,
                                      color: isDarkMode
                                          ? const Color(
                                              MyInvestV4Colors
                                                  .investActiveTextDark,
                                            )
                                          : const Color(
                                              MyInvestV4Colors
                                                  .investActiveTextLight,
                                            ),
                                      size: 25,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
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
        ],
      ),
    );
  }
}

class RowGoCalendar extends ConsumerWidget {
  const RowGoCalendar({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(settingsNotifierProvider).isDarkMode;
    final eyeOpen = ref.watch(eyeHomeProvider);
    final eyeNotifier = ref.read(eyeHomeProvider.notifier);
    return SizedBox(
      height: 50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () => Navigator.pushNamed(context, '/v4/calendar'),
            child: Row(
              children: [
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: isDarkMode
                        ? const Color(MyInvestV4Colors.calendarDark)
                        : const Color(MyInvestV4Colors.calendarLight),
                  ),
                  child: Icon(
                    Icons.calendar_today_outlined,
                    size: 20,
                    color: isDarkMode
                        ? const Color(MyInvestV4Colors.calendarIconDark)
                        : const Color(MyInvestV4Colors.calendarIconLight),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                const TextPoppins(
                  text: "Ver Calendario de pagos",
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ],
            ),
          ),
          const Spacer(),
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
