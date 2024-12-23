import 'package:finniu/domain/entities/pre_re_invest.dart';
import 'package:finniu/presentation/providers/pre_re_invest.dart';
import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:finniu/presentation/screens/catalog/circular_loader.dart';
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
    final uuid = ModalRoute.of(context)!.settings.arguments as String;
    return Scaffold(
      appBar: const AppBarNull(),
      body: SingleChildScrollView(
        child: MoneyProvider(uuid: uuid),
      ),
    );
  }
}

class MoneyProvider extends ConsumerWidget {
  const MoneyProvider({
    super.key,
    required this.uuid,
  });

  final String uuid;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final args = ModalRoute.of(context)?.settings.arguments as String;
    print(args);
    return FutureBuilder(
      future: ref.watch(getPreReInvestFutureProvider(args).future),
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
          return MoneyBody(uuid: uuid, data: snapshot.data!);
        } else {
          return const Center(child: Text('No data available'));
        }
      },
    );
  }
}

class MoneyBody extends ConsumerWidget {
  const MoneyBody({
    super.key,
    required this.uuid,
    required this.data,
  });
  final String uuid;
  final PreReInvest data;
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

    final List<Widget> pages = [
      PageOneMoney(
        isDarkMode: isDarkMode,
      ),
      Container(
        width: MediaQuery.of(context).size.width,
        color: const Color(0xffA2E6FA),
      ),
      Container(
        width: MediaQuery.of(context).size.width,
        color: const Color(0xff0D3A5C),
      ),
      Container(
        width: MediaQuery.of(context).size.width,
        color: const Color(0xffA2E6FA),
      ),
    ];

    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height - 80,
      child: Stack(
        alignment: Alignment.center,
        children: [
          PageView.builder(
            itemBuilder: (context, index) => pages[index],
            itemCount: pages.length,
          ),
          Positioned(
            bottom: 20,
            child: Column(
              children: [
                ButtonInvestment(
                  text: "Quiero reinvertir",
                  onPressed: navigateToReinvest,
                ),
                const SizedBox(height: 10),
                ButtonInvestmentBorder(
                  text: "Solicitar mi retiro",
                  onPressed: () => showModalReasons(context, isDarkMode, uuid),
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class PageOneMoney extends StatelessWidget {
  const PageOneMoney({
    super.key,
    required this.isDarkMode,
  });
  final bool isDarkMode;
  @override
  Widget build(BuildContext context) {
    const String title =
        "¿Sabías que al quedarte con nosotros podrías duplicar tus ganancias?";
    const int titleDark = 0xffFFFFFF;
    const int titleLight = 0xff0D3A5C;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset("assets/home_v4/money_image.png", width: 170, height: 120),
        const SizedBox(height: 15),
        const TextPoppins(
          text: title,
          fontSize: 20,
          fontWeight: FontWeight.w700,
          textDark: titleDark,
          textLight: titleLight,
          lines: 3,
          align: TextAlign.center,
        ),
        const SizedBox(height: 15),
        const TextPoppins(
          text: "Descubre como",
          fontSize: 16,
          align: TextAlign.center,
        ),
        Image.asset("assets/home_v4/arrow_image.png", width: 200, height: 120),
      ],
    );
  }
}
