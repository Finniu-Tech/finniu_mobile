import 'package:finniu/constants/colors/my_invest_v4_colors.dart';
import 'package:finniu/constants/contact_whats_app.dart';
import 'package:finniu/domain/entities/investment_rentability_report_entity.dart';
import 'package:finniu/domain/entities/user_all_investment_v4_entity.dart';
import 'package:finniu/infrastructure/models/arguments_navigator.dart';
import 'package:finniu/infrastructure/models/firebase_analytics.entity.dart';
import 'package:finniu/presentation/providers/firebase_provider.dart';
import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:finniu/presentation/screens/catalog/widgets/animated_number.dart';
import 'package:finniu/presentation/screens/catalog/widgets/no_investment_case.dart';
import 'package:finniu/presentation/screens/catalog/widgets/text_poppins.dart';
import 'package:finniu/presentation/screens/catalog/widgets/validation_modal.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ToValidateListV4 extends ConsumerWidget {
  const ToValidateListV4({super.key, required this.list});
  final List<InvestmentV4> list;
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
                        '/v4/detail_invest',
                        arguments: ArgumentsNavigator(
                          uuid: list[index].uuid,
                          status: StatusInvestmentEnum.in_process,
                        ),
                      );
                    },
                    child: ToValidateInvestmentV4(
                      item: list[index],
                    ),
                  ),
                );
              },
            ),
    );
  }
}

class ToValidateInvestmentV4 extends ConsumerWidget {
  const ToValidateInvestmentV4({
    super.key,
    required this.item,
  });
  final InvestmentV4 item;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(settingsNotifierProvider).isDarkMode;

    return Container(
      padding: const EdgeInsets.all(10),
      width: MediaQuery.of(context).size.width * 0.9,
      height: 125,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        color: isDarkMode
            ? const Color(ToValidateColorsV4.backgroundDark)
            : const Color(ToValidateColorsV4.backgroundLight),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Row(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.6,
                child: TextPoppins(
                  text: item.fundName ?? "Inversion",
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  textDark: ToValidateColorsV4.fundTitleDark,
                  textLight: ToValidateColorsV4.fundTitleLight,
                ),
              ),
              const Spacer(),
              Icon(
                Icons.timer_outlined,
                size: 16,
                color: isDarkMode
                    ? const Color(ToValidateColorsV4.iconDark)
                    : const Color(ToValidateColorsV4.iconLight),
              ),
              const SizedBox(
                width: 5,
              ),
              const TextPoppins(
                text: "En revisión",
                fontSize: 9,
                textDark: ToValidateColorsV4.fundTitleDark,
                textLight: ToValidateColorsV4.fundTitleLight,
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                child: Container(
                  constraints: const BoxConstraints(maxWidth: 150),
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    color: isDarkMode
                        ? const Color(ToValidateColorsV4.itemAmonutDark)
                        : const Color(ToValidateColorsV4.itemAmountLight),
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
                                ? const Color(
                                    ToValidateColorsV4.fundTitleDark,
                                  )
                                : const Color(
                                    ToValidateColorsV4.itemAmountTextLight,
                                  ),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          const TextPoppins(
                            text: "Inversión en curso",
                            fontSize: 7,
                            textDark: ToValidateColorsV4.fundTitleDark,
                            textLight: ToValidateColorsV4.fundTitleLight,
                          ),
                        ],
                      ),
                      AnimationNumberNotComma(
                        isSoles: null,
                        endNumber: item.amount,
                        duration: 2,
                        fontSize: 16,
                        colorText: isDarkMode
                            ? ToValidateColorsV4.itemAmonutTextDark
                            : ToValidateColorsV4.itemAmountTextLight,
                        beginNumber: 0,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    color: isDarkMode
                        ? const Color(ToValidateColorsV4.itemRentDark)
                        : const Color(ToValidateColorsV4.itemRentLight),
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
                                ? const Color(
                                    ToValidateColorsV4.itemRentTextDark)
                                : const Color(
                                    ToValidateColorsV4.itemRentTextLight,
                                  ),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          const TextPoppins(
                            text: "Rentabilidad",
                            fontSize: 7,
                            textDark: ToValidateColorsV4.itemRentTextDark,
                            textLight: ToValidateColorsV4.itemRentTextLight,
                          ),
                        ],
                      ),
                      TextPoppins(
                        text: item.rentability != null
                            ? "${item.rentability!.toStringAsFixed(2)}%"
                            : "0%",
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        textDark: ToValidateColorsV4.itemRentTextDark,
                        textLight: ToValidateColorsV4.itemRentTextLight,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(100)),
                  color: isDarkMode
                      ? const Color(ToValidateColorsV4.buttonDetailDark)
                      : const Color(ToValidateColorsV4.buttonDetailLight),
                ),
                child: Icon(
                  Icons.arrow_forward_ios,
                  size: 16,
                  color: isDarkMode
                      ? const Color(ToValidateColorsV4.iconDetailDark)
                      : const Color(ToValidateColorsV4.iconDetailLight),
                ),
              ),
            ],
          ),
          GestureDetector(
            onTap: () => {showValidationModal(context, contactWhatsApp)},
            child: Row(
              children: [
                Icon(
                  Icons.help_outline,
                  size: 16,
                  color: isDarkMode
                      ? const Color(ToValidateColorsV4.iconDark)
                      : const Color(ToValidateColorsV4.iconLight),
                ),
                const SizedBox(
                  width: 5,
                ),
                const TextPoppins(
                  text: "¿Cuanto tiempo demora la revisión?",
                  fontSize: 8,
                  textDark: ToValidateColorsV4.fundTitleDark,
                  textLight: ToValidateColorsV4.fundTitleLight,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
