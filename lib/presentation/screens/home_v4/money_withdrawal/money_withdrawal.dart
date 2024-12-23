import 'package:finniu/domain/entities/fund_entity.dart';
import 'package:finniu/presentation/providers/money_provider.dart';
import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:finniu/presentation/screens/catalog/widgets/animated_number.dart';
import 'package:finniu/presentation/screens/catalog/widgets/send_proof_button.dart';
import 'package:finniu/presentation/screens/catalog/widgets/text_poppins.dart';
import 'package:finniu/presentation/screens/catalog/widgets/user_profil_v2/scafold_user_profile.dart';
import 'package:finniu/presentation/screens/home_v4/money_withdrawal/widget/modal_reasons.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

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
    const int titleDark = 0xffFFFFFF;
    const int titleLight = 0xff0D3A5C;
    const int amountDark = 0xffA2E6FA;
    const int amountLight = 0xff0D3A5C;

    const String title =
        "¿Sabías que al quedarte con nosotros podrías duplicar tus ganancias?";
    const String timeInvest = "Hace un año invertiste ";

    final int amountNum = args.amount;
    const int rentNum = 200;
    const int reInvestRentNum = 400;

    void navigateToReinvest() async {
      Navigator.pushNamedAndRemoveUntil(
        context,
        '/v4/re_invest_step_one',
        arguments: args.uuid,
        (route) => false,
      );
    }

    return Center(
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.85,
        height: MediaQuery.of(context).size.height > 650
            ? MediaQuery.of(context).size.height - 100
            : 620,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Spacer(),
            const TextPoppins(
              text: title,
              fontSize: 18,
              fontWeight: FontWeight.w600,
              align: TextAlign.center,
              lines: 3,
              textDark: titleDark,
              textLight: titleLight,
            ),
            const SizedBox(height: 5),
            const TextPoppins(
              text: timeInvest,
              fontSize: 14,
              align: TextAlign.center,
              lines: 2,
            ),
            const SizedBox(height: 5),
            AnimationNumberNotComma(
              endNumber: amountNum,
              fontSize: 32,
              duration: 1,
              colorText: isDarkMode ? amountDark : amountLight,
              beginNumber: 0,
              isSoles: isSoles,
            ),
            const SizedBox(height: 5),
            const TextPoppins(
              text: "con nosotros y ya has ganado",
              fontSize: 14,
              align: TextAlign.center,
              lines: 2,
            ),
            const SizedBox(height: 5),
            AnimationNumberNotComma(
              endNumber: rentNum,
              fontSize: 32,
              duration: 1,
              colorText: isDarkMode ? amountDark : amountLight,
              beginNumber: 0,
              isSoles: isSoles,
            ),
            const SizedBox(height: 5),
            const TextPoppins(
              text: "¡Felicidades por tomar esa gran decisión!",
              fontSize: 16,
              fontWeight: FontWeight.w600,
              align: TextAlign.center,
              lines: 2,
            ),
            const SizedBox(height: 5),
            const TextPoppins(
              text:
                  "Si decides reinvertir este año, no solo conservarás tus ganancias, sino que podrías ganar hasta",
              fontSize: 14,
              align: TextAlign.center,
              lines: 3,
            ),
            const SizedBox(height: 5),
            AnimationNumberNotComma(
              endNumber: reInvestRentNum,
              fontSize: 32,
              duration: 1,
              colorText: isDarkMode ? amountDark : amountLight,
              beginNumber: 0,
              isSoles: isSoles,
            ),
            const SizedBox(height: 5),
            const TextPoppins(
              text: "más en los próximos 12 meses.",
              fontSize: 14,
              align: TextAlign.center,
              lines: 3,
            ),
            const TextPoppins(
              text:
                  "Dale a tu inversión la oportunidad de llegar más lejos. ¡Reinvierte hoy mismo y sigue avanzando hacia tus metas financieras!”",
              fontSize: 14,
              align: TextAlign.center,
              lines: 3,
            ),
            const Spacer(),
            ButtonInvestment(
              text: "Quiero reinvertir",
              onPressed: navigateToReinvest,
            ),
            const SizedBox(height: 10),
            ButtonInvestmentBorder(
              text: "Solicitar mi retiro",
              onPressed: () => showModalReasons(context, isDarkMode, args.uuid),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
