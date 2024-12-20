import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:finniu/presentation/screens/catalog/widgets/send_proof_button.dart';
import 'package:finniu/presentation/screens/catalog/widgets/text_poppins.dart';
import 'package:finniu/presentation/screens/catalog/widgets/user_profil_v2/scafold_user_profile.dart';
import 'package:finniu/presentation/screens/home_v4/money_withdrawal/widget/modal_reasons.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class MoneyWithdrawalScreen extends StatelessWidget {
  const MoneyWithdrawalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: AppBarNull(),
      body: SingleChildScrollView(
        child: MoneyBody(),
      ),
    );
  }
}

class MoneyBody extends ConsumerWidget {
  const MoneyBody({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.read(settingsNotifierProvider).isDarkMode;
    const String title = "¡Gracias por depositar tu confianza en Finniu!";
    const String subTitle =
        "Si reinviertes, tu inversión crecerá en 1 año a este monto 👇🏻";
    const String amount = "S/12,400";
    const int titleDark = 0xffFFFFFF;
    const int titleLight = 0xff0D3A5C;
    const int amountDark = 0xffA2E6FA;
    const int amountLight = 0xff0D3A5C;

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
            const TextPoppins(
              text: amount,
              fontSize: 40,
              fontWeight: FontWeight.w600,
              align: TextAlign.center,
              textDark: amountDark,
              textLight: amountLight,
            ),
            const Spacer(),
            ButtonInvestment(text: "Quiero reinvertir", onPressed: () {}),
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
