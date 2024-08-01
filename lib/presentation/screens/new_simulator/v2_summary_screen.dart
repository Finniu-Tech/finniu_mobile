import 'package:finniu/infrastructure/models/arguments_navigator.dart';
import 'package:finniu/infrastructure/models/business_investments/investment_detail_by_uuid.dart';
import 'package:finniu/presentation/providers/investment_detail_uuid_provider.dart';
import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:finniu/presentation/screens/business_investments/widgets/app_bar_business.dart';
import 'package:finniu/presentation/screens/catalog/widgets/text_poppins.dart';
import 'package:finniu/presentation/screens/home_v2/widgets/navigation_bar.dart';
import 'package:finniu/presentation/screens/new_simulator/helpers/pdf_launcher.dart';
import 'package:finniu/presentation/screens/new_simulator/widgets/modal/error_modal.dart';
import 'package:finniu/presentation/screens/new_simulator/widgets/icon_found.dart';
import 'package:finniu/presentation/screens/new_simulator/widgets/investment_amount_card.dart';
import 'package:finniu/presentation/screens/new_simulator/widgets/investment_ends.dart';
import 'package:finniu/presentation/screens/new_simulator/widgets/loader_container.dart';
import 'package:finniu/presentation/screens/new_simulator/widgets/selected_back_transfer.dart';
import 'package:finniu/presentation/screens/new_simulator/widgets/selected_bank_deposit.dart';
import 'package:finniu/presentation/screens/new_simulator/widgets/modal/show_table_pay.dart';
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
      backgroundColor: isDarkMode ? const Color(columnColorDark) : const Color(columnColorLight),
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
    final ArgumentsNavigator arguments = ModalRoute.of(context)!.settings.arguments as ArgumentsNavigator;
    final isDarkMode = ref.watch(settingsNotifierProvider).isDarkMode;
    const int columnColorDark = 0xff0E0E0E;
    const int columnColorLight = 0xffF8F8F8;
    final investmentDetailByUuid = ref.watch(userInvestmentByUuidFutureProvider(arguments.uuid));

    final List<ProfitabilityItem> list = [
      ProfitabilityItem(amount: 100, paymentDate: DateTime(2024, 1, 15)),
      ProfitabilityItem(amount: 100, paymentDate: DateTime(2024, 2, 15)),
      ProfitabilityItem(amount: 100, paymentDate: DateTime(2024, 3, 15)),
      ProfitabilityItem(amount: 100, paymentDate: DateTime(2024, 4, 15)),
      ProfitabilityItem(amount: 100, paymentDate: DateTime(2024, 5, 15)),
      ProfitabilityItem(amount: 100, paymentDate: DateTime(2024, 6, 15)),
      ProfitabilityItem(amount: 100, paymentDate: DateTime(2024, 7, 15)),
      ProfitabilityItem(amount: 100, paymentDate: DateTime(2024, 8, 15)),
      ProfitabilityItem(amount: 100, paymentDate: DateTime(2024, 9, 15)),
      ProfitabilityItem(amount: 100, paymentDate: DateTime(2024, 10, 15)),
      ProfitabilityItem(amount: 100, paymentDate: DateTime(2024, 11, 15)),
      ProfitabilityItem(amount: 100, paymentDate: DateTime(2024, 12, 15)),
    ];

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
          color: isDarkMode ? const Color(columnColorDark) : const Color(columnColorLight),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TitleModal(
                  status: arguments.status,
                ),
                const SizedBox(height: 10),
                const IconFund(),
                const SizedBox(height: 15),
                InvestmentAmountCardsRow(
                  amountInvested: data.amount,
                  finalProfitability: data.amount + data.rentabilityAmount,
                  isLoading: false,
                ),
                const SizedBox(height: 15),
                RowButtons(
                  voucher: data.voucher,
                  contract: data.contract,
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
                data.bankAccountReceiver != null ? const SizedBox() : const SizedBox(),
                data.bankAccountReceiver != null
                    ? SelectedBankDeposit(
                        bankAccountReceiver: data.bankAccountReceiver!,
                      )
                    : const SizedBox(),
                const SizedBox(height: 15),
                SeeInterestPayment(),
                const SizedBox(height: 15),
                InvestmentEnds(
                  finalDate: data.finishDateInvestment,
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
    return const ButtonsTable(
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
      if (voucher == null) {
        showNotVoucherOrContract(context, true);
      } else {
        launchPdfURL(voucher!);
      }
    }

    void downloadOnPress() {
      if (contract == null) {
        showNotVoucherOrContract(context, false);
      } else {
        launchPdfURL(contract!);
      }
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: 131,
          child: ButtonsSimulator(
            text: 'Ver voucher',
            icon: "eye.svg",
            onPressed: voucherOnPress,
          ),
        ),
        SizedBox(
          width: 171,
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
        height: 32,
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
              width: 16,
              height: 16,
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

class ButtonsTable extends ConsumerWidget {
  const ButtonsTable({
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
        height: 41,
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
              width: 24,
              height: 24,
              color: Color(isDarkMode ? contentColorDark : contentColorLight),
            ),
            const SizedBox(width: 10),
            TextPoppins(
              text: text,
              fontSize: 15,
              textDark: contentColorDark,
              textLight: contentColorLight,
            ),
          ],
        ),
      ),
    );
  }
}
