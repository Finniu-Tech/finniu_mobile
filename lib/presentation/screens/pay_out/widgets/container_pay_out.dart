import 'package:finniu/presentation/screens/catalog/widgets/text_poppins.dart';
import 'package:finniu/presentation/screens/scan_document_v2/widgets/custom_border_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ContainerPayOut extends StatelessWidget {
  const ContainerPayOut({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    const int backgroundColor = 0xffE9FAFF;
    const int textColor = 0xffA2E6FA;
    const int borderColorDark = 0xff4C8DBE;
    const int borderColorLight = 0xff4C8DBE;
    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      height: 255,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(backgroundColor),
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
                ),
                const SizedBox(
                  width: 5,
                ),
                const TextPoppins(
                  text: "En proceso",
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
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
