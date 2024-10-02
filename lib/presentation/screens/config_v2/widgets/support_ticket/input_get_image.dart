import 'package:finniu/presentation/providers/add_voucher_provider.dart';
import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:finniu/presentation/screens/catalog/helpers/add_image.dart';
import 'package:finniu/presentation/screens/catalog/widgets/text_poppins.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class InputGetImage extends ConsumerWidget {
  const InputGetImage({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(settingsNotifierProvider).isDarkMode;
    final imageBase64 = ref.watch(imageBase64Provider);
    const int borderColorDark = 0xFF292828;
    const int borderColorLight = 0xFFD9D9D9;
    const int textColor = 0xFFB3B3B3;
    const int textImageColor = 0xFF828282;
    const int iconColor = 0xFF757575;
    return GestureDetector(
      onTap: () {
        addImage(context: context, ref: ref);
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            width: MediaQuery.of(context).size.width * 0.8,
            height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: isDarkMode
                    ? const Color(borderColorDark)
                    : const Color(borderColorLight),
                width: 1,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: TextPoppins(
                    text: imageBase64 == "" || imageBase64 == null
                        ? "Sube una imagen (Png,Jpd,SVG)"
                        : imageBase64,
                    fontSize: 12,
                    textDark: textColor,
                    textLight: textColor,
                  ),
                ),
                SvgPicture.asset(
                  "assets/svg_icons/add_image_icon.svg",
                  width: 24,
                  height: 24,
                  color: const Color(iconColor),
                ),
              ],
            ),
          ),
          const TextPoppins(
            text: "Max (800 x400px)",
            fontSize: 12,
            textDark: textImageColor,
            textLight: textImageColor,
          ),
        ],
      ),
    );
  }
}
