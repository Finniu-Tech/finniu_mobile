import 'package:finniu/presentation/screens/new_simulator/v2_summary_screen.dart';
import 'package:finniu/presentation/screens/new_simulator/widgets/circular_loader.dart';
import 'package:finniu/presentation/screens/new_simulator/widgets/icon_found.dart';
import 'package:finniu/presentation/screens/new_simulator/widgets/investment_amount_card.dart';
import 'package:finniu/presentation/screens/new_simulator/widgets/investment_ends.dart';
import 'package:finniu/presentation/screens/new_simulator/widgets/term_profitability_row.dart';
import 'package:finniu/presentation/screens/new_simulator/widgets/title_simulator.dart';
import 'package:flutter/material.dart';

class LoaderContainer extends StatelessWidget {
  const LoaderContainer({
    super.key,
    required this.isDarkMode,
    required this.columnColorDark,
    required this.columnColorLight,
  });

  final bool isDarkMode;
  final int columnColorDark;
  final int columnColorLight;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: isDarkMode ? Color(columnColorDark) : Color(columnColorLight),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: const Padding(
        padding: EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TitleModal(),
            SizedBox(height: 10),
            IconFund(),
            SizedBox(height: 15),
            InvestmentAmountCardsRow(
              amountInvested: 10000,
              finalProfitability: 10000,
              isLoading: true,
            ),
            SizedBox(height: 15),
            RowButtons(
              voucher: "",
              contract: "",
            ),
            SizedBox(height: 15),
            TermProfitabilityRow(
              month: null,
              rentabilityPercent: null,
              isLoader: true,
            ),
            SizedBox(height: 15),
            Center(
              child: CircularLoader(
                width: 140,
                height: 140,
              ),
            ),
            SizedBox(height: 15),
            SeeInterestPayment(
              list: [],
            ),
            SizedBox(height: 15),
            InvestmentEnds(
              finalDate: null,
            ),
          ],
        ),
      ),
    );
  }
}
