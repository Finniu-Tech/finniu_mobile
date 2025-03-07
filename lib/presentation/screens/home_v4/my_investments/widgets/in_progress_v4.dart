import 'package:finniu/constants/colors/my_invest_v4_colors.dart';
import 'package:finniu/domain/entities/investment_rentability_report_entity.dart';

import 'package:finniu/domain/entities/re_investment_entity.dart';
import 'package:finniu/domain/entities/user_all_investment_v4_entity.dart';
import 'package:finniu/infrastructure/models/arguments_navigator.dart';
import 'package:finniu/infrastructure/models/firebase_analytics.entity.dart';
import 'package:finniu/presentation/providers/firebase_provider.dart';
import 'package:finniu/presentation/providers/money_provider.dart';
import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:finniu/presentation/screens/catalog/widgets/animated_number.dart';
import 'package:finniu/presentation/screens/catalog/widgets/no_investment_case.dart';
import 'package:finniu/presentation/screens/catalog/widgets/text_poppins.dart';
import 'package:finniu/presentation/screens/investment_status/widgets/reinvestment_question_modal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class InProgressListV4 extends ConsumerWidget {
  final List<InvestmentV4> list;
  const InProgressListV4({super.key, required this.list});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      // width: 336,
      child: list.isEmpty
          ? const NoInvestmentCase(
              title: "Aún no tienes inversiones en curso",
              textBody:
                  "Recuerda que vas a poder visualizar tus inversiones finalizadas cuando finaliza el plazo de tu inversión",
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
                    },
                    child: ProgressBarInProgressV4(
                      item: list[index],
                    ),
                  ),
                );
              },
            ),
    );
  }
}

class ProgressBarInProgressV4 extends ConsumerWidget {
  const ProgressBarInProgressV4({
    super.key,
    required this.item,
  });
  final InvestmentV4 item;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.read(settingsNotifierProvider).isDarkMode;
    final isSoles = ref.read(isSolesStateProvider);

    void navigateToReinvest() async {
      reinvestmentQuestionModal(
        context,
        ref,
        item.uuid,
        item.amount.toDouble(),
        isSoles ? currencyEnum.PEN : currencyEnum.USD,
        item.fundEntity!,
        true,
      );
    }

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 7,
        vertical: 10,
      ),
      width: MediaQuery.of(context).size.width * 0.9,
      height:
          item.isReinvestAvailable == true && item.actionStatus == ActionStatusEnumV4.reInvestmentDefault ? 140 : 100,
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
                width: MediaQuery.of(context).size.width * 0.45,
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
                Icons.calendar_today_outlined,
                size: 16,
                color:
                    isDarkMode ? const Color(ToValidateColorsV4.iconDark) : const Color(ToValidateColorsV4.iconLight),
              ),
              const SizedBox(
                width: 5,
              ),
              TextPoppins(
                text: "Finaliza: ${item.finishDateInvestment}",
                fontSize: 8,
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
                                    ToValidateColorsV4.fundTitleLight,
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
                        colorText:
                            isDarkMode ? ToValidateColorsV4.itemAmonutTextDark : ToValidateColorsV4.itemAmountTextLight,
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
                          SvgPicture.asset(
                            "assets/svg_icons/rent_icon.svg",
                            width: 14,
                            height: 14,
                            color: isDarkMode
                                ? const Color(
                                    ToValidateColorsV4.itemRentTextDark,
                                  )
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
                        text: item.rentability != null ? item.rentability!.toStringAsFixed(2) : "0.00",
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
              GestureDetector(
                onTap: () => Navigator.pushNamed(
                  context,
                  '/v4/detail_invest',
                  arguments: ArgumentsNavigator(
                    uuid: item.uuid,
                    status: StatusInvestmentEnum.in_course,
                    isReinvestAvailable: item.isReinvestAvailable!,
                  ),
                ),
                child: Container(
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
              ),
            ],
          ),
          if (item.isReinvestAvailable == true && item.actionStatus == ActionStatusEnumV4.reInvestmentDefault)
            GestureDetector(
              onTap: navigateToReinvest,
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 30,
                decoration: BoxDecoration(
                  color: isDarkMode
                      ? const Color(ToValidateColorsV4.buttonReInvestDark)
                      : const Color(ToValidateColorsV4.buttonReInvestLight),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(20),
                  ),
                ),
                child: const Center(
                  child: TextPoppins(
                    text: "Quiero reinvertir",
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    textDark: ToValidateColorsV4.textReInvestDark,
                    textLight: ToValidateColorsV4.textReInvestLight,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
