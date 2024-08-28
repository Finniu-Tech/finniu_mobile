import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:finniu/presentation/screens/catalog/widgets/text_poppins.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ButtonNavigateProfile extends ConsumerWidget {
  const ButtonNavigateProfile({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
    this.isComplete = false,
    this.onlyTitle = false,
  });
  final String icon;
  final String title;
  final String subtitle;
  final VoidCallback? onTap;
  final bool isComplete;
  final bool onlyTitle;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(settingsNotifierProvider).isDarkMode;
    const int dividerDark = 0xff292828;
    const int dividerLight = 0xffF6F6F6;
    const int iconDark = 0xffA2E6FA;
    const int iconLight = 0xff000000;
    const int iconButtonDark = 0xffFFFFFF;
    const int iconButtonLight = 0xff000000;
    const int textCompleteDark = 0xffA2E6FA;
    const int textCompleteLight = 0xff0D3A5C;
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Divider(
            height: 1,
            thickness: 1,
            color: isDarkMode
                ? const Color(dividerDark)
                : const Color(dividerLight),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 85,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  onlyTitle
                      ? Center(
                          child: SvgPicture.asset(
                            icon,
                            width: 25,
                            height: 25,
                            color: isDarkMode
                                ? const Color(iconDark)
                                : const Color(iconLight),
                          ),
                        )
                      : Column(
                          children: [
                            const SizedBox(height: 15),
                            SvgPicture.asset(
                              icon,
                              width: 25,
                              height: 25,
                              color: isDarkMode
                                  ? const Color(iconDark)
                                  : const Color(iconLight),
                            ),
                          ],
                        ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextPoppins(
                          text: title,
                          fontSize: 16,
                          isBold: true,
                          align: TextAlign.start,
                        ),
                        onlyTitle
                            ? const SizedBox()
                            : TextPoppins(
                                text: subtitle,
                                fontSize: 12,
                                isBold: false,
                                lines: 2,
                                align: TextAlign.start,
                              ),
                      ],
                    ),
                  ),
                  isComplete
                      ? const SizedBox()
                      : const Center(
                          child: TextPoppins(
                            text: "Completar  ",
                            fontSize: 12,
                            isBold: true,
                            align: TextAlign.start,
                            textDark: textCompleteDark,
                            textLight: textCompleteLight,
                          ),
                        ),
                  onlyTitle
                      ? const SizedBox()
                      : Center(
                          child: Icon(
                            Icons.arrow_forward_ios,
                            size: 24,
                            color: isDarkMode
                                ? const Color(iconButtonDark)
                                : const Color(iconButtonLight),
                          ),
                        ),
                ],
              ),
            ),
          ),
          Divider(
            height: 1,
            thickness: 1,
            color: isDarkMode
                ? const Color(dividerDark)
                : const Color(dividerLight),
          ),
        ],
      ),
    );
  }
}
