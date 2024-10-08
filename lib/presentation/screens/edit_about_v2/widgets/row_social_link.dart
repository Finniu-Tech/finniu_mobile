import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class RowSocialLink extends ConsumerWidget {
  const RowSocialLink({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(settingsNotifierProvider).isDarkMode;
    const int containerDark = 0xff232323;
    const int containerLight = 0xffF5F5F5;
    const int iconDark = 0xffA2E6FA;
    const int iconLight = 0xff0D3A5C;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.all(5),
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: isDarkMode
                ? const Color(containerDark)
                : const Color(containerLight),
            borderRadius: const BorderRadius.all(Radius.circular(5)),
          ),
          child: SvgPicture.asset(
            "assets/svg_icons/facebook_icon_v2.svg",
            width: 22,
            height: 22,
            color: isDarkMode ? const Color(iconDark) : const Color(iconLight),
          ),
        ),
        const SizedBox(
          width: 20,
        ),
        Container(
          padding: const EdgeInsets.all(5),
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: isDarkMode
                ? const Color(containerDark)
                : const Color(containerLight),
            borderRadius: const BorderRadius.all(Radius.circular(5)),
          ),
          child: SvgPicture.asset(
            "assets/svg_icons/instagram_icon_v2.svg",
            width: 22,
            height: 22,
            color: isDarkMode ? const Color(iconDark) : const Color(iconLight),
          ),
        ),
        const SizedBox(
          width: 20,
        ),
        Container(
          padding: const EdgeInsets.all(5),
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: isDarkMode
                ? const Color(containerDark)
                : const Color(containerLight),
            borderRadius: const BorderRadius.all(Radius.circular(5)),
          ),
          child: SvgPicture.asset(
            "assets/svg_icons/linkedin_icon_v2.svg",
            width: 22,
            height: 22,
            color: isDarkMode ? const Color(iconDark) : const Color(iconLight),
          ),
        ),
      ],
    );
  }
}
