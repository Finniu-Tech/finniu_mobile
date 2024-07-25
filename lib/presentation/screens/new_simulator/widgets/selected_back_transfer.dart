import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:finniu/presentation/screens/catalog/widgets/text_poppins.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SelectedBankTransfer extends ConsumerWidget {
  const SelectedBankTransfer({
    super.key,
    required this.bank,
    required this.bankNumber,
  });
  final String? bank;
  final String? bankNumber;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(settingsNotifierProvider).isDarkMode;
    const int backgroundDark = 0xff2A2929;
    const int backgroundLight = 0xffF1FCFF;
    const int buttonDark = 0xff181818;
    const int buttonLight = 0xffCFF4FF;
    const int iconDark = 0xffA2E6FA;
    const int iconLight = 0xff0D3A5C;
    return Container(
      padding: const EdgeInsets.all(10),
      height: 66,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: isDarkMode
            ? const Color(backgroundDark)
            : const Color(backgroundLight),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Image.asset(
            "assets/images/bankSelectImage.png",
            width: 45,
            height: 45,
          ),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const TextPoppins(
                text: "Banco donde se transfiere",
                fontSize: 14,
              ),
              bank == null
                  ? const TextPoppins(
                      text: "No tiene banco selecionado",
                      fontSize: 14,
                      isBold: true,
                    )
                  : TextPoppins(
                      text: "$bank *************$bankNumber",
                      fontSize: 14,
                      isBold: true,
                    ),
            ],
          ),
          const Expanded(child: SizedBox()),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                padding: const EdgeInsets.all(2),
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                  color: Color(isDarkMode ? buttonDark : buttonLight),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: GestureDetector(
                  onTap: () {},
                  child: SvgPicture.asset(
                    'assets/svg_icons/credit-card.svg',
                    width: 20,
                    height: 20,
                    color: Color(isDarkMode ? iconDark : iconLight),
                  ),
                ),
              ),
              Container(
                width: 20,
                height: 20,
                padding: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                  color: Color(isDarkMode ? buttonDark : buttonLight),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: GestureDetector(
                  onTap: () {},
                  child: SvgPicture.asset(
                    'assets/svg_icons/trash-2.svg',
                    width: 16,
                    height: 16,
                    color: Color(isDarkMode ? iconDark : iconLight),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
