import 'package:finniu/constants/colors/home_v4_colors.dart';
import 'package:finniu/constants/colors/my_invest_v4_colors.dart';
import 'package:finniu/presentation/providers/eye_home_provider.dart';
import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:finniu/presentation/screens/catalog/widgets/text_poppins.dart';
import 'package:finniu/widgets/switch.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class MyInvestmentsContainer extends ConsumerWidget {
  const MyInvestmentsContainer({
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
      height: 280,
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
            height: 200,
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
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextPoppins(
                          text: "Inversión en curso",
                          fontSize: 11,
                          fontWeight: FontWeight.w500,
                          textDark: MyInvestV4Colors.totalInvestTextDark,
                          textLight: MyInvestV4Colors.totalInvestTextLight,
                        ),
                        TextPoppins(
                          text: "S/10.326",
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
                                ? const Color(MyInvestV4Colors.rentDark)
                                : const Color(MyInvestV4Colors.rentLight),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10.0)),
                          ),
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width * 0.45,
                            child: const Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                TextPoppins(
                                  text: "Rentabilidad",
                                  fontSize: 11,
                                  fontWeight: FontWeight.w400,
                                  textDark:
                                      MyInvestV4Colors.totalInvestTextDark,
                                  textLight:
                                      MyInvestV4Colors.totalInvestTextLight,
                                ),
                                TextPoppins(
                                  text: "+S/320.60",
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                  textDark:
                                      MyInvestV4Colors.totalInvestTextDark,
                                  textLight:
                                      MyInvestV4Colors.totalInvestTextLight,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Expanded(
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.45,
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: isDarkMode
                                ? const Color(MyInvestV4Colors.investActiveDark)
                                : const Color(
                                    MyInvestV4Colors.investActiveLight),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10.0)),
                          ),
                          child: const Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              TextPoppins(
                                text: "Inversiones activas",
                                fontSize: 11,
                                fontWeight: FontWeight.w400,
                                textDark: MyInvestV4Colors.totalInvestTextDark,
                                textLight:
                                    MyInvestV4Colors.totalInvestTextLight,
                              ),
                              TextPoppins(
                                text: "4 inversiones",
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                textDark: MyInvestV4Colors.totalInvestTextDark,
                                textLight:
                                    MyInvestV4Colors.totalInvestTextLight,
                              ),
                            ],
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
