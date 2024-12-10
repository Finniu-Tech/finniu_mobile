import 'package:finniu/presentation/providers/money_provider.dart';
import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:finniu/presentation/screens/catalog/widgets/text_poppins.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class RentContainer extends ConsumerWidget {
  const RentContainer({
    super.key,
    required this.rent,
    required this.percent,
    required this.dateInfo,
    required this.isRender,
  });
  final String rent;
  final String percent;
  final String dateInfo;
  final bool isRender;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(settingsNotifierProvider).isDarkMode;
    final isSoles = ref.watch(isSolesStateProvider);

    const int backgroundDark = 0xffB5FF8A;
    const int backgroundLight = 0xffD0FFB5;
    const int dateDark = 0xff0D3A5C;
    const int dateLight = 0xff0D3A5C;
    const int percentDark = 0xff109B60;
    const int percentLight = 0xff109B60;
    const int precentContainerDark = 0xffA5FD72;
    const int percentContainerLight = 0xffBDFF97;
    const int textColor = 0xff000000;

    return Container(
      padding: const EdgeInsets.all(10),
      width: MediaQuery.of(context).size.width * 0.9,
      height: isRender ? 100 : 80,
      decoration: BoxDecoration(
        color: isDarkMode
            ? const Color(backgroundDark)
            : const Color(backgroundLight),
        borderRadius: const BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.trending_up_rounded,
                size: 20,
                color: Color(textColor),
              ),
              SizedBox(
                width: 10,
              ),
              TextPoppins(
                text: "Rentabilidad acumulada",
                fontSize: 13,
                fontWeight: FontWeight.w500,
                textDark: textColor,
                textLight: textColor,
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextPoppins(
                text: "+${isSoles ? "S/" : "\$"}$rent ",
                fontSize: 16,
                fontWeight: FontWeight.w600,
                textDark: textColor,
                textLight: textColor,
              ),
              const SizedBox(
                width: 10,
              ),
              Container(
                width: 40,
                height: 20,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: isDarkMode
                      ? const Color(precentContainerDark)
                      : const Color(percentContainerLight),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
                child: TextPoppins(
                  text: percent,
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                  textDark: percentDark,
                  textLight: percentLight,
                ),
              ),
            ],
          ),
          if (isRender)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.timer_sharp,
                  size: 15,
                  color: isDarkMode
                      ? const Color(dateDark)
                      : const Color(dateLight),
                ),
                const SizedBox(
                  width: 5,
                ),
                TextPoppins(
                  text: dateInfo,
                  fontSize: 10,
                  fontWeight: FontWeight.w500,
                  textDark: dateDark,
                  textLight: dateLight,
                ),
              ],
            ),
        ],
      ),
    );
  }
}
