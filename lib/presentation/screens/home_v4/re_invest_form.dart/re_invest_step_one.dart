import 'package:finniu/constants/colors/product_v4_colors.dart';
import 'package:finniu/domain/entities/re_invest_dto.dart';
import 'package:finniu/presentation/providers/get_fund_investment.dart';
import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:finniu/presentation/screens/catalog/circular_loader.dart';
import 'package:finniu/presentation/screens/catalog/widgets/text_poppins.dart';
import 'package:finniu/presentation/screens/home_v4/re_invest_form.dart/widgets/amount_reinvest.dart';
import 'package:finniu/presentation/screens/home_v4/re_invest_form.dart/widgets/form_reinvest.dart';
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
    final isDarkMode = ref.read(settingsNotifierProvider).isDarkMode;
    print(args);
    return FutureBuilder(
      future: ref.watch(getInvestFutureProviderV4(args).future),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return SizedBox(
            height: MediaQuery.of(context).size.height - 85,
            width: MediaQuery.of(context).size.width,
            child: const Center(
              child: CircularLoader(
                width: 50,
                height: 50,
              ),
            ),
          );
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (snapshot.hasData) {
          final data = snapshot.data!;

          return ReInvestBody(
            data: data,
            isDarkMode: isDarkMode,
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
    required this.data,
    required this.isDarkMode,
  });
  final bool isDarkMode;
  final ReInvestDtoV4 data;
  @override
  Widget build(BuildContext context) {
    final invest = data.fundName == "Fondo inversiones empresariales"
        ? productFixedTerm
        : productRealEstate;
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
            const SizedBox(height: 10),
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
            AmountReinvest(
              amountReinvest: data.amount,
              currency: data.currency,
              isDarkMode: isDarkMode,
              deadline: data.deadline,
              rentabilityPercent: data.rentabilityPercent,
            ),
            const SizedBox(height: 10),
            TextPoppins(
              text: "Completa los siguientes datos",
              fontSize: 14,
              fontWeight: FontWeight.w500,
              align: TextAlign.start,
              textDark: invest.titleDark,
              textLight: invest.titleLight,
            ),
            FormStepOneReinvest(
              product: invest,
              data: data,
              isDarkMode: isDarkMode,
              isSoles: data.currency == "NUEVO_SOL",
            ),
          ],
        ),
      ),
    );
  }
}
