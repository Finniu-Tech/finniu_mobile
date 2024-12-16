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
import 'package:finniu/presentation/screens/home_v4/payment_schedule/widgets/rent_contaiener.dart';
import 'package:finniu/presentation/screens/home_v4/payment_schedule/widgets/title_fond.dart';
import 'package:finniu/presentation/screens/home_v4/products_v4/app_bar_products.dart';
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
    print(args);
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
                      ),
                    ],
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
  });
  final ProfitabilityItemV4 item;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(settingsNotifierProvider).isDarkMode;
    final isSoles = ref.watch(isSolesStateProvider);
    const int titleTableDark = 0xffFFFFFF;
    const int titleTableLight = 0xff000000;
    const int borderColorDark = 0xffD0D0D0;
    const int borderColorLight = 0xffD0D0D0;
    const int iconDark = 0xffA2E6FA;
    const int iconLight = 0xff0D3A5C;

    void voucherOnPress() {
      const String title = "Operación #001";
      const String bankTitle = "Banco a donde te depositamos";
      const String rent = "S/70.90";
      const String rentTitle = "Capital a depositar";
      const String date = "12/Ene/2024";
      const String dateTitle = "Fecha de pago próximo";
      const String time = "12:30";
      final BankAccount bankAccount = BankAccount(
        id: "1",
        bankAccount: "234242424244",
        bankName: "BBVA",
        currency: "nuevo sol",
        typeAccount: "cuenta_ahorros",
        isJointAccount: false,
        isDefaultAccount: true,
        bankSlug: "bbva",
      );
      print("pon tap voucher");

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
          bankAccount: bankAccount,
          numberAccount: bankAccount.bankAccount,
          downloadVoucher: "",
        ),
        isPaid: true,
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
        Icon(
          Icons.table_chart_outlined,
          size: 20,
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
