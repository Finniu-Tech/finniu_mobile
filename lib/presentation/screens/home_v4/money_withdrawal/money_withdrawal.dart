import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:finniu/presentation/screens/catalog/widgets/send_proof_button.dart';
import 'package:finniu/presentation/screens/catalog/widgets/user_profil_v2/scafold_user_profile.dart';
import 'package:finniu/presentation/screens/home_v4/money_withdrawal/widget/modal_reasons.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class MoneyWithdrawalScreen extends StatelessWidget {
  const MoneyWithdrawalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final uuid = ModalRoute.of(context)!.settings.arguments as String;
    return Scaffold(
      appBar: const AppBarNull(),
      body: SingleChildScrollView(
        child: MoneyBody(
          uuid: uuid,
        ),
      ),
    );
  }
}

class MoneyBody extends ConsumerWidget {
  const MoneyBody({
    super.key,
    required this.uuid,
  });
  final String uuid;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.read(settingsNotifierProvider).isDarkMode;
    // final isSoles = ref.read(isSolesStateProvider);
    // const int titleDark = 0xffFFFFFF;
    // const int titleLight = 0xff0D3A5C;
    // const int amountDark = 0xffA2E6FA;
    // const int amountLight = 0xff0D3A5C;

    void navigateToReinvest() async {
      Navigator.pushNamedAndRemoveUntil(
        context,
        '/v4/re_invest_step_one',
        arguments: uuid,
        (route) => false,
      );
    }

    return Center(
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.85,
        height: MediaQuery.of(context).size.height > 650
            ? MediaQuery.of(context).size.height - 100
            : 620,
        child: Stack(
          children: [
            Positioned(
              bottom: 0,
              child: Column(
                children: [
                  ButtonInvestment(
                    text: "Quiero reinvertir",
                    onPressed: navigateToReinvest,
                  ),
                  const SizedBox(height: 10),
                  ButtonInvestmentBorder(
                    text: "Solicitar mi retiro",
                    onPressed: () =>
                        showModalReasons(context, isDarkMode, uuid),
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
