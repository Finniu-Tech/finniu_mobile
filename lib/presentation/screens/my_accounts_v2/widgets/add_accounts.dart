import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:finniu/presentation/screens/catalog/widgets/text_poppins.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AddAccounts extends ConsumerWidget {
  const AddAccounts({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(settingsNotifierProvider).isDarkMode;

    const int backgroundDark = 0xffA2E6FA;
    const int backgroundLight = 0xffE2F8FF;
    const int iconColor = 0xff0D3A5C;

    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      height: 60,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        color: isDarkMode
            ? const Color(backgroundDark)
            : const Color(backgroundLight),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 70,
            child: Center(
              child: SvgPicture.asset(
                "assets/svg_icons/card_add_icon.svg",
                width: 30,
                height: 30,
                color: const Color(iconColor),
              ),
            ),
          ),
          const TextPoppins(
            text: "Agregar cuenta bancaria",
            fontSize: 15,
            isBold: true,
          ),
        ],
      ),
    );
  }
}
