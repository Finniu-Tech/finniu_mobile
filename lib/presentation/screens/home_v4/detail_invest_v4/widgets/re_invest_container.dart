import 'package:finniu/constants/number_format.dart';
import 'package:finniu/infrastructure/models/business_investments/investment_detail_by_uuid.dart';
import 'package:finniu/infrastructure/models/firebase_analytics.entity.dart';
import 'package:finniu/presentation/providers/firebase_provider.dart';
import 'package:finniu/presentation/screens/catalog/widgets/text_poppins.dart';
import 'package:finniu/presentation/screens/home_v4/detail_invest_v4/widgets/help_modal.dart';
import 'package:finniu/presentation/screens/home_v4/my_investments/document_page.dart';
import 'package:finniu/presentation/screens/new_simulator/v2_summary_screen.dart';
import 'package:finniu/presentation/screens/new_simulator/widgets/modal/error_modal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

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
    required this.opetationInvest,
  });
  final bool isDarkMode;
  final String uuidInvest;
  final String opetationInvest;
  @override
  Widget build(BuildContext context) {
    const int titleDark = 0xffFFFFFF;
    const int titleLight = 0xff000000;
    const int dividerDark = 0xff0D3A5C;
    const int dividerLight = 0xffA2E6FA;

    void onTap() => Navigator.pushNamed(context, '/v4/documents',
        arguments: DocumentNavigate(uuid: uuidInvest, operationNumber: opetationInvest));

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
                  color: isDarkMode ? const Color(titleDark) : const Color(titleLight),
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
                  color: isDarkMode ? const Color(titleDark) : const Color(titleLight),
                ),
              ],
            ),
            const TextPoppins(
              text: "Información de tu contrato, impuestos, reporte",
              fontSize: 12,
            ),
            Divider(
              height: 1,
              color: isDarkMode ? const Color(dividerDark) : const Color(dividerLight),
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
    final String amountAdd = dataReinvest.reinvestmentAditionalAmount?.toStringAsFixed(2) ?? '0.00';
    void onPressedContrat() {
      Navigator.pushNamed(context, '/v4/push_to_url', arguments: dataReinvest.contractUrl);
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
              dataReinvest.contractUrl != null && dataReinvest.contractUrl != ''
                  ? GestureDetector(
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
                    )
                  : const SizedBox(),
            ],
          ),
          Row(
            children: [
              SvgPicture.asset(
                "assets/svg_icons/dolar_money_icon.svg",
                color: const Color(contratColor),
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
                  text: "+ ${formatNumberNotComa(number: amountAdd, isSoles: isSoles)}",
                  fontSize: 10,
                  textDark: contratColor,
                  textLight: contratColor,
                ),
              ),
            ],
          ),
          GestureDetector(
            onTap: onPressedHelp,
            child: Row(
              children: [
                const Icon(
                  Icons.calendar_today_outlined,
                  size: 20,
                  color: Colors.black,
                ),
                const SizedBox(width: 5),
                const TextPoppins(
                  text: "Inicia",
                  fontSize: 12,
                  textDark: textColor,
                  textLight: textColor,
                  fontWeight: FontWeight.w500,
                ),
                const SizedBox(width: 5),
                TextPoppins(
                  text: dataReinvest.startDate ?? '',
                  fontSize: 12,
                  textDark: textColor,
                  textLight: textColor,
                ),
                const SizedBox(width: 15),
                const Icon(
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
