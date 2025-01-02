import 'package:finniu/constants/number_format.dart';
import 'package:finniu/presentation/screens/catalog/widgets/text_poppins.dart';
import 'package:flutter/material.dart';

class FinalAmountContainer extends StatelessWidget {
  const FinalAmountContainer({
    super.key,
    required this.finalAmount,
    required this.isDarkMode,
    required this.isSoles,
  });
  final bool isSoles;
  final double finalAmount;
  final bool isDarkMode;

  @override
  Widget build(BuildContext context) {
    const int containerDark = 0xff0D3A5C;
    const int containerLight = 0xffC7F3FF;
    const int iconDark = 0xffA2E6FA;
    const int iconLight = 0xff0D3A5C;
    const int textDark = 0xffFFFFFF;
    const int textLight = 0xff0D3A5C;
    return Container(
      width: MediaQuery.of(context).size.width * 0.85,
      height: 60,
      decoration: BoxDecoration(
        color: isDarkMode
            ? const Color(containerDark)
            : const Color(containerLight),
        borderRadius: const BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        children: [
          Column(
            children: [
              const SizedBox(
                height: 5,
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Icon(
                  Icons.monetization_on_outlined,
                  size: 14,
                  color: isDarkMode
                      ? const Color(iconDark)
                      : const Color(iconLight),
                ),
              ),
            ],
          ),
          const SizedBox(width: 5),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const TextPoppins(
                text: "Monto final",
                fontSize: 12,
                fontWeight: FontWeight.w600,
                textDark: textDark,
                textLight: textLight,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.45,
                child: const TextPoppins(
                  text: "(Capital en curso)",
                  fontSize: 3,
                  textDark: textDark,
                  textLight: textLight,
                ),
              ),
            ],
          ),
          const Spacer(),
          TextPoppins(
            text: isSoles
                ? formatterSolesNotComma.format(finalAmount)
                : formatterUSDNotComma.format(finalAmount),
            fontSize: 14,
            fontWeight: FontWeight.w600,
            textDark: textDark,
            textLight: textLight,
          ),
        ],
      ),
    );
  }
}
