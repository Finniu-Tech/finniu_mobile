import 'package:finniu/presentation/screens/catalog/widgets/text_poppins.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class AmountReinvest extends StatelessWidget {
  const AmountReinvest({
    super.key,
    required this.amountReinvest,
    required this.currency,
    required this.isDarkMode,
    required this.deadline,
    required this.rentabilityPercent,
  });
  final double amountReinvest;
  final String currency;
  final int rentabilityPercent;
  final bool isDarkMode;
  final int deadline;

  @override
  Widget build(BuildContext context) {
    const int containerDark = 0xff1F2020;
    const int containerLight = 0xffF2FCFF;
    const int lineDark = 0xffA8DFEF;
    const int lineLight = 0xffA8DFEF;
    const int rentContainerDark = 0xffB4EEFF;
    const int rentContainerLight = 0xffB4EEFF;
    const int rentDark = 0xff0D3A5C;
    const int rentLight = 0xff0D3A5C;
    const int iconAmountDark = 0xffA2E6FA;
    const int iconAmountLight = 0xff0D3A5C;
    const int textAmountDark = 0xffFFFFFF;
    const int textAmountLight = 0xff0D3A5C;

    return Container(
      width: MediaQuery.of(context).size.width * 0.85,
      height: 75,
      padding: const EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: isDarkMode
            ? const Color(containerDark)
            : const Color(containerLight),
      ),
      child: Row(
        children: [
          Container(
            width: 5,
            height: 50,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              color:
                  isDarkMode ? const Color(lineDark) : const Color(lineLight),
            ),
          ),
          const SizedBox(width: 10),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.monetization_on_outlined,
                    size: 14,
                    color: isDarkMode
                        ? const Color(iconAmountDark)
                        : const Color(iconAmountLight),
                  ),
                  const SizedBox(width: 5),
                  TextPoppins(
                    text:
                        "${currency == "NUEVO_SOL" ? "S/" : "\$"} ${amountReinvest.toString()}",
                    fontSize: 14,
                    textDark: textAmountDark,
                    textLight: textAmountLight,
                    fontWeight: FontWeight.w500,
                  ),
                ],
              ),
              const TextPoppins(
                text: "Capital a reinvertir",
                fontSize: 10,
                textDark: textAmountDark,
                textLight: textAmountLight,
                fontWeight: FontWeight.w500,
              ),
            ],
          ),
          const Spacer(),
          Container(
            width: 100,
            height: 30,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(5)),
              color: isDarkMode
                  ? const Color(rentContainerDark)
                  : const Color(rentContainerLight),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  "assets/svg_icons/convert_icon.svg",
                  width: 14,
                  height: 14,
                  color: isDarkMode
                      ? const Color(rentDark)
                      : const Color(rentLight),
                ),
                const SizedBox(width: 5),
                TextPoppins(
                  text: "$rentabilityPercent%",
                  fontSize: 12,
                  textDark: textAmountDark,
                  textLight: textAmountLight,
                  fontWeight: FontWeight.w500,
                ),
                const TextPoppins(
                  text: " anual",
                  fontSize: 12,
                  textDark: textAmountDark,
                  textLight: textAmountLight,
                  fontWeight: FontWeight.w500,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
