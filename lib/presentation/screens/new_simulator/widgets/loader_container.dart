import 'package:finniu/presentation/screens/home_v4/detail_invest_v4/detail_invest_v4.dart';
import 'package:finniu/presentation/screens/new_simulator/v2_summary_screen.dart';
import 'package:finniu/presentation/screens/catalog/circular_loader.dart';
import 'package:finniu/presentation/screens/new_simulator/widgets/icon_found.dart';
import 'package:finniu/presentation/screens/new_simulator/widgets/investment_amount_card.dart';
import 'package:finniu/presentation/screens/new_simulator/widgets/investment_ends.dart';
import 'package:finniu/presentation/screens/new_simulator/widgets/term_profitability_row.dart';
import 'package:flutter/material.dart';

class LoaderContainer extends StatelessWidget {
  const LoaderContainer({
    super.key,
    required this.isDarkMode,
    required this.columnColorDark,
    required this.columnColorLight,
    required this.status,
  });

  final bool isDarkMode;
  final int columnColorDark;
  final int columnColorLight;
  final String status;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: isDarkMode ? Color(columnColorDark) : Color(columnColorLight),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TitleModalV4(
              status: status,
            ),
            const SizedBox(height: 10),
            const IconFund(),
            const SizedBox(height: 15),
            const InvestmentAmountCardsRow(
              amountInvested: 10000,
              finalProfitability: 10000,
              isLoading: true,
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
              isLoader: true,
            ),
            const SizedBox(height: 15),
            const Center(
              child: CircularLoader(
                width: 140,
                height: 140,
              ),
            ),
            const SizedBox(height: 15),
            const SizedBox(height: 15),
            const InvestmentEnds(
              finalDate: null,
            ),
          ],
        ),
      ),
    );
  }
}
