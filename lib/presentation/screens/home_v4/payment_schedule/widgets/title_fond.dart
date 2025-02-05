import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:finniu/presentation/screens/catalog/widgets/text_poppins.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class TitleFund extends ConsumerWidget {
  const TitleFund({
    super.key,
    required this.fundName,
  });
  final String fundName;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(settingsNotifierProvider).isDarkMode;
    const int iconBankDark = 0xff08273F;
    const int iconBankLight = 0xffBEF0FF;
    final String icon = fundName == "Fondo inversiones empresariales" ? "🏢" : "🏡";
    final String title = fundName;
    const int titleBankDark = 0xff0D3A5C;
    const int titleBankLight = 0xffECFBFF;
    const int titleDark = 0xffFFFFFF;
    const int titleLight = 0xff0D3A5C;

    return Stack(
      alignment: Alignment.centerLeft,
      children: [
        Container(
          constraints: const BoxConstraints(maxWidth: 280),
          width: MediaQuery.of(context).size.width * 0.7,
          height: 30,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(30)),
            color: isDarkMode ? const Color(titleBankDark) : const Color(titleBankLight),
          ),
          child: Row(
            children: [
              const SizedBox(
                width: 50,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.5,
                child: TextPoppins(
                  text: title,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  textDark: titleDark,
                  textLight: titleLight,
                ),
              ),
            ],
          ),
        ),
        Container(
          width: 40,
          height: 40,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isDarkMode ? const Color(iconBankDark) : const Color(iconBankLight),
          ),
          child: TextPoppins(
            text: icon,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
