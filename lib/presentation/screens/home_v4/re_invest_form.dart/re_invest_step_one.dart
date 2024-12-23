import 'package:finniu/constants/colors/product_v4_colors.dart';
import 'package:finniu/presentation/providers/get_fund_investment.dart';
import 'package:finniu/presentation/screens/catalog/circular_loader.dart';
import 'package:finniu/presentation/screens/catalog/widgets/text_poppins.dart';
import 'package:finniu/presentation/screens/investment_process.dart/widget_v2/fund_row_step.dart';
import 'package:finniu/presentation/screens/investment_process.dart/widgets/step_scaffolf.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ReInvestStepOneV4 extends StatelessWidget {
  const ReInvestStepOneV4({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const StepScaffold(
      useDefaultLoading: true,
      children: ReInvestProvider(),
    );
  }
}

class ReInvestProvider extends ConsumerWidget {
  const ReInvestProvider({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final args = ModalRoute.of(context)?.settings.arguments as String;

    return FutureBuilder(
      future: ref.watch(getInvestFutureProviderV4(args).future),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularLoader(
              width: 50,
              height: 50,
            ),
          );
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (snapshot.hasData) {
          return ReInvestBody(
            investStyles: productFixedTerm,
          );
        } else {
          return const Center(child: Text('No data available'));
        }
      },
    );
  }
}

class ReInvestBody extends StatelessWidget {
  const ReInvestBody({
    super.key,
    required this.investStyles,
  });
  final ProductContainerStyles investStyles;
  @override
  Widget build(BuildContext context) {
    final invest = productFixedTerm;
    return Center(
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.85,
        height: MediaQuery.of(context).size.height < 700
            ? 650
            : MediaQuery.of(context).size.height - 85,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            FundRowStep(
              icon: invest.imageProduct,
            ),
            const SizedBox(height: 14),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.7,
              child: TextPoppins(
                text: invest.titleText,
                fontSize: 20,
                fontWeight: FontWeight.w600,
                lines: 2,
                align: TextAlign.start,
                textDark: invest.titleDark,
                textLight: invest.titleLight,
              ),
            ),
            const SizedBox(height: 10),
            const TextPoppins(
              text: "Completa los siguientes datos",
              fontSize: 14,
              fontWeight: FontWeight.w500,
              align: TextAlign.start,
            ),
          ],
        ),
      ),
    );
  }
}
