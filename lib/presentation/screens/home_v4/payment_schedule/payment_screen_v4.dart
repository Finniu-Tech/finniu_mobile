import 'package:finniu/constants/number_format.dart';
import 'package:finniu/domain/entities/user_bank_account_entity.dart';
import 'package:finniu/infrastructure/models/business_investments/investment_detail_by_uuid.dart';
import 'package:finniu/presentation/providers/get_table_invest_pay.dart';
import 'package:finniu/presentation/providers/money_provider.dart';
import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:finniu/presentation/screens/catalog/circular_loader.dart';
import 'package:finniu/presentation/screens/catalog/widgets/text_poppins.dart';
import 'package:finniu/presentation/screens/home_v4/payment_schedule/widgets/capital_modal.dart';
import 'package:finniu/presentation/screens/home_v4/payment_schedule/widgets/profitability_list.dart';
import 'package:finniu/presentation/screens/home_v4/payment_schedule/widgets/profitability_modal.dart';
import 'package:flutter/material.dart';
import 'package:finniu/presentation/screens/home_v4/payment_schedule/widgets/title_fond.dart';
import 'package:finniu/presentation/screens/home_v4/products_v4/app_bar_products.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class PaymentScreenV4 extends StatelessWidget {
  const PaymentScreenV4({super.key});

  @override
  Widget build(
    BuildContext context,
  ) {
    final args = ModalRoute.of(context)!.settings.arguments as String;
    return Scaffold(
      appBar: const AppBarProducts(
        title: "Cronograma de pagos",
      ),
      body: SingleChildScrollView(
        child: PaymentBodyProvider(args: args),
      ),
    );
  }
}

class PaymentBodyProvider extends ConsumerWidget {
  const PaymentBodyProvider({
    super.key,
    required this.args,
  });

  final String args;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profitabilityData = ref.watch(getMonthlyPaymentProviderV4(args));
    return profitabilityData.when(
      data: (data) {
        return PaymentBody(
          item: args,
          data: data,
        );
      },
      error: (error, stackTrace) {
        return Center(
          child: Text(error.toString()),
        );
      },
      loading: () {
        return SizedBox(
          height: MediaQuery.of(context).size.height - 160,
          width: MediaQuery.of(context).size.width,
          child: const Center(
            child: CircularLoader(
              width: 50,
              height: 50,
            ),
          ),
        );
      },
    );
  }
}

class PaymentBody extends ConsumerWidget {
  const PaymentBody({
    super.key,
    required this.item,
    required this.data,
  });
  final String item;
  final TablePayV4 data;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final rent = data.rentabilityAmount;
    final DateTime date = DateTime.now();
    final String percent = data.rentabilityPercent.toStringAsFixed(2);
    final String dateInfo =
        "Actualizado ${getMonthName(date.month)}/${date.year}";
    final List<ProfitabilityItemV4> listPay = [];
    ProfitabilityItemV4? capitalPay;
    for (var element in data.profitabilityListMonth) {
      if (element.isCapitalPayment) {
        capitalPay = element;
      } else {
        listPay.add(element);
      }
    }

    return Center(
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.9,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 15,
            ),
            TitleFond(
              fundName: data.fundName,
            ),
            const SizedBox(
              height: 15,
            ),
            RentContainer(
              rent: rent.toString(),
              percent: percent,
              dateInfo: dateInfo,
              isRender: true,
            ),
            const SizedBox(
              height: 15,
            ),
            const TitleTable(),
            const SizedBox(
              height: 15,
            ),
            Column(
              children: [
                const TitleDataV4(),
                ProfitabilityListV4(
                  list: listPay,
                  operation: data.operationCode,
                  bankTransfer: data.bankAccountSender,
                ),
              ],
            ),
            capitalPay == null
                ? const SizedBox()
                : Column(
                    children: [
                      const TitleCapitalV4(),
                      CapitalDetail(
                        item: capitalPay,
                        operation: data.operationCode,
                        bankTransfer: data.bankAccountSender,
                      ),
                    ],
                  ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}

class CapitalDetail extends ConsumerWidget {
  const CapitalDetail({
    super.key,
    required this.item,
    required this.operation,
    required this.bankTransfer,
  });
  final ProfitabilityItemV4 item;
  final String operation;
  final BankAccount? bankTransfer;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.read(settingsNotifierProvider).isDarkMode;
    final isSoles = ref.read(isSolesStateProvider);
    const int titleTableDark = 0xffFFFFFF;
    const int titleTableLight = 0xff000000;
    const int borderColorDark = 0xffD0D0D0;
    const int borderColorLight = 0xffD0D0D0;
    const int iconDark = 0xffA2E6FA;
    const int iconLight = 0xff0D3A5C;

    void voucherOnPress() {
      final String title = "Operación #$operation";
      const String bankTitle = "Banco a donde te depositamos";
      final String rent = isSoles
          ? formatterSoles.format(item.amount)
          : formatterUSD.format(item.amount);
      final String rentTitle =
          item.isActive ? "Capital pagado" : "Capital a depositar";
      final String date =
          "${item.paymentDate.day}/${getMonthName(item.paymentDate.month)}/${item.paymentDate.year}";
      final String dateTitle =
          item.isActive ? "Fecha de pago" : "Fecha de pago próximo";
      final String time = "${item.paymentDate.hour}:${item.paymentDate.minute}";

      showCapitalModal(
        context,
        profModal: ProfModal(
          title: title,
          bankTitle: bankTitle,
          rent: rent,
          rentTitle: rentTitle,
          date: date,
          dateTitle: dateTitle,
          time: time,
          bankAccount: bankTransfer,
          numberAccount: "",
          downloadVoucher: item.voucher ?? "",
        ),
        isPaid: item.isActive,
      );
    }

    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      height: 50,
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.only(left: 20),
      decoration: BoxDecoration(
        color: Colors.transparent,
        border: Border.all(
          width: 1,
          color: isDarkMode
              ? const Color(borderColorDark)
              : const Color(borderColorLight),
        ),
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(10),
          bottomRight: Radius.circular(10),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          TextPoppins(
            text: isSoles
                ? formatterSolesNotComma.format(item.amount)
                : formatterUSDNotComma.format(item.amount),
            fontSize: 14,
            fontWeight: FontWeight.w500,
            textDark: titleTableDark,
            textLight: titleTableLight,
          ),
          Row(
            children: [
              Icon(
                Icons.calendar_today_outlined,
                size: 16,
                color:
                    isDarkMode ? const Color(iconDark) : const Color(iconLight),
              ),
              const SizedBox(
                width: 5,
              ),
              TextPoppins(
                text:
                    "${getMonthName(item.paymentDate.month)}/${item.paymentDate.year}",
                fontSize: 16,
                fontWeight: FontWeight.w500,
                textDark: titleTableDark,
                textLight: titleTableLight,
              ),
            ],
          ),
          SeeVoucher(
            text: 'Ver',
            icon: "eye.svg",
            onPressed: voucherOnPress,
          ),
        ],
      ),
    );
  }
}

class TitleTable extends ConsumerWidget {
  const TitleTable({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(settingsNotifierProvider).isDarkMode;
    const int iconDark = 0xffA2E6FA;
    const int iconLight = 0xff0D3A5C;
    return Row(
      children: [
        SvgPicture.asset(
          "assets/svg_icons/square_half.svg",
          width: 25,
          height: 25,
          color: isDarkMode ? const Color(iconDark) : const Color(iconLight),
        ),
        const SizedBox(
          width: 10,
        ),
        const TextPoppins(
          text: "Tabla de pagos",
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ],
    );
  }
}

class RentContainer extends ConsumerWidget {
  const RentContainer({
    super.key,
    required this.rent,
    required this.percent,
    required this.dateInfo,
    required this.isRender,
  });
  final String rent;
  final String percent;
  final String dateInfo;
  final bool isRender;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.read(settingsNotifierProvider).isDarkMode;
    final isSoles = ref.read(isSolesStateProvider);

    const int backgroundDark = 0xffB5FF8A;
    const int backgroundLight = 0xffD0FFB5;
    const int dateDark = 0xff0D3A5C;
    const int dateLight = 0xff0D3A5C;
    const int percentDark = 0xff109B60;
    const int percentLight = 0xff109B60;
    const int percentContainerDark = 0xffA5FD72;
    const int percentContainerLight = 0xffBDFF97;
    const int textColor = 0xff000000;

    return Container(
      padding: const EdgeInsets.all(10),
      width: MediaQuery.of(context).size.width * 0.9,
      height: isRender ? 100 : 80,
      decoration: BoxDecoration(
        color: isDarkMode
            ? const Color(backgroundDark)
            : const Color(backgroundLight),
        borderRadius: const BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                'assets/svg_icons/status_up.svg',
                width: 20,
                height: 20,
                color:
                    isDarkMode ? const Color(dateDark) : const Color(dateLight),
              ),
              const SizedBox(
                width: 10,
              ),
              const TextPoppins(
                text: "Rentabilidad acumulada",
                fontSize: 13,
                fontWeight: FontWeight.w500,
                textDark: textColor,
                textLight: textColor,
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextPoppins(
                text: "+${isSoles ? "S/" : "\$"}$rent ",
                fontSize: 16,
                fontWeight: FontWeight.w600,
                textDark: textColor,
                textLight: textColor,
              ),
              const SizedBox(
                width: 10,
              ),
              Container(
                width: 45,
                height: 20,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: isDarkMode
                      ? const Color(percentContainerDark)
                      : const Color(percentContainerLight),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
                child: TextPoppins(
                  text: "+ $percent",
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                  textDark: percentDark,
                  textLight: percentLight,
                ),
              ),
            ],
          ),
          if (isRender)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  'assets/svg_icons/clock_icon.svg',
                  width: 20,
                  height: 20,
                  color: isDarkMode
                      ? const Color(dateDark)
                      : const Color(dateLight),
                ),
                const SizedBox(
                  width: 5,
                ),
                TextPoppins(
                  text: dateInfo,
                  fontSize: 10,
                  fontWeight: FontWeight.w500,
                  textDark: dateDark,
                  textLight: dateLight,
                ),
              ],
            ),
        ],
      ),
    );
  }
}
