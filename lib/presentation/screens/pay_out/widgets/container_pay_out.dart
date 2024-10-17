import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:finniu/presentation/screens/catalog/widgets/text_poppins.dart';
import 'package:finniu/presentation/screens/scan_document_v2/widgets/custom_border_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ContainerPayOutInProgress extends ConsumerWidget {
  const ContainerPayOutInProgress({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(settingsNotifierProvider).isDarkMode;
    const int backgroundDark = 0xff03253E;
    const int backgroundLight = 0xffE9FAFF;
    const int textColor = 0xffA2E6FA;
    const int iconColor = 0xff03253E;
    const int borderColorDark = 0xffA2E6FA;
    const int borderColorLight = 0xff4C8DBE;

    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      height: 255,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: isDarkMode
            ? const Color(backgroundDark)
            : const Color(backgroundLight),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 120,
            height: 28,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: const Color(textColor),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  "assets/svg_icons/clock_icon.svg",
                  color: const Color(iconColor),
                ),
                const SizedBox(
                  width: 5,
                ),
                const TextPoppins(
                  text: "En proceso",
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  textDark: iconColor,
                ),
              ],
            ),
          ),
          const Row(
            children: [
              TextPoppins(
                text: "Enviamos ",
                fontSize: 10,
                fontWeight: FontWeight.w400,
              ),
              TextPoppins(
                text: "S/860.50",
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ],
          ),
          const TextPoppins(
            text:
                "En breve te llegará la transferencia al siguiente destino que registraste en el proceso de inversión",
            fontSize: 10,
            lines: 3,
          ),
          CustomBorderContainer(
            height: 78,
            isDarkMode: false,
            borderColorDark: borderColorDark,
            borderColorLight: borderColorLight,
            child: SizedBox(
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Row(
                      children: [
                        const TextPoppins(
                          text: "Cuenta bancaria",
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        SvgPicture.asset(
                          "assets/svg_icons/credit-card.svg",
                          width: 15,
                          height: 15,
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 24,
                          height: 24,
                          child: ClipOval(
                            child: Image.asset(
                              "assets/images/bank_example.png",
                              width: 24,
                              height: 24,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        const TextPoppins(
                          text: "Cuenta soles | 122009301103",
                          fontSize: 10,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ContainerPayOutFilled extends ConsumerWidget {
  const ContainerPayOutFilled({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(settingsNotifierProvider).isDarkMode;
    const int backgroundDark = 0xffD8FFCD;
    const int backgroundLight = 0xffF5FFF3;
    const int textColor = 0xffA9F196;
    const int iconColor = 0xff000000;
    const int borderColorDark = 0xff008D34;
    const int borderColorLight = 0xff4C8DBE;

    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      height: 255,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: isDarkMode
            ? const Color(backgroundDark)
            : const Color(backgroundLight),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 120,
            height: 28,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: const Color(textColor),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  "assets/svg_icons/clock_icon.svg",
                  color: const Color(iconColor),
                ),
                const SizedBox(
                  width: 5,
                ),
                const TextPoppins(
                  text: "En proceso",
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  textDark: iconColor,
                ),
              ],
            ),
          ),
          const Row(
            children: [
              TextPoppins(
                text: "Enviamos ",
                fontSize: 10,
                fontWeight: FontWeight.w400,
              ),
              TextPoppins(
                text: "S/860.50",
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ],
          ),
          const TextPoppins(
            text:
                "En breve te llegará la transferencia al siguiente destino que registraste en el proceso de inversión",
            fontSize: 10,
            lines: 3,
          ),
          CustomBorderContainer(
            height: 78,
            isDarkMode: false,
            borderColorDark: borderColorDark,
            borderColorLight: borderColorLight,
            child: SizedBox(
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Row(
                      children: [
                        const TextPoppins(
                          text: "Cuenta bancaria",
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        SvgPicture.asset(
                          "assets/svg_icons/credit-card.svg",
                          width: 15,
                          height: 15,
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 24,
                          height: 24,
                          child: ClipOval(
                            child: Image.asset(
                              "assets/images/bank_example.png",
                              width: 24,
                              height: 24,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        const TextPoppins(
                          text: "Cuenta soles | 122009301103",
                          fontSize: 10,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ContainerPayOutInvalid extends ConsumerWidget {
  const ContainerPayOutInvalid({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(settingsNotifierProvider).isDarkMode;
    const int backgroundDark = 0xffFFCAC7;
    const int backgroundLight = 0xffFFEAE9;
    const int textColor = 0xffFF3B30;
    const int iconColor = 0xff000000;
    const int borderColorDark = 0xff008D34;
    const int borderColorLight = 0xff4C8DBE;

    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      height: 255,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: isDarkMode
            ? const Color(backgroundDark)
            : const Color(backgroundLight),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 120,
            height: 28,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: const Color(textColor),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  "assets/svg_icons/clock_icon.svg",
                  color: const Color(iconColor),
                ),
                const SizedBox(
                  width: 5,
                ),
                const TextPoppins(
                  text: "En proceso",
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  textDark: iconColor,
                ),
              ],
            ),
          ),
          const Row(
            children: [
              TextPoppins(
                text: "Enviamos ",
                fontSize: 10,
                fontWeight: FontWeight.w400,
              ),
              TextPoppins(
                text: "S/860.50",
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ],
          ),
          const TextPoppins(
            text:
                "En breve te llegará la transferencia al siguiente destino que registraste en el proceso de inversión",
            fontSize: 10,
            lines: 3,
          ),
          CustomBorderContainer(
            height: 78,
            isDarkMode: false,
            borderColorDark: borderColorDark,
            borderColorLight: borderColorLight,
            child: SizedBox(
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Row(
                      children: [
                        const TextPoppins(
                          text: "Cuenta bancaria",
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        SvgPicture.asset(
                          "assets/svg_icons/credit-card.svg",
                          width: 15,
                          height: 15,
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 24,
                          height: 24,
                          child: ClipOval(
                            child: Image.asset(
                              "assets/images/bank_example.png",
                              width: 24,
                              height: 24,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        const TextPoppins(
                          text: "Cuenta soles | 122009301103",
                          fontSize: 10,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
