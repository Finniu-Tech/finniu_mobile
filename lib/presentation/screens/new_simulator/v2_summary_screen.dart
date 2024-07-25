import 'package:finniu/presentation/providers/investment_detail_uuid_provider.dart';
import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:finniu/presentation/screens/business_investments/widgets/app_bar_business.dart';
import 'package:finniu/presentation/screens/catalog/widgets/text_poppins.dart';
import 'package:finniu/presentation/screens/home_v2/widgets/navigation_bar.dart';
import 'package:finniu/presentation/screens/new_simulator/widgets/icon_found.dart';
import 'package:finniu/presentation/screens/new_simulator/widgets/investment_amount_card.dart';
import 'package:finniu/presentation/screens/new_simulator/widgets/investment_ends.dart';
import 'package:finniu/presentation/screens/new_simulator/widgets/selected_back_transfer.dart';
import 'package:finniu/presentation/screens/new_simulator/widgets/selected_bank_deposit.dart';
import 'package:finniu/presentation/screens/new_simulator/widgets/term_profitability_row.dart';
import 'package:finniu/presentation/screens/new_simulator/widgets/title_simulator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class V2SummaryScreen extends HookConsumerWidget {
  const V2SummaryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(settingsNotifierProvider).isDarkMode;
    const int columnColorDark = 0xff0E0E0E;
    const int columnColorLight = 0xffF8F8F8;

    return Scaffold(
      backgroundColor: isDarkMode
          ? const Color(columnColorDark)
          : const Color(columnColorLight),
      appBar: const AppBarBusinessScreen(),
      bottomNavigationBar: const NavigationBarHome(),
      body: const SingleChildScrollView(
        child: _BodyScaffold(),
      ),
    );
  }
}

class _BodyScaffold extends ConsumerWidget {
  const _BodyScaffold();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final String uuid = ModalRoute.of(context)!.settings.arguments as String;
    final isDarkMode = ref.watch(settingsNotifierProvider).isDarkMode;
    const int columnColorDark = 0xff0E0E0E;
    const int columnColorLight = 0xffF8F8F8;
    final investmentDetailByUuid =
        ref.watch(userInvestmentByUuidFutureProvider(uuid));

    return investmentDetailByUuid.when(
      data: (data) {
        if (data == null) {
          return const Center(child: CircularProgressIndicator());
        }
        return Container(
          color: isDarkMode
              ? const Color(columnColorDark)
              : const Color(columnColorLight),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const TitleModal(),
                const SizedBox(height: 10),
                const IconFund(),
                const SizedBox(height: 15),
                InvestmentAmountCardsRow(
                  amountInvested: data.amount,
                  finalProfitability: data.amount + data.rentabilityAmount,
                ),
                const SizedBox(height: 15),
                const RowButtons(
                  voucher: "",
                  contract: "",
                ),
                const SizedBox(height: 15),
                TermProfitabilityRow(
                  month: null,
                  rentabilityPercent: data.rentabilityPercent,
                ),
                const SizedBox(height: 15),
                data.bankAccountSender != null
                    ? SelectedBankTransfer(
                        bankAccountSender: data.bankAccountSender!,
                      )
                    : const SizedBox(),
                const SizedBox(height: 15),
                data.bankAccountReceiver != null
                    ? SelectedBankDeposit(
                        bankAccountSender: data.bankAccountReceiver!,
                      )
                    : const SizedBox(),
                const SizedBox(height: 15),
                const SeeInterestPayment(),
                const SizedBox(height: 15),
                InvestmentEnds(
                  finalDate: data.finishDateInvestment,
                ),
              ],
            ),
          ),
        );
      },
      error: (error, stack) {
        return const Center(child: Text("Error loading data"));
      },
      loading: () {
        return Container(
          color: isDarkMode
              ? const Color(columnColorDark)
              : const Color(columnColorLight),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const TitleModal(),
                const SizedBox(height: 10),
                const IconFund(),
                const SizedBox(height: 15),
                const InvestmentAmountCardsRow(
                  amountInvested: 5000,
                  finalProfitability: 5000,
                ),
                const SizedBox(height: 15),
                const RowButtons(
                  voucher: "",
                  contract: "",
                ),
                const SizedBox(height: 15),
                const TermProfitabilityRow(
                  month: null,
                  rentabilityPercent: null,
                ),
                const SizedBox(height: 15),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 145,
                  child: const Center(child: CircularProgressIndicator()),
                ),
                const SizedBox(height: 15),
                const SeeInterestPayment(),
                const SizedBox(height: 15),
                const InvestmentEnds(
                  finalDate: null,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class SeeInterestPayment extends StatelessWidget {
  const SeeInterestPayment({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const ButtonsSimulator(
      text: 'Ver tabla de los pagos de intereses',
      icon: "square_half.svg",
      onPressed: null,
    );
  }
}

class RowButtons extends ConsumerWidget {
  const RowButtons({
    super.key,
    required this.voucher,
    required this.contract,
  });
  final String? voucher;
  final String? contract;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    void voucherOnPress() {
      print(voucher);
    }

    void downloadOnPress() {
      print(voucher);
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: 130,
          child: ButtonsSimulator(
            text: 'Ver voucher',
            icon: "eye.svg",
            onPressed: voucherOnPress,
          ),
        ),
        SizedBox(
          width: 170,
          child: ButtonsSimulator(
            text: 'Descargar contrato',
            icon: "download.svg",
            onPressed: downloadOnPress,
          ),
        ),
      ],
    );
  }
}

class ButtonsSimulator extends ConsumerWidget {
  const ButtonsSimulator({
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
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        height: 40,
        decoration: BoxDecoration(
          color: Color(isDarkMode ? backgroundColorDark : backgroundColorLight),
          borderRadius: BorderRadius.circular(8),
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
            SvgPicture.asset(
              'assets/svg_icons/$icon',
              width: 20,
              height: 20,
              color: Color(isDarkMode ? contentColorDark : contentColorLight),
            ),
            const SizedBox(width: 10),
            TextPoppins(
              text: text,
              fontSize: 14,
              textDark: contentColorDark,
              textLight: contentColorLight,
            ),
          ],
        ),
      ),
    );
  }
}
