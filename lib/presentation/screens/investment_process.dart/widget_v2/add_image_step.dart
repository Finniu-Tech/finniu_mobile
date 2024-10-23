import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AddImageStep extends ConsumerWidget {
  const AddImageStep({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(settingsNotifierProvider).isDarkMode;
    const int containerDark = 0xff1D1D1D;
    const int containerLight = 0xffB6EFFF;
    const int iconDark = 0xffA2E6FA;
    const int iconLight = 0xff0D3A5C;

    return Stack(
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          height: 73,
          decoration: BoxDecoration(
            color: isDarkMode
                ? const Color(containerDark)
                : const Color(containerLight),
            borderRadius: const BorderRadius.all(
              Radius.circular(10),
            ),
          ),
          child: Center(
            child: SvgPicture.asset(
              "assets/svg_icons/gallery_add_icon_v2.svg",
              width: 30,
              height: 30,
              color:
                  isDarkMode ? const Color(iconDark) : const Color(iconLight),
            ),
          ),
        ),
        Positioned(
          top: 10,
          right: 10,
          child: SvgPicture.asset(
            "assets/svg_icons/message_question_icon.svg",
            width: 24,
            height: 24,
            color: isDarkMode ? const Color(iconDark) : const Color(iconLight),
          ),
        ),
      ],
    );
  }
}
