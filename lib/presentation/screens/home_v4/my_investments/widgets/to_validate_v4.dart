import 'package:finniu/domain/entities/investment_rentability_report_entity.dart';
import 'package:finniu/domain/entities/user_all_investment_entity.dart';
import 'package:finniu/infrastructure/models/arguments_navigator.dart';
import 'package:finniu/infrastructure/models/firebase_analytics.entity.dart';
import 'package:finniu/presentation/providers/firebase_provider.dart';
import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:finniu/presentation/screens/catalog/widgets/no_investment_case.dart';
import 'package:finniu/presentation/screens/catalog/widgets/text_poppins.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ToValidateListV4 extends ConsumerWidget {
  const ToValidateListV4({super.key, required this.list});
  final List<Investment> list;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      // height: 336,
      child: list.isEmpty
          ? const NoInvestmentCase(
              title: "Aún no tienes inversiones por validar",
              textBody:
                  "Recuerda que vas a poder visualizar tus inversiones por validar cuando hayas realizado una inversión reciente y no ha sido aprobada aún",
            )
          : ListView.builder(
              itemCount: list.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: GestureDetector(
                    onTap: () {
                      ref.read(firebaseAnalyticsServiceProvider).logCustomEvent(
                        eventName: FirebaseAnalyticsEvents.navigateTo,
                        parameters: {
                          "screen": FirebaseScreen.investmentV2,
                          "navigate_to": FirebaseScreen.summaryV2,
                          "status": StatusInvestmentEnum.in_process,
                        },
                      );
                      Navigator.pushNamed(
                        context,
                        '/v2/summary',
                        arguments: ArgumentsNavigator(
                          uuid: list[index].uuid,
                          status: StatusInvestmentEnum.in_process,
                        ),
                      );
                    },
                    child: ToValidateInvestmentV4(
                      dateEnds: list[index].finishDateInvestment,
                      amount: list[index].amount,
                    ),
                  ),
                );
              },
            ),
    );
  }
}

class ToValidateInvestmentV4 extends ConsumerWidget {
  final String dateEnds;
  final int amount;
  final bool? isReinvestment;
  const ToValidateInvestmentV4({
    super.key,
    required this.dateEnds,
    required this.amount,
    this.isReinvestment,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(settingsNotifierProvider).isDarkMode;
    const backgroundDark = 0xff252525;
    const backgroundLight = 0xffFFFFFF;
    const fundTitleDark = 0xff252525;
    const fundTitleLight = 0xff000000;
    const iconDark = 0xffA2E6FA;
    const iconLight = 0xff0D3A5C;
    const int itemAmonutDark = 0xff0D3A5C;
    const int itemAmountLight = 0xffCFF4FF;
    const int itemAmonutTextDark = 0xffA2E6FA;
    const int itemAmountTextLight = 0xff0D3A5C;
    const int itemRentDark = 0xffB5FF8A;
    const int itemRentLight = 0xffD9FFC4;
    const int itemRentTextDark = 0xffA2E6FA;
    const int itemRentTextLight = 0xff0D3A5C;
    const int buttonDetailDark = 0xff125385;
    const int buttonDetailLight = 0xffA2E6FA;
    const int iconDetailDark = 0xff125385;
    const int iconDetailLight = 0xff000000;
    return Container(
      padding: const EdgeInsets.all(10),
      width: MediaQuery.of(context).size.width * 0.9,
      height: 125,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        color: isDarkMode
            ? const Color(backgroundDark)
            : const Color(backgroundLight),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Row(
            children: [
              const TextPoppins(
                text: "Inversión fondo empresarial",
                fontSize: 12,
                fontWeight: FontWeight.w500,
                textDark: fundTitleDark,
                textLight: fundTitleLight,
              ),
              const Spacer(),
              Icon(
                Icons.timer_outlined,
                size: 16,
                color:
                    isDarkMode ? const Color(iconDark) : const Color(iconLight),
              ),
              const SizedBox(
                width: 5,
              ),
              const TextPoppins(
                text: "En revisión",
                fontSize: 9,
                textDark: fundTitleDark,
                textLight: fundTitleLight,
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    color: isDarkMode
                        ? const Color(itemAmonutDark)
                        : const Color(itemAmountLight),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.monetization_on_outlined,
                            size: 12,
                            color: isDarkMode
                                ? const Color(itemAmonutTextDark)
                                : const Color(itemAmountTextLight),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          const TextPoppins(
                            text: "Inversión en curso",
                            fontSize: 7,
                            textDark: itemAmonutTextDark,
                            textLight: itemAmountTextLight,
                          ),
                        ],
                      ),
                      const TextPoppins(
                        text: "S/1,000.00",
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        textDark: itemAmonutTextDark,
                        textLight: itemAmountTextLight,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                width: 5,
              ),
              Expanded(
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    color: isDarkMode
                        ? const Color(itemRentDark)
                        : const Color(itemRentLight),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.show_chart,
                            size: 12,
                            color: isDarkMode
                                ? const Color(itemRentTextDark)
                                : const Color(itemRentTextLight),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          const TextPoppins(
                            text: "Rentabilidad",
                            fontSize: 8,
                            textDark: itemRentTextDark,
                            textLight: itemRentTextLight,
                          ),
                        ],
                      ),
                      const TextPoppins(
                        text: "16%",
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        textDark: itemRentTextDark,
                        textLight: itemRentTextLight,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                width: 5,
              ),
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(100)),
                  color: isDarkMode
                      ? const Color(buttonDetailDark)
                      : const Color(buttonDetailLight),
                ),
                child: Icon(
                  Icons.arrow_forward_ios,
                  size: 16,
                  color: isDarkMode
                      ? const Color(iconDetailDark)
                      : const Color(iconDetailLight),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Icon(
                Icons.help_outline,
                size: 16,
                color:
                    isDarkMode ? const Color(iconDark) : const Color(iconLight),
              ),
              const SizedBox(
                width: 5,
              ),
              const TextPoppins(
                text: "¿Cuanto tiempo demora la revisión?",
                fontSize: 8,
                textDark: iconDark,
                textLight: iconLight,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
