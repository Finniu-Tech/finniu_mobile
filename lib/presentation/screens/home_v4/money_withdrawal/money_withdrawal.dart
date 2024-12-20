import 'package:finniu/constants/number_format.dart';
import 'package:finniu/domain/entities/fund_entity.dart';
import 'package:finniu/domain/entities/re_investment_entity.dart';
import 'package:finniu/presentation/providers/get_fund_investment.dart';
import 'package:finniu/presentation/providers/money_provider.dart';
import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:finniu/presentation/screens/catalog/widgets/send_proof_button.dart';
import 'package:finniu/presentation/screens/catalog/widgets/text_poppins.dart';
import 'package:finniu/presentation/screens/catalog/widgets/user_profil_v2/scafold_user_profile.dart';
import 'package:finniu/presentation/screens/home_v4/money_withdrawal/widget/modal_reasons.dart';
import 'package:finniu/presentation/screens/investment_status/widgets/reinvestment_question_modal.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:loader_overlay/loader_overlay.dart';

class NavigateToMoney {
  final String uuid;
  final FundEntity? fund;
  final int amount;
  NavigateToMoney({
    required this.uuid,
    required this.fund,
    required this.amount,
  });
}

class MoneyWithdrawalScreen extends StatelessWidget {
  const MoneyWithdrawalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final NavigateToMoney args =
        ModalRoute.of(context)!.settings.arguments as NavigateToMoney;
    return Scaffold(
      appBar: const AppBarNull(),
      body: SingleChildScrollView(
        child: MoneyBody(
          args: args,
        ),
      ),
    );
  }
}

class MoneyBody extends ConsumerWidget {
  const MoneyBody({
    super.key,
    required this.args,
  });
  final NavigateToMoney args;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.read(settingsNotifierProvider).isDarkMode;
    final isSoles = ref.read(isSolesStateProvider);
    const String title = "¡Gracias por depositar tu confianza en Finniu!";
    const String subTitle =
        "Si reinviertes, tu inversión crecerá en 1 año a este monto 👇🏻";
    final String amount = isSoles
        ? formatterSolesNotComma.format(args.amount * 1.20)
        : formatterUSDNotComma.format(args.amount * 1.20);
    const int titleDark = 0xffFFFFFF;
    const int titleLight = 0xff0D3A5C;
    const int amountDark = 0xffA2E6FA;
    const int amountLight = 0xff0D3A5C;

    void navigateToReinvest() async {
      context.loaderOverlay.show();
      final dtoReinvest =
          await ref.read(getInvestFutureProvider(args.uuid).future);

      context.loaderOverlay.hide();

      reinvestmentQuestionModal(
        context,
        ref,
        args.uuid,
        args.amount.toDouble(),
        isSoles ? currencyEnum.PEN : currencyEnum.USD,
        true,
        dtoReinvest?.fund,
        dtoReinvest?.rentabilityPercent,
        dtoReinvest?.deadline,
      );
    }

    return Center(
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.85,
        height: MediaQuery.of(context).size.height - 100,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Spacer(),
            const TextPoppins(
              text: title,
              fontSize: 20,
              fontWeight: FontWeight.w600,
              align: TextAlign.center,
              lines: 2,
              textDark: titleDark,
              textLight: titleLight,
            ),
            const SizedBox(height: 10),
            const TextPoppins(
              text: subTitle,
              fontSize: 16,
              align: TextAlign.center,
              lines: 2,
            ),
            const SizedBox(height: 10),
            TextPoppins(
              text: amount,
              fontSize: 40,
              fontWeight: FontWeight.w600,
              align: TextAlign.center,
              textDark: amountDark,
              textLight: amountLight,
            ),
            const Spacer(),
            ButtonInvestment(
              text: "Quiero reinvertir",
              onPressed: navigateToReinvest,
            ),
            const SizedBox(height: 10),
            ButtonInvestmentBorder(
              text: "Solicitar mi retiro",
              onPressed: () => showModalReasons(context, isDarkMode),
            ),
          ],
        ),
      ),
    );
  }
}
