import 'package:finniu/constants/contact_whats_app.dart';
import 'package:finniu/domain/entities/investment_rentability_report_entity.dart';
import 'package:finniu/domain/entities/re_investment_entity.dart';
import 'package:finniu/infrastructure/models/arguments_navigator.dart';
import 'package:finniu/infrastructure/models/business_investments/investment_detail_by_uuid.dart';
import 'package:finniu/infrastructure/models/firebase_analytics.entity.dart';
import 'package:finniu/presentation/providers/firebase_provider.dart';
import 'package:finniu/presentation/providers/investment_detail_uuid_provider.dart';
import 'package:finniu/presentation/providers/money_provider.dart';
import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:finniu/presentation/screens/business_investments/widgets/app_bar_business.dart';
import 'package:finniu/presentation/screens/catalog/widgets/send_proof_button.dart';
import 'package:finniu/presentation/screens/catalog/widgets/text_poppins.dart';
import 'package:finniu/presentation/screens/catalog/widgets/validation_modal.dart';
import 'package:finniu/presentation/screens/home_v4/detail_invest_v4/widgets/help_modal.dart';
import 'package:finniu/presentation/screens/home_v4/detail_invest_v4/widgets/init_end_container.dart';
import 'package:finniu/presentation/screens/investment_status/widgets/reinvestment_question_modal.dart';
import 'package:finniu/presentation/screens/new_simulator/v2_summary_screen.dart';
import 'package:finniu/presentation/screens/new_simulator/widgets/icon_found.dart';
import 'package:finniu/presentation/screens/new_simulator/widgets/investment_amount_card.dart';
import 'package:finniu/presentation/screens/new_simulator/widgets/loader_container.dart';
import 'package:finniu/presentation/screens/new_simulator/widgets/modal/error_modal.dart';
import 'package:finniu/presentation/screens/new_simulator/widgets/selected_back_transfer.dart';
import 'package:finniu/presentation/screens/new_simulator/widgets/selected_bank_deposit.dart';
import 'package:finniu/presentation/screens/new_simulator/widgets/term_profitability_row.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class DetailInvestV4 extends StatelessWidget {
  const DetailInvestV4({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: AppBarBusinessScreen(),
      body: SingleChildScrollView(
        child: _BodyScaffold(),
      ),
    );
  }
}

class _BodyScaffold extends ConsumerWidget {
  const _BodyScaffold();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ArgumentsNavigator arguments =
        ModalRoute.of(context)!.settings.arguments as ArgumentsNavigator;
    final isDarkMode = ref.read(settingsNotifierProvider).isDarkMode;
    final isSoles = ref.read(isSolesStateProvider);
    const int columnColorDark = 0xff0E0E0E;
    const int columnColorLight = 0xffFFFFFF;
    final investmentDetailByUuid =
        ref.watch(userInvestmentByUuidFutureProvider(arguments.uuid));

    return investmentDetailByUuid.when(
      error: (error, stack) {
        showErrorGetDetail(context);
        return LoaderContainer(
          isDarkMode: isDarkMode,
          columnColorDark: columnColorDark,
          columnColorLight: columnColorLight,
          status: arguments.status,
        );
      },
      loading: () {
        return LoaderContainer(
          isDarkMode: isDarkMode,
          columnColorDark: columnColorDark,
          columnColorLight: columnColorLight,
          status: arguments.status,
        );
      },
      data: (data) {
        if (data == null) {
          showErrorGetDetail(context);
          return LoaderContainer(
            isDarkMode: isDarkMode,
            columnColorDark: columnColorDark,
            columnColorLight: columnColorLight,
            status: arguments.status,
          );
        }
        return Container(
          color: isDarkMode
              ? const Color(columnColorDark)
              : const Color(columnColorLight),
          width: MediaQuery.of(context).size.width,
          // height: MediaQuery.of(context).size.height,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TitleModalV4(
                  status:
                      StatusInvestmentEnum.getLabelForStatus(arguments.status),
                  isReInvestment: data.isReInvestment,
                ),
                const SizedBox(height: 10),
                const IconFund(),
                const SizedBox(height: 15),
                RowOperationAndVoucher(
                  isDarkMode: isDarkMode,
                  voucher: data.voucher,
                  operation: data.operationCode,
                ),
                const SizedBox(height: 15),
                InvestmentAmountCardsRow(
                  amountInvested: data.amount,
                  finalProfitability: data.amount + data.rentabilityAmount,
                  isLoading: false,
                ),
                const SizedBox(height: 15),
                if (arguments.status != StatusInvestmentEnum.in_process) ...[
                  InitEndContainer(
                    dateStart: data.startDateInvestment,
                    dateEnd: data.finishDateInvestment,
                    dateCapitalPay: data.paymentCapitalDateInvestment,
                    dateRentPay: data.finishDateInvestment,
                    isDarkMode: isDarkMode,
                  ),
                ],
                const SizedBox(height: 15),
                RowNavigateToDocuments(
                  isDarkMode: isDarkMode,
                  uuidInvest: data.uuid,
                ),
                const SizedBox(height: 15),
                TermProfitabilityRow(
                  month: data.month,
                  rentabilityPercent: data.rentabilityPercent,
                  isLoader: false,
                ),
                const SizedBox(height: 15),
                data.bankAccountSender != null
                    ? SelectedBankTransfer(
                        bankAccountSender: data.bankAccountSender!,
                      )
                    : const SizedBox(),
                const SizedBox(height: 15),
                data.bankAccountReceiver != null
                    ? const SizedBox()
                    : const SizedBox(),
                data.bankAccountReceiver != null
                    ? SelectedBankDeposit(
                        bankAccountReceiver: data.bankAccountReceiver!,
                      )
                    : const SizedBox(),
                if (data.profitabilityListMonth.isNotEmpty) ...[
                  SeeInterestPayment(
                    preInvestmentUUID: arguments.uuid,
                  ),
                ],
                if (arguments.isReinvestAvailable == true &&
                    StatusInvestmentEnum.compare(
                      arguments.status,
                      StatusInvestmentEnum.in_course,
                    ) &&
                    ActionStatusEnum.compare(
                      arguments.actionStatus ?? '',
                      ActionStatusEnum.defaultReInvestment,
                    )) ...[
                  arguments.isReinvestAvailable
                      ? ButtonInvestment(
                          text: 'Reinvertir mi inversión',
                          onPressed: () => reinvestmentQuestionModal(
                            context,
                            ref,
                            arguments.uuid,
                            data.amount.toDouble(),
                            isSoles ? currencyEnum.PEN : currencyEnum.USD,
                            true,
                            data.fund,
                            data.rentabilityPercent,
                            data.month,
                          ),
                        )
                      : const SizedBox(),
                ],
                if (arguments.isReinvestAvailable == true &&
                    StatusInvestmentEnum.compare(
                      arguments.status,
                      StatusInvestmentEnum.in_course,
                    ) &&
                    ActionStatusEnum.compare(
                      arguments.actionStatus ?? '',
                      ActionStatusEnum.defaultReInvestment,
                    )) ...[
                  arguments.isReinvestAvailable
                      ? const SizedBox(height: 15)
                      : const SizedBox(),
                ],
                if (ActionStatusEnum.compare(
                  arguments.actionStatus ?? '',
                  ActionStatusEnum.pendingReInvestment,
                )) ...[
                  data.reinvestmentInfo != null
                      ? ReInvestContainer(
                          isDarkMode: isDarkMode,
                          dataReinvest: data.reinvestmentInfo!,
                          isSoles: isSoles,
                        )
                      : const SizedBox(),
                  const SizedBox(height: 15),
                ],
                const SizedBox(height: 15),
                if (arguments.status == StatusInvestmentEnum.in_process) ...[
                  ButtonInvestment(
                    text: "Hablar con un asesor",
                    onPressed: () =>
                        showValidationModal(context, contactWhatsApp),
                  ),
                ],
                if (arguments.status != StatusInvestmentEnum.in_process) ...[
                  data.reinvestmentInfo != null
                      ? ReInvestContainer(
                          isDarkMode: isDarkMode,
                          dataReinvest: data.reinvestmentInfo!,
                          isSoles: isSoles,
                        )
                      : const SizedBox(),
                  const SizedBox(height: 15),
                ],
                if (arguments.status != StatusInvestmentEnum.in_process) ...[
                  ButtonInvestment(
                    text: "Ver tabla de los pagos de intereses",
                    onPressed: () => Navigator.pushNamed(
                      context,
                      '/v4/payment_schedule',
                      arguments: arguments.uuid,
                    ),
                  ),
                ],
              ],
            ),
          ),
        );
      },
    );
  }
}

class RowOperationAndVoucher extends ConsumerWidget {
  const RowOperationAndVoucher({
    super.key,
    required this.operation,
    required this.voucher,
    required this.isDarkMode,
  });
  final String operation;
  final String? voucher;
  final bool isDarkMode;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const int titleDark = 0xffA2E6FA;
    const int titleLight = 0xff0D3A5C;

    void voucherOnPress() {
      ref.read(firebaseAnalyticsServiceProvider).logCustomEvent(
        eventName: FirebaseAnalyticsEvents.voucherDownloadDetail,
        parameters: {},
      );
      if (voucher == null) {
        showNotVoucherOrContract(context, true);
      } else {
        // launchPdfURL(voucher!);
        Navigator.pushNamed(context, '/v4/push_to_url', arguments: voucher);
      }
    }

    return Row(
      children: [
        TextPoppins(
          text: "Operación #$operation",
          fontSize: 14,
          fontWeight: FontWeight.w600,
          textDark: titleDark,
          textLight: titleLight,
        ),
        const Spacer(),
        voucher == null || voucher == ''
            ? const SizedBox()
            : SizedBox(
                width: 131,
                child: ButtonsSimulator(
                  text: 'Ver voucher',
                  icon: "eye.svg",
                  onPressed: voucherOnPress,
                ),
              ),
      ],
    );
  }
}

class RowNavigateToDocuments extends StatelessWidget {
  const RowNavigateToDocuments({
    super.key,
    required this.isDarkMode,
    required this.uuidInvest,
  });
  final bool isDarkMode;
  final String uuidInvest;
  @override
  Widget build(BuildContext context) {
    const int titleDark = 0xffFFFFFF;
    const int titleLight = 0xff000000;
    const int dividerDark = 0xff0D3A5C;
    const int dividerLight = 0xffA2E6FA;

    void onTap() =>
        Navigator.pushNamed(context, '/v4/documents', arguments: uuidInvest);

    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        height: 60,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                SvgPicture.asset(
                  "assets/svg_icons/file_icon.svg",
                  width: 20,
                  height: 20,
                  color: isDarkMode
                      ? const Color(titleDark)
                      : const Color(titleLight),
                ),
                const SizedBox(width: 10),
                const TextPoppins(
                  text: "Documentación",
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  textDark: titleDark,
                  textLight: titleLight,
                ),
                const Spacer(),
                Icon(
                  Icons.arrow_forward_ios,
                  size: 15,
                  color: isDarkMode
                      ? const Color(titleDark)
                      : const Color(titleLight),
                ),
              ],
            ),
            const TextPoppins(
              text: "Información de tu contrato, impuestos, reporte",
              fontSize: 12,
            ),
            Divider(
              height: 1,
              color: isDarkMode
                  ? const Color(dividerDark)
                  : const Color(dividerLight),
            ),
          ],
        ),
      ),
    );
  }
}

//  if (ActionStatusEnum.compare(
//                   arguments.actionStatus ?? '',
//                   ActionStatusEnum.disabledReInvestment,
//                 )) ...[
//                   const ButtonInvestmentDisabled(
//                     text: 'Devolución de Capital Solicitada',
//                     colorBackground: Color(0xff7C73FE),
//                   ),
//                 ],

class ReInvestContainer extends StatelessWidget {
  const ReInvestContainer({
    super.key,
    required this.isDarkMode,
    required this.dataReinvest,
    required this.isSoles,
  });
  final ReInvestmentInfo dataReinvest;
  final bool isDarkMode;
  final bool isSoles;

  @override
  Widget build(BuildContext context) {
    final List<Color> gradientColor = [
      const Color(0xffD1C6FF),
      const Color(0xffA2E6FA),
    ];
    const int contratColor = 0xff0D3A5C;
    const int amountColor = 0xffC5F3FF;
    const int textColor = 0xff000000;
    const int contratTextColor = 0xffFFFFFF;
    final String amountAdd =
        dataReinvest.reinvestmentAditionalAmount?.toStringAsFixed(2) ?? '0.00';
    void onPressedContrat() {
      print(dataReinvest.contractUrl);
    }

    void onPressedHelp() {
      showHelp(context);
    }

    return Container(
      width: MediaQuery.of(context).size.width,
      height: 120,
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: gradientColor,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const TextPoppins(
                text: "Reinversión solicitada",
                fontSize: 14,
                fontWeight: FontWeight.w500,
                textDark: contratColor,
                textLight: contratColor,
              ),
              GestureDetector(
                onTap: onPressedContrat,
                child: Container(
                  width: 95,
                  height: 22,
                  decoration: BoxDecoration(
                    color: const Color(contratColor),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      TextPoppins(
                        text: "Contrato",
                        fontSize: 10,
                        textDark: contratTextColor,
                        textLight: contratTextColor,
                      ),
                      SizedBox(width: 5),
                      Icon(
                        Icons.file_download_outlined,
                        color: Color(contratTextColor),
                        size: 14,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              SvgPicture.asset(
                "assets/svg_icons/dolar_money_icon.svg",
                color: Color(contratColor),
                width: 20,
                height: 20,
              ),
              const SizedBox(width: 5),
              const TextPoppins(
                text: "Reinversión con monto agregado",
                fontSize: 12,
                textDark: textColor,
                textLight: textColor,
              ),
              const Spacer(),
              Container(
                width: 67,
                height: 25,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: const Color(amountColor),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: TextPoppins(
                  text: "+ ${isSoles ? "S/" : "\$"}.$amountAdd",
                  fontSize: 10,
                  textDark: contratColor,
                  textLight: contratColor,
                ),
              ),
            ],
          ),
          GestureDetector(
            onTap: onPressedHelp,
            child: const Row(
              children: [
                Icon(
                  Icons.calendar_today_outlined,
                  size: 20,
                  color: Colors.black,
                ),
                SizedBox(width: 5),
                TextPoppins(
                  text: "Inicia",
                  fontSize: 12,
                  textDark: textColor,
                  textLight: textColor,
                  fontWeight: FontWeight.w500,
                ),
                SizedBox(width: 5),
                TextPoppins(
                  text: "02/03/2025+",
                  fontSize: 12,
                  textDark: textColor,
                  textLight: textColor,
                ),
                SizedBox(width: 15),
                Icon(
                  Icons.help_outline_outlined,
                  size: 20,
                  color: Colors.black,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class TitleModalV4 extends ConsumerWidget {
  const TitleModalV4({
    super.key,
    required this.status,
    this.isReInvestment,
  });
  final String status;
  final bool? isReInvestment;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(settingsNotifierProvider).isDarkMode;
    final textAndColors = StatusInvestmentEnum.getColorForStatus(status);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.6,
          child: TextPoppins(
            text: isReInvestment == true
                ? "Resumen de mi reinversión"
                : "Resumen de mi inversión",
            fontSize: 20,
            fontWeight: FontWeight.w500,
            lines: 2,
          ),
        ),
        Container(
          width: 84,
          height: 26,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: isDarkMode
                ? Color(textAndColors.containerColorDark)
                : Color(
                    textAndColors.containerColorLight,
                  ),
          ),
          child: Center(
            child: TextPoppins(
              text: textAndColors.label,
              fontSize: 12,
              fontWeight: FontWeight.w600,
              textDark: textAndColors.textColorDark,
              textLight: textAndColors.textColorLight,
            ),
          ),
        ),
      ],
    );
  }
}
