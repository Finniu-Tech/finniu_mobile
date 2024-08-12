import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:finniu/presentation/screens/catalog/widgets/text_poppins.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void showDraftModal(BuildContext context) {
  final bool isReinvest = false;
  showModalBottomSheet(
    context: context,
    builder: (context) => _DraftBody(
      isReinvest: isReinvest,
    ),
  );
}

class _DraftBody extends ConsumerWidget {
  const _DraftBody({
    required this.isReinvest,
  });
  final bool isReinvest;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    String title = isReinvest ? "¡Hola!👋🏼" : "¡Hola!👋🏼";
    String subTitle = isReinvest
        ? "Parece que dejaste tu reinversión a medias."
        : "Parece que dejaste tu inversión a medias.";
    String bodyText = isReinvest
        ? "¡Completa el proceso de reinversión aquí y empieza a ver los resultados!"
        : "¡Completa el proceso de inversión aquí y empieza a ver los resultados!";
    String bodyTwoText = isReinvest
        ? "Si necesitas ayuda, estamos aquí para ti. 🚀"
        : "Si necesitas ayuda, estamos aquí para ti. 🚀";
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 610,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 25),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextPoppins(
              text: title,
              fontSize: 20,
              isBold: true,
            ),
            const SizedBox(
              height: 10,
            ),
            TextPoppins(
              text: subTitle,
              fontSize: 20,
              isBold: true,
              lines: 2,
            ),
            const SizedBox(
              height: 10,
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
            const SizedBox(
              height: 15,
            ),
            const RowIconStatus(),
            const SizedBox(
              height: 10,
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
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        IconStatus(
          isSelect: true,
          iconSvg: "assets/svg_icons/money_icon_draft.svg",
        ),
        IconStatus(
          isSelect: true,
          iconSvg: "assets/svg_icons/card_send_icon_draft.svg",
        ),
        IconStatus(
          isSelect: true,
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
