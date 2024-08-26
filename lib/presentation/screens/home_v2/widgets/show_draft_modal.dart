import 'package:finniu/domain/entities/fund_entity.dart';
import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:finniu/presentation/screens/catalog/widgets/text_poppins.dart';
import 'package:finniu/presentation/screens/home_v2/widgets/slider_draft_modal.dart';
import 'package:finniu/presentation/screens/investment_status/widgets/reinvestment_question_modal.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

void showDraftModal(
  BuildContext context, {
  required bool isReinvest,
  required int profitability,
  required int termMonth,
  required String uuid,
  required bool moneyIcon,
  required bool cardSend,
  required bool statusUp,
  required int amountNumber,

  required String currency,
  required FundEntity fund,

}) {
  showModalBottomSheet(
    scrollControlDisabledMaxHeightRatio: 1,
    context: context,
    builder: (context) => _DraftBody(
      isReinvest: isReinvest,
      profitability: profitability,
      termMonth: termMonth,
      uuid: uuid,
      moneyIcon: moneyIcon,
      cardSend: cardSend,
      statusUp: statusUp,
      amountNumber: amountNumber,
      currency: currency,
      fund: fund,
    ),
  );
}

class _DraftBody extends ConsumerWidget {
  const _DraftBody({
    required this.isReinvest,
    required this.profitability,
    required this.termMonth,
    required this.uuid,
    required this.moneyIcon,
    required this.cardSend,
    required this.statusUp,
    required this.amountNumber,
    required this.currency,
    required this.fund,
  });
  final bool isReinvest;
  final int profitability;
  final int termMonth;
  final int amountNumber;
  final String uuid;
  final bool moneyIcon;
  final bool cardSend;
  final bool statusUp;
  final String currency;
  final FundEntity fund;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    void navigate() {
      //pop the actual modal
      Navigator.pop(context);
      Navigator.pushNamed(
        context,
        '/v2/investment/step-2',
        arguments: {
          'fund': fund,
          'preInvestmentUUID': uuid,
          'amount': amountNumber.toString(),
        },
      );
      // if (isReinvest) {
      //   print("navegar a reinversion $uuid");

      //   reinvestmentQuestionModal(
      //       context, ref, uuid, amountNumber.toDouble(), currency, true, fund, profitability, termMonth);
      // } else {
      //   // todo draft investment
      //   print("navegar a inversion $uuid");
      //   reinvestmentQuestionModal(
      //       context, ref, uuid, amountNumber.toDouble(), currency, true, fund, profitability, termMonth);
      // }
    }

    void contact() async {
      var whatsappNumber = "51940206852";
      var whatsappMessage = "Hola";
      var whatsappUrlAndroid = Uri.parse(
        "whatsapp://send?phone=$whatsappNumber&text=${Uri.parse(whatsappMessage)}",
      );
      var whatsappUrlIphone = Uri.parse("https://wa.me/$whatsappNumber?text=$whatsappMessage");

      if (defaultTargetPlatform == TargetPlatform.android) {
        await launchUrl(whatsappUrlAndroid);
      } else {
        await launchUrl(whatsappUrlIphone);
      }
    }

    String title = isReinvest ? "¡Hola!👋🏼" : "¡Hola!👋🏼";
    String subTitle =
        isReinvest ? "Parece que dejaste tu reinversión a medias." : "Parece que dejaste tu inversión a medias.";
    String bodyText = isReinvest
        ? "¡Completa el proceso de reinversión aquí y empieza a ver los resultados!"
        : "¡Completa el proceso de inversión aquí y empieza a ver los resultados!";
    String bodyTwoText =
        isReinvest ? "Si necesitas ayuda, estamos aquí para ti. 🚀" : "Si necesitas ayuda, estamos aquí para ti. 🚀";
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 580,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 25),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextPoppins(
              text: title,
              fontSize: 20,
              isBold: true,
            ),
            TextPoppins(
              text: subTitle,
              fontSize: 20,
              isBold: true,
              lines: 2,
            ),
            TextPoppins(
              text: bodyText,
              fontSize: 14,
              lines: 2,
            ),
            TextPoppins(
              text: bodyTwoText,
              fontSize: 14,
              lines: 2,
            ),
            RowIconStatus(
              cardSend: cardSend,
              moneyIcon: moneyIcon,
              statusUp: statusUp,
            ),
            SliderDraftModal(
              amountNumber: amountNumber,
              isReinvest: isReinvest,
              profitability: profitability,
              termMonth: termMonth,
            ),
            ButtonGoInvest(
              isReinvest: isReinvest,
              navigate: () => navigate(),
            ),
            ContactAdvisor(
              contact: () => contact(),
            ),
          ],
        ),
      ),
    );
  }
}

class ContactAdvisor extends ConsumerWidget {
  const ContactAdvisor({
    super.key,
    required this.contact,
  });
  final VoidCallback? contact;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(settingsNotifierProvider).isDarkMode;
    const int dividerDark = 0xffA2E6FA;
    const int dividerLight = 0xff0D3A5C;
    const int iconBackgroundDark = 0xff2B2B2B;
    const int iconBackgroundLight = 0xffEFEFEF;

    return GestureDetector(
      onTap: contact,
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Row(
          children: [
            Expanded(
              child: Divider(
                thickness: 2,
                color: isDarkMode ? const Color(dividerDark) : const Color(dividerLight),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            SizedBox(
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: isDarkMode ? const Color(iconBackgroundDark) : const Color(iconBackgroundLight),
                    ),
                    child: SvgPicture.asset(
                      "assets/svg_icons/chat_icon_draft.svg",
                      width: 24,
                      height: 24,
                      color: isDarkMode ? const Color(dividerDark) : const Color(dividerLight),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  const TextPoppins(
                    text: "Contactar con el asesor",
                    fontSize: 14,
                  ),
                ],
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: Divider(
                thickness: 2,
                color: isDarkMode ? const Color(dividerDark) : const Color(dividerLight),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ButtonGoInvest extends ConsumerWidget {
  const ButtonGoInvest({
    super.key,
    required this.isReinvest,
    required this.navigate,
  });
  final bool isReinvest;
  final VoidCallback navigate;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const String textInvest = "Retomar mi proceso de inversión";
    const String textReinvest = "Retomar mi proceso de reinversión";

    final isDarkMode = ref.watch(settingsNotifierProvider).isDarkMode;
    const int backgroundColorDark = 0xffA2E6FA;
    const int backgroundColorLight = 0xff0D3A5C;
    const int textDark = 0xff000000;
    const int textLight = 0xffFFFFFF;
    const int iconDark = 0xff08273F;
    const int iconLight = 0xffA2E6FA;
    return GestureDetector(
      onTap: navigate,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        width: MediaQuery.of(context).size.width,
        height: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color: isDarkMode ? const Color(backgroundColorDark) : const Color(backgroundColorLight),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            TextPoppins(
              text: isReinvest ? textReinvest : textInvest,
              fontSize: 14,
              isBold: true,
              textDark: textDark,
              textLight: textLight,
            ),
            Icon(
              Icons.arrow_forward_outlined,
              color: isDarkMode ? const Color(iconDark) : const Color(iconLight),
            ),
          ],
        ),
      ),
    );
  }
}

class RowIconStatus extends ConsumerWidget {
  const RowIconStatus({
    super.key,
    required this.moneyIcon,
    required this.cardSend,
    required this.statusUp,
  });
  final bool moneyIcon;
  final bool cardSend;
  final bool statusUp;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        IconStatus(
          isSelect: moneyIcon,
          iconSvg: "assets/svg_icons/money_icon_draft.svg",
        ),
        IconStatus(
          isSelect: cardSend,
          iconSvg: "assets/svg_icons/card_send_icon_draft.svg",
        ),
        IconStatus(
          isSelect: statusUp,
          iconSvg: "assets/svg_icons/status_up_icon_draft.svg",
        ),
      ],
    );
  }
}

class IconStatus extends ConsumerWidget {
  const IconStatus({
    super.key,
    required this.isSelect,
    required this.iconSvg,
  });
  final bool isSelect;
  final String iconSvg;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(settingsNotifierProvider).isDarkMode;
    const int backgroundIconSelectDark = 0xffA2E6FA;
    const int backgroundIconSelectLight = 0xffA2E6FA;
    const int backgroundIconNotSelectDark = 0xff2B2B2B;
    const int backgroundIconNotSelectLight = 0xffF5F4F4;

    const int lineSelectDark = 0xffA2E6FA;
    const int lineSelectLight = 0xff0D3A5C;
    const int lineNotSelectDark = 0xff2B2B2B;
    const int lineNotSelectLight = 0xffF5F4F4;

    const int iconSelectDark = 0xff0D3A5C;
    const int iconSelectLight = 0xff0D3A5C;
    const int iconNotSelectDark = 0xff989898;
    const int iconNotSelectLight = 0xffB3B3B3;
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: isSelect
                ? isDarkMode
                    ? const Color(backgroundIconSelectDark)
                    : const Color(backgroundIconSelectLight)
                : isDarkMode
                    ? const Color(backgroundIconNotSelectDark)
                    : const Color(backgroundIconNotSelectLight),
          ),
          width: 40,
          height: 40,
          child: SvgPicture.asset(
            iconSvg,
            width: 20,
            height: 20,
            color: isSelect
                ? isDarkMode
                    ? const Color(iconSelectDark)
                    : const Color(iconSelectLight)
                : isDarkMode
                    ? const Color(iconNotSelectDark)
                    : const Color(iconNotSelectLight),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: isSelect
                ? isDarkMode
                    ? const Color(lineSelectDark)
                    : const Color(lineSelectLight)
                : isDarkMode
                    ? const Color(lineNotSelectDark)
                    : const Color(lineNotSelectLight),
          ),
          width: 40,
          height: 5,
        ),
      ],
    );
  }
}
