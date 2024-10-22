import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:finniu/presentation/screens/catalog/widgets/text_poppins.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class BankTranferContainer extends ConsumerWidget {
  const BankTranferContainer({super.key, required this.title});
  final String title;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(settingsNotifierProvider).isDarkMode;
    const int containerDark = 0xff212121;
    const int containerLight = 0xffBCF0FF;
    const int iconBackground = 0xff95E7FF;
    const int icon = 0xff0D3A5C;
    const int iconDark = 0xffFFFFFF;
    const int iconLight = 0xff0D3A5C;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      width: MediaQuery.of(context).size.width,
      height: 38,
      decoration: BoxDecoration(
        color: isDarkMode
            ? const Color(containerDark)
            : const Color(containerLight),
        borderRadius: BorderRadius.circular(50),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                width: 30,
                height: 30,
                decoration: const BoxDecoration(
                  color: Color(iconBackground),
                  borderRadius: BorderRadius.all(
                    Radius.circular(50),
                  ),
                ),
                child: const Icon(
                  Icons.add_card_outlined,
                  size: 20,
                  color: Color(icon),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              TextPoppins(
                text: title,
                fontSize: 11,
              ),
            ],
          ),
          Icon(
            Icons.arrow_forward_outlined,
            size: 24,
            color: isDarkMode ? const Color(iconDark) : const Color(iconLight),
          ),
        ],
      ),
    );
  }
}
