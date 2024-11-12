import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:finniu/presentation/screens/catalog/widgets/text_poppins.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class HeaderContainer extends ConsumerWidget {
  const HeaderContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(settingsNotifierProvider).isDarkMode;
    const int lineDark = 0xff4579E3;
    const int lineLight = 0xff3295FF;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const RoundedImage(),
        Container(
          width: 140,
          height: 5,
          decoration: BoxDecoration(
            color: Color(isDarkMode ? lineDark : lineLight),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ],
    );
  }
}

class RoundedImage extends ConsumerWidget {
  const RoundedImage({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(settingsNotifierProvider).isDarkMode;
    const int textContainerDark = 0xff2F5EBE;
    const int textContainerLight = 0xff94C7FF;
    const int imageContainerDark = 0xff4579E3;
    const int imageContainerLight = 0xffB0D5FF;
    const int textDark = 0xffFFFFFF;
    const int textLight = 0xff0D3A5C;
    return Stack(
      alignment: Alignment.centerLeft,
      children: [
        Container(
          width: 150,
          height: 30,
          padding: const EdgeInsets.only(right: 10),
          alignment: Alignment.centerRight,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Color(isDarkMode ? textContainerDark : textContainerLight),
          ),
          child: const TextPoppins(
            text: "Invierte   ",
            fontSize: 16,
            fontWeight: FontWeight.w500,
            textDark: textDark,
            textLight: textLight,
          ),
        ),
        Positioned(
          child: Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color:
                  Color(isDarkMode ? imageContainerDark : imageContainerLight),
              borderRadius: BorderRadius.circular(100),
            ),
            child: Image.asset(
              'assets/investment/real_estate_agro_icon.png',
            ),
          ),
        ),
      ],
    );
  }
}
