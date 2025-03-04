import 'dart:async';
import 'package:finniu/constants/colors/product_v4_colors.dart';
import 'package:finniu/constants/number_format.dart';
import 'package:finniu/domain/entities/fund_entity.dart';
import 'package:finniu/domain/entities/pre_re_invest.dart';
import 'package:finniu/domain/entities/re_investment_entity.dart';
import 'package:finniu/presentation/providers/money_provider.dart';
import 'package:finniu/presentation/providers/pre_re_invest.dart';
import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:finniu/presentation/screens/catalog/circular_loader.dart';
import 'package:finniu/presentation/screens/catalog/widgets/animated_number.dart';
import 'package:finniu/presentation/screens/catalog/widgets/send_proof_button.dart';
import 'package:finniu/presentation/screens/catalog/widgets/text_poppins.dart';
import 'package:finniu/presentation/screens/catalog/widgets/user_profil_v2/scafold_user_profile.dart';
import 'package:finniu/presentation/screens/home_v4/money_withdrawal/widget/modal_reasons.dart';
import 'package:finniu/presentation/screens/investment_status/widgets/reinvestment_question_modal.dart';
import 'package:finniu/presentation/screens/on_boarding_v2/widgets/page_select.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class MoneyWithdrawalScreen extends StatelessWidget {
  const MoneyWithdrawalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: AppBarNull(),
      body: SingleChildScrollView(
        child: MoneyProvider(),
      ),
    );
  }
}

class MoneyProvider extends ConsumerWidget {
  const MoneyProvider({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final args = ModalRoute.of(context)?.settings.arguments;

    if (args == null) {
      return const Center(child: Text('No hay argumentos'));
    }

    final Map<String, dynamic> argsMap = args as Map<String, dynamic>;
    final String preInvestmentUUID = argsMap['preInvestmentUUID'] as String;
    final FundEntity product = argsMap['product'] as FundEntity;
    return FutureBuilder(
      future: ref.watch(getPreReInvestFutureProvider(preInvestmentUUID).future),
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
          return MoneyBody(uuid: preInvestmentUUID, data: snapshot.data!, fund: product);
        } else {
          return const Center(child: Text('No data available'));
        }
      },
    );
  }
}

class MoneyBody extends HookConsumerWidget {
  const MoneyBody({
    super.key,
    required this.uuid,
    required this.data,
    required this.fund,
  });
  final String uuid;
  final FundEntity fund;
  final PreReInvest data;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.read(settingsNotifierProvider).isDarkMode;
    final isSoles = ref.read(isSolesStateProvider);
    final index = useState(0);
    void navigateToReinvest() async {
      reinvestmentQuestionModal(
        context,
        ref,
        uuid,
        0,
        isSoles ? currencyEnum.PEN : currencyEnum.USD,
        fund,
        true,
      );
    }

    final PageController controller = usePageController(
      initialPage: 0,
    );
    // ignore: unused_local_variable
    Timer? timer;

    final List<Widget> pages = [
      PageOneMoney(
        isDarkMode: isDarkMode,
      ),
      PageTwoMoney(
        isDarkMode: isDarkMode,
        isSoles: isSoles,
        amount: data.initialAmount.toString(),
        rent: data.futureRentabilityAmount.toString(),
      ),
      PageThreeMoney(
        isDarkMode: isDarkMode,
        isSoles: isSoles,
        amountFuture: data.initialAmount.toString(),
        deadlineString: data.deadlineString.toString(),
      ),
      PageFourMoney(
        isDarkMode: isDarkMode,
      ),
    ];
    useEffect(
      () {
        timer = Timer.periodic(const Duration(seconds: 6), (Timer timer) {
          if (index.value < pages.length - 1) {
            index.value++;
          } else {
            timer.cancel();
          }
          controller.animateToPage(
            index.value,
            duration: const Duration(milliseconds: 800),
            curve: Curves.easeInOut,
          );
        });
        return () => timer?.cancel();
      },
      [],
    );

    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height - 60,
      child: Stack(
        alignment: Alignment.center,
        children: [
          PageView.builder(
            onPageChanged: (value) {
              index.value = value;
            },
            controller: controller,
            itemBuilder: (context, index) => pages[index],
            itemCount: pages.length,
          ),
          Positioned(
            bottom: 50,
            child: Column(
              children: [
                PageSelectMoney(
                  isDarkMode: isDarkMode,
                  index: index.value,
                ),
                const SizedBox(height: 20),
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

class PageSelectMoney extends ConsumerWidget {
  const PageSelectMoney({
    super.key,
    required this.isDarkMode,
    required this.index,
  });
  final int index;
  final bool isDarkMode;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.6,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ItemSelect(
            isSelected: index == 0,
            isDarkMode: isDarkMode,
          ),
          ItemSelect(
            isSelected: index == 1,
            isDarkMode: isDarkMode,
          ),
          ItemSelect(
            isSelected: index == 2,
            isDarkMode: isDarkMode,
          ),
          ItemSelect(
            isSelected: index == 3,
            isDarkMode: isDarkMode,
          ),
        ],
      ),
    );
  }
}

class PageFourMoney extends StatelessWidget {
  const PageFourMoney({
    super.key,
    required this.isDarkMode,
  });
  final bool isDarkMode;
  @override
  Widget build(BuildContext context) {
    const String icons = "👇🏻💸";
    const int titleDark = 0xffA2E6FA;
    const int titleLight = 0xff0D3A5C;
    const int subTitleDark = 0xffFFFFFF;
    const int subTitleLight = 0xff000000;
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.85,
          child: Text.rich(
            textAlign: TextAlign.center,
            TextSpan(
              style: TextStyle(
                fontFamily: "Poppins",
                fontSize: 20,
                color: isDarkMode ? const Color(titleDark) : const Color(titleLight),
                fontWeight: FontWeight.w500,
                decoration: TextDecoration.none,
              ),
              children: <TextSpan>[
                const TextSpan(
                  text: "¡Dale a tu inversión la oportunidad de ",
                ),
                TextSpan(
                  text: "llegar más lejos!",
                  style: TextStyle(
                    color: isDarkMode ? const Color(titleDark) : const Color(titleLight),
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 10),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.85,
          child: Text.rich(
            textAlign: TextAlign.center,
            TextSpan(
              style: TextStyle(
                fontFamily: "Poppins",
                fontSize: 16,
                color: isDarkMode ? const Color(subTitleDark) : const Color(subTitleLight),
                fontWeight: FontWeight.w400,
                decoration: TextDecoration.none,
              ),
              children: <TextSpan>[
                const TextSpan(
                  text: "¡",
                ),
                TextSpan(
                  text: "Reinvierte hoy mismo ",
                  style: TextStyle(
                    color: isDarkMode ? const Color(subTitleDark) : const Color(subTitleLight),
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const TextSpan(
                  text: "y sigue avanzando hacia tus ",
                ),
                TextSpan(
                  text: "metas financieras!",
                  style: TextStyle(
                    color: isDarkMode ? const Color(subTitleDark) : const Color(subTitleLight),
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 10),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.7,
          child: const TextPoppins(
            text: icons,
            fontSize: 32,
            align: TextAlign.center,
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.3,
        ),
      ],
    );
  }
}

class PageThreeMoney extends StatelessWidget {
  const PageThreeMoney({
    super.key,
    required this.isDarkMode,
    required this.isSoles,
    required this.amountFuture,
    required this.deadlineString,
  });
  final bool isDarkMode;
  final bool isSoles;
  final String amountFuture;
  final String deadlineString;
  @override
  Widget build(BuildContext context) {
    const int amountContainerDark = 0xff0D3A5C;
    const int amountContainerLight = 0xffD9F7FF;
    const int amountDark = 0xffFFFFFF;
    const int amountLight = 0xff0D3A5C;
    const int titleDark = 0xffA2E6FA;
    const int titleLight = 0xff0D3A5C;
    const int subTitleDark = 0xffFFFFFF;
    const int subTitleLight = 0xff000000;
    final int amountParsed = convertStringToInt(amountFuture);

    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.85,
          child: Text.rich(
            textAlign: TextAlign.center,
            TextSpan(
              style: TextStyle(
                fontFamily: "Poppins",
                fontSize: 20,
                color: isDarkMode ? const Color(titleDark) : const Color(titleLight),
                fontWeight: FontWeight.w500,
                decoration: TextDecoration.none,
              ),
              children: <TextSpan>[
                const TextSpan(
                  text: "Si decides ",
                ),
                TextSpan(
                  text: "reinvertir ",
                  style: TextStyle(
                    color: isDarkMode ? const Color(titleDark) : const Color(titleLight),
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const TextSpan(
                  text: "este año",
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 10),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.85,
          child: Text.rich(
            textAlign: TextAlign.center,
            TextSpan(
              style: TextStyle(
                fontFamily: "Poppins",
                fontSize: 16,
                color: isDarkMode ? const Color(subTitleDark) : const Color(subTitleLight),
                fontWeight: FontWeight.w500,
                decoration: TextDecoration.none,
              ),
              children: <TextSpan>[
                const TextSpan(
                  text: "No solo conservarás tus ganancias, sino que ",
                ),
                TextSpan(
                  text: "podrías ganar hasta",
                  style: TextStyle(
                    color: isDarkMode ? const Color(titleDark) : const Color(titleLight),
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
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
                    color: isDarkMode ? const Color(amountContainerDark) : const Color(amountContainerLight),
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
          child: Text.rich(
            textAlign: TextAlign.center,
            TextSpan(
              style: TextStyle(
                fontFamily: "Poppins",
                fontSize: 16,
                color: isDarkMode ? const Color(subTitleDark) : const Color(subTitleLight),
                fontWeight: FontWeight.w500,
                decoration: TextDecoration.none,
              ),
              children: <TextSpan>[
                const TextSpan(
                  text: "más en los próximos ",
                ),
                TextSpan(
                  text: "$deadlineString.",
                  style: TextStyle(
                    color: isDarkMode ? const Color(subTitleDark) : const Color(subTitleLight),
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const TextSpan(
                  text: "🗓",
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.3,
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
    const int textColor = 0xff000000;
    const int tanksColor = 0xffA2E6FA;

    final int amountParsed = convertStringToInt(amount);
    final int rentParsed = convertStringToInt(rent);
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          width: MediaQuery.of(context).size.width * 0.85,
          height: 130,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: isDarkMode ? const Color(amountContainerDark) : const Color(amountContainerLight),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset(
                "assets/svg_icons/dolar_money_icon.svg",
                width: 35,
                height: 35,
                color: isDarkMode ? const Color(amountDark) : const Color(amountLight),
              ),
              const TextPoppins(
                text: "Hace un año invertiste",
                fontSize: 14,
                textDark: textColor,
                textLight: textColor,
              ),
              amountParsed == 0
                  ? TextPoppins(
                      text: formatNumberNotComa(isSoles: isSoles, number: amount),
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
        const SizedBox(height: 10),
        Container(
          width: MediaQuery.of(context).size.width * 0.85,
          height: 130,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: isDarkMode ? const Color(rentContainerDark) : const Color(rentContainerLight),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset(
                "assets/svg_icons/status_up_icon_draft.svg",
                width: 35,
                height: 35,
                color: isDarkMode ? const Color(rentIconDark) : const Color(rentIconLight),
              ),
              const TextPoppins(
                text: "con nosotros ya has ganado",
                fontSize: 14,
                textDark: textColor,
                textLight: textColor,
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
            textDark: tanksColor,
            textLight: amountLight,
            align: TextAlign.center,
            lines: 2,
          ),
        ),
        const TextPoppins(
          text: "pero....",
          fontSize: 16,
          fontWeight: FontWeight.w500,
          textLight: amountLight,
          align: TextAlign.center,
          lines: 2,
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.30,
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
    const int titleDark = 0xffFFFFFF;
    const int titleLight = 0xff0D3A5C;
    const int colorDark = 0xffA2E6FA;
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset("assets/home_v4/money_image.png", width: 170, height: 120),
        const SizedBox(height: 15),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.85,
          child: Text.rich(
            textAlign: TextAlign.center,
            TextSpan(
              style: TextStyle(
                fontFamily: "Poppins",
                fontSize: 16,
                color: isDarkMode ? const Color(titleDark) : const Color(titleLight),
                fontWeight: FontWeight.w500,
                decoration: TextDecoration.none,
              ),
              children: <TextSpan>[
                const TextSpan(
                  text: "¿Sabías que al ",
                ),
                TextSpan(
                  text: "quedarte ",
                  style: TextStyle(
                    color: isDarkMode ? const Color(colorDark) : const Color(titleLight),
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const TextSpan(
                  text: "con nosotros podrías ",
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                TextSpan(
                  text: "duplicar tus ganancias",
                  style: TextStyle(
                    color: isDarkMode ? const Color(colorDark) : const Color(titleLight),
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const TextSpan(
                  text: "?",
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 15),
        const TextPoppins(
          text: "Descubre como",
          fontSize: 16,
          align: TextAlign.center,
        ),
        Image.asset(
          "assets/home_v4/arrow_image_${isDarkMode ? "dark" : "light"}.png",
          width: 200,
          height: 120,
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.25,
        ),
      ],
    );
  }
}
