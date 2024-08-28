import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:finniu/presentation/screens/catalog/widgets/text_poppins.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ButtonMyData extends ConsumerWidget {
  const ButtonMyData({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.load,
    this.onTap,
  });
  final String icon;
  final String title;
  final String subtitle;
  final double load;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(settingsNotifierProvider).isDarkMode;
    const int backgroundDark = 0xff262626;
    const int backgroundLight = 0xffF3F3F3;
    const int iconDark = 0xffFFFFFF;
    const int iconLight = 0xff000000;
    const int lineDark = 0xff3C3C3C;
    const int lineLight = 0xffBFF0FF;
    const int lineLoadDark = 0xffA2E6FA;
    const int lineLoadLight = 0xff0D3A5C;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(10),
        width: MediaQuery.of(context).size.width * 0.4,
        height: 87,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: isDarkMode
              ? const Color(backgroundDark)
              : const Color(backgroundLight),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              icon,
              width: 25,
              height: 25,
              color:
                  isDarkMode ? const Color(iconDark) : const Color(iconLight),
            ),
            TextPoppins(
              text: title,
              fontSize: 12,
              isBold: true,
            ),
            TextPoppins(
              text: subtitle,
              fontSize: 10,
              isBold: false,
            ),
            const SizedBox(
              height: 5,
            ),
            LayoutBuilder(
              builder: (context, constraints) {
                return Stack(
                  children: [
                    Container(
                      height: 3,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: isDarkMode
                            ? const Color(lineDark)
                            : const Color(lineLight),
                      ),
                    ),
                    Container(
                      width: constraints.maxWidth * load,
                      height: 3,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: isDarkMode
                            ? const Color(lineLoadDark)
                            : const Color(lineLoadLight),
                      ),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
