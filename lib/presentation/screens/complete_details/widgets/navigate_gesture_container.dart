import 'dart:ui';

import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:finniu/presentation/screens/catalog/widgets/text_poppins.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class NavigateGestureContainer extends ConsumerWidget {
  const NavigateGestureContainer({
    super.key,
    required this.svgUrl,
    required this.textBody,
    this.onTap,
  });
  final String svgUrl;
  final String textBody;
  final VoidCallback? onTap;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(settingsNotifierProvider).isDarkMode;
    const int backgroundDark = 0xff2F2F2F;
    const int backgroundLight = 0xffEAFAFF;
    const int svgIconDark = 0xffA2E6FA;
    const int svgIconLight = 0xff000000;
    const int textDark = 0xffFFFFFF;
    const int textLight = 0xff0D3A5C;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: Color(isDarkMode ? backgroundDark : backgroundLight),
          borderRadius: const BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        width: MediaQuery.of(context).size.width,
        height: 67,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SvgPicture.asset(
              svgUrl,
              width: 27,
              height: 27,
              color: Color(isDarkMode ? svgIconDark : svgIconLight),
            ),
            SizedBox(
              width: 193,
              child: TextPoppins(
                text: textBody,
                fontSize: 15,
                isBold: true,
                lines: 2,
                textDark: textDark,
                textLight: textLight,
              ),
            ),
            Center(
              child: Icon(
                Icons.arrow_forward_ios,
                size: 24,
                color:
                    isDarkMode ? const Color(textDark) : const Color(textLight),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
