import 'package:finniu/constants/number_format.dart';
import 'package:finniu/domain/entities/user_bank_account_entity.dart';
import 'package:finniu/infrastructure/models/business_investments/investment_detail_by_uuid.dart';
import 'package:finniu/presentation/providers/money_provider.dart';
import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:finniu/presentation/screens/catalog/widgets/text_poppins.dart';
import 'package:finniu/presentation/screens/home_v4/payment_schedule/widgets/profitability_modal.dart';
import 'package:finniu/presentation/screens/new_simulator/helpers/month_to_string.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ProfitabilityListV4 extends ConsumerWidget {
  const ProfitabilityListV4({
    super.key,
    required this.list,
    required this.operation,
    required this.bankTransfer,
  });
  final List<ProfitabilityItemV4> list;
  final String operation;
  final BankAccount? bankTransfer;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.read(settingsNotifierProvider).isDarkMode;
    final isSoles = ref.read(isSolesStateProvider);
    const int borderColorDark = 0xffD0D0D0;
    const int borderColorLight = 0xffD0D0D0;

    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: list.length * 38 + 15,
      child: ListView.builder(
        itemCount: list.length,
        itemBuilder: (context, index) {
          return Container(
            width: MediaQuery.of(context).size.width,
            height: 38,
            decoration: BoxDecoration(
              border: Border.all(
                width: 1,
                color: isDarkMode
                    ? const Color(borderColorDark)
                    : const Color(borderColorLight),
              ),
              borderRadius: index == list.length - 1
                  ? const BorderRadius.only(
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                    )
                  : BorderRadius.zero,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.3,
                  constraints: const BoxConstraints(
                    minWidth: 100,
                  ),
                  child: Row(
                    children: [
                      const SizedBox(
                        width: 10,
                      ),
                      TextPoppins(
                        text: monthToString(list[index].paymentDate),
                        fontSize: 16,
                      ),
                    ],
                  ),
                ),
                VerticalDivider(
                  thickness: 1,
                  color: isDarkMode
                      ? const Color(borderColorDark)
                      : const Color(borderColorLight),
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      TextPoppins(
                        text: isSoles
                            ? formatterSoles.format(list[index].amount)
                            : formatterUSD.format(list[index].amount),
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                      DetailModal(
                        isPaid: list[index].isCapitalPayment,
                        item: list[index],
                        operation: operation,
                        bankTransfer: bankTransfer,
                        isSoles: isSoles,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class DetailModal extends StatelessWidget {
  const DetailModal({
    super.key,
    required this.isPaid,
    required this.item,
    required this.operation,
    required this.bankTransfer,
    required this.isSoles,
  });
  final bool isSoles;
  final bool isPaid;
  final ProfitabilityItemV4 item;
  final String operation;
  final BankAccount? bankTransfer;
  @override
  Widget build(BuildContext context) {
    final String title = "Operación #$operation";
    const String bankTitle = "Banco a donde te depositamos";
    final String rent = isSoles
        ? formatterSoles.format(item.amount)
        : formatterUSD.format(item.amount);
    const String rentTitle = "Fecha de pago";
    final String date =
        "${item.paymentDate.day}/${getMonthName(item.paymentDate.month)}/${item.paymentDate.year}";
    const String dateTitle = "Rentabilidad pagada";
    const String time = "12:30";
    final BankAccount? bankAccount = bankTransfer;
    void voucherPay() {
      print("pon tap voucher");

      showProfitabilityModal(
        context,
        profModal: ProfModal(
          title: title,
          bankTitle: bankTitle,
          rent: rent,
          rentTitle: rentTitle,
          date: date,
          dateTitle: dateTitle,
          time: time,
          bankAccount: bankAccount,
          numberAccount: "",
          downloadVoucher: item.voucher ?? "",
        ),
      );
    }

    void voucherSee() {
      print("pon tap see");
      showProfitabilityModal(
        context,
        profModal: ProfModal(
          title: title,
          bankTitle: bankTitle,
          rent: rent,
          rentTitle: rentTitle,
          date: date,
          dateTitle: dateTitle,
          time: time,
          bankAccount: bankAccount,
          numberAccount: "",
          downloadVoucher: item.voucher ?? "",
        ),
      );
    }

    return isPaid
        ? PayButton(
            text: 'Pagado',
            onPressed: voucherPay,
          )
        : SeeVoucher(
            text: 'Ver',
            icon: "eye.svg",
            onPressed: voucherSee,
          );
  }
}

class SeeVoucher extends ConsumerWidget {
  const SeeVoucher({
    super.key,
    required this.text,
    required this.icon,
    required this.onPressed,
  });
  final String text;
  final String icon;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(settingsNotifierProvider).isDarkMode;
    const int backgroundColorDark = 0xff08273F;
    const int backgroundColorLight = 0xffA2E6FA;
    const int contentColorDark = 0xffFFFFFF;
    const int contentColorLight = 0xff000000;
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: 73,
        height: 22,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Color(isDarkMode ? backgroundColorDark : backgroundColorLight),
          borderRadius: BorderRadius.circular(5),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextPoppins(
              text: text,
              fontSize: 11,
              fontWeight: FontWeight.w500,
              textDark: contentColorDark,
              textLight: contentColorLight,
            ),
            const SizedBox(width: 10),
            SvgPicture.asset(
              'assets/svg_icons/$icon',
              width: 14,
              height: 14,
              color: Color(isDarkMode ? contentColorDark : contentColorLight),
            ),
          ],
        ),
      ),
    );
  }
}

class PayButton extends ConsumerWidget {
  const PayButton({
    super.key,
    required this.text,
    required this.onPressed,
  });
  final String text;

  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(settingsNotifierProvider).isDarkMode;
    const int backgroundColorDark = 0xffA2E6FA;
    const int backgroundColorLight = 0xff08273F;
    const int contentColorDark = 0xff000000;
    const int contentColorLight = 0xffFFFFFF;
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: 73,
        height: 22,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Color(isDarkMode ? backgroundColorDark : backgroundColorLight),
          borderRadius: BorderRadius.circular(5),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextPoppins(
              text: text,
              fontSize: 11,
              fontWeight: FontWeight.w500,
              textDark: contentColorDark,
              textLight: contentColorLight,
            ),
            const SizedBox(width: 10),
            Icon(
              Icons.arrow_forward_ios,
              size: 14,
              color: isDarkMode
                  ? const Color(contentColorDark)
                  : const Color(contentColorLight),
            ),
          ],
        ),
      ),
    );
  }
}

class TitleDataV4 extends ConsumerWidget {
  const TitleDataV4({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(settingsNotifierProvider).isDarkMode;
    const int titleTableDark = 0xffFFFFFF;
    const int titleTableLight = 0xff000000;
    const int backgroundColorDark = 0xff0D3A5C;
    const int backgroundColorLight = 0xffE3F9FF;
    const int borderColorDark = 0xffD0D0D0;
    const int borderColorLight = 0xffD0D0D0;

    return Container(
      width: double.infinity,
      height: 38,
      decoration: BoxDecoration(
        color: isDarkMode
            ? const Color(backgroundColorDark)
            : const Color(backgroundColorLight),
        border: Border.all(
          width: 1,
          color: isDarkMode
              ? const Color(borderColorDark)
              : const Color(borderColorLight),
        ),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            width: MediaQuery.of(context).size.width * 0.3,
            constraints: const BoxConstraints(minWidth: 100),
            child: Row(
              children: [
                const SizedBox(
                  width: 10,
                ),
                Icon(
                  Icons.calendar_today_outlined,
                  size: 15,
                  color: isDarkMode
                      ? const Color(titleTableDark)
                      : const Color(titleTableLight),
                ),
                const SizedBox(
                  width: 5,
                ),
                const TextPoppins(
                  text: "Mes",
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  textDark: titleTableDark,
                  textLight: titleTableLight,
                ),
              ],
            ),
          ),
          VerticalDivider(
            thickness: 1,
            color: isDarkMode
                ? const Color(borderColorDark)
                : const Color(borderColorLight),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(
                width: 20,
              ),
              SvgPicture.asset(
                'assets/svg_icons/status_up_two.svg',
                width: 17,
                height: 17,
                color: isDarkMode
                    ? const Color(titleTableDark)
                    : const Color(titleTableLight),
              ),
              const SizedBox(
                width: 5,
              ),
              const TextPoppins(
                text: "Rentabilidad",
                fontSize: 16,
                fontWeight: FontWeight.w500,
                textDark: titleTableDark,
                textLight: titleTableLight,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class TitleCapitalV4 extends ConsumerWidget {
  const TitleCapitalV4({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(settingsNotifierProvider).isDarkMode;
    const int titleTableDark = 0xffFFFFFF;
    const int titleTableLight = 0xff000000;
    const int backgroundColorDark = 0xff0D3A5C;
    const int backgroundColorLight = 0xffE3F9FF;
    const int borderColorDark = 0xffD0D0D0;
    const int borderColorLight = 0xffD0D0D0;

    return Container(
      width: double.infinity,
      height: 38,
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.only(left: 20),
      decoration: BoxDecoration(
        color: isDarkMode
            ? const Color(backgroundColorDark)
            : const Color(backgroundColorLight),
        border: Border.all(
          width: 1,
          color: isDarkMode
              ? const Color(borderColorDark)
              : const Color(borderColorLight),
        ),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
      child: const TextPoppins(
        text: "Pago del capital",
        fontSize: 16,
        fontWeight: FontWeight.w500,
        textDark: titleTableDark,
        textLight: titleTableLight,
      ),
    );
  }
}
