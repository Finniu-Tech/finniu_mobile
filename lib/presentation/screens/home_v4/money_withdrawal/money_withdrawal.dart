import 'package:finniu/constants/number_format.dart';
import 'package:finniu/domain/entities/pre_re_invest.dart';
import 'package:finniu/presentation/providers/money_provider.dart';
import 'package:finniu/presentation/providers/pre_re_invest.dart';
import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:finniu/presentation/screens/catalog/circular_loader.dart';
import 'package:finniu/presentation/screens/catalog/widgets/animated_number.dart';
import 'package:finniu/presentation/screens/catalog/widgets/send_proof_button.dart';
import 'package:finniu/presentation/screens/catalog/widgets/text_poppins.dart';
import 'package:finniu/presentation/screens/catalog/widgets/user_profil_v2/scafold_user_profile.dart';
import 'package:finniu/presentation/screens/home_v4/money_withdrawal/widget/modal_reasons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
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
    final isSoles = ref.read(isSolesStateProvider);
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
      PageTwoMoney(
        isDarkMode: isDarkMode,
        isSoles: isSoles,
        amount: data.initialAmount.toString(),
        rent: data.rentabilityAmount.toString(),
      ),
      PageThreeMoney(
        isDarkMode: isDarkMode,
        isSoles: isSoles,
        amountFuture: data.initialAmount.toString(),
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

class PageThreeMoney extends StatelessWidget {
  const PageThreeMoney({
    super.key,
    required this.isDarkMode,
    required this.isSoles,
    required this.amountFuture,
  });
  final bool isDarkMode;
  final bool isSoles;
  final String amountFuture;
  @override
  Widget build(BuildContext context) {
    const String title = "Si decides reinvertir este año";
    const String subTitle =
        "No solo conservarás tus ganancias, sino que podrías ganar hasta";
    const String timeText = "más en los próximos 12 meses.🗓️";
    const int amountContainerDark = 0xff0D3A5C;
    const int amountContainerLight = 0xffD9F7FF;
    const int amountDark = 0xffFFFFFF;
    const int amountLight = 0xff0D3A5C;
    final int amountParsed = convertStringToInt(amountFuture);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.85,
          child: const TextPoppins(
            text: title,
            fontSize: 20,
            align: TextAlign.center,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 10),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.85,
          child: const TextPoppins(
            text: subTitle,
            fontSize: 16,
            align: TextAlign.center,
            lines: 2,
          ),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.85,
          height: 160,
          child: Stack(
            children: [
              Center(
                child: Container(
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width * 0.65,
                  height: 91,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: isDarkMode
                        ? const Color(amountContainerDark)
                        : const Color(amountContainerLight),
                  ),
                  child: amountParsed == 0
                      ? TextPoppins(
                          text: formatNumberNotComa(
                            isSoles: isSoles,
                            number: amountFuture,
                          ),
                          fontSize: 36,
                          textDark: amountDark,
                          textLight: amountLight,
                        )
                      : AnimationNumberNotComma(
                          endNumber: amountParsed,
                          fontSize: 36,
                          duration: 1,
                          isSoles: isSoles,
                          beginNumber: 0,
                          colorText: isDarkMode ? amountDark : amountLight,
                        ),
                ),
              ),
              Positioned(
                top: 0,
                left: 0,
                child: Image.asset(
                  "assets/home_v4/cash_image.png",
                  width: 100,
                  height: 100,
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.85,
          child: const TextPoppins(
            text: timeText,
            fontSize: 14,
            align: TextAlign.center,
          ),
        ),
      ],
    );
  }
}

class PageTwoMoney extends StatelessWidget {
  const PageTwoMoney({
    super.key,
    required this.isDarkMode,
    required this.isSoles,
    required this.amount,
    required this.rent,
  });
  final bool isDarkMode;
  final bool isSoles;
  final String amount;
  final String rent;
  @override
  Widget build(BuildContext context) {
    const int amountContainerDark = 0xffA2E6FA;
    const int amountContainerLight = 0xffD9F7FF;
    const int amountDark = 0xff0D3A5C;
    const int amountLight = 0xff0D3A5C;
    const int rentContainerDark = 0xffB5FF8A;
    const int rentContainerLight = 0xffD6FFBF;
    const int rentDark = 0xff0D3A5C;
    const int rentLight = 0xff0D3A5C;
    const int rentIconDark = 0xff55B63D;
    const int rentIconLight = 0xff55B63D;

    final int amountParsed = convertStringToInt(amount);
    final int rentParsed = convertStringToInt(rent);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: MediaQuery.of(context).size.width * 0.85,
          height: 146,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: isDarkMode
                ? const Color(amountContainerDark)
                : const Color(amountContainerLight),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset(
                "assets/svg_icons/dolar_money_icon.svg",
                width: 35,
                height: 35,
                color: isDarkMode
                    ? const Color(amountDark)
                    : const Color(amountLight),
              ),
              const TextPoppins(
                text: "Hace un año invertiste",
                fontSize: 14,
              ),
              amountParsed == 0
                  ? TextPoppins(
                      text:
                          formatNumberNotComa(isSoles: isSoles, number: amount),
                      fontSize: 36,
                      textDark: amountDark,
                      textLight: amountLight,
                    )
                  : AnimationNumberNotComma(
                      endNumber: amountParsed,
                      fontSize: 36,
                      duration: 1,
                      isSoles: isSoles,
                      beginNumber: 0,
                      colorText: isDarkMode ? amountDark : amountLight,
                    ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        Container(
          width: MediaQuery.of(context).size.width * 0.85,
          height: 146,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: isDarkMode
                ? const Color(rentContainerDark)
                : const Color(rentContainerLight),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset(
                "assets/svg_icons/status_up_icon_draft.svg",
                width: 35,
                height: 35,
                color: isDarkMode
                    ? const Color(rentIconDark)
                    : const Color(rentIconLight),
              ),
              const TextPoppins(
                text: "con nosotros y ya has ganado",
                fontSize: 14,
              ),
              rentParsed == 0
                  ? TextPoppins(
                      text: formatNumberNotComa(isSoles: isSoles, number: rent),
                      fontSize: 36,
                      textDark: amountDark,
                      textLight: amountLight,
                    )
                  : AnimationNumberNotComma(
                      endNumber: rentParsed,
                      fontSize: 36,
                      duration: 1,
                      isSoles: isSoles,
                      beginNumber: 0,
                      colorText: isDarkMode ? rentDark : rentLight,
                    ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.85,
          child: const TextPoppins(
            text: "¡Felicidades por tomar esa gran decisión!",
            fontSize: 20,
            fontWeight: FontWeight.w600,
            textDark: amountDark,
            textLight: amountLight,
            align: TextAlign.center,
            lines: 2,
          ),
        ),
        const SizedBox(height: 10),
        const TextPoppins(
          text: "pero....",
          fontSize: 16,
          fontWeight: FontWeight.w500,
          textDark: amountDark,
          textLight: amountLight,
          align: TextAlign.center,
          lines: 2,
        ),
      ],
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
