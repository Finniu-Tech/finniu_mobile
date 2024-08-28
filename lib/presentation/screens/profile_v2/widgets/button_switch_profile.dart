import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:finniu/presentation/screens/catalog/widgets/text_poppins.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ButtonSwitchProfile extends ConsumerWidget {
  const ButtonSwitchProfile({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
    required this.value,
  });
  final String? icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;
  final bool value;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(settingsNotifierProvider).isDarkMode;
    const int dividerDark = 0xff292828;
    const int dividerLight = 0xffF6F6F6;
    const int iconDark = 0xffA2E6FA;
    const int iconLight = 0xff000000;
    const int activeColor = 0xff0D3A5C;
    const int activeTrackColor = 0xffD4F5FF;
    const int inactiveThumbColor = 0xff828282;
    const int inactiveTrackColor = 0xffF3F3F3;

    return Column(
      children: [
        Divider(
          height: 1,
          thickness: 1,
          color:
              isDarkMode ? const Color(dividerDark) : const Color(dividerLight),
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
                const SizedBox(width: 15),
                Column(
                  children: [
                    icon == null
                        ? const SizedBox.shrink()
                        : const SizedBox(height: 15),
                    icon == null
                        ? const SizedBox.shrink()
                        : SvgPicture.asset(
                            icon!,
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
                      TextPoppins(
                        text: subtitle,
                        fontSize: 12,
                        isBold: false,
                        lines: 2,
                        align: TextAlign.start,
                      ),
                    ],
                  ),
                ),
                Center(
                  child: Switch(
                    value: value,
                    activeColor: const Color(activeColor),
                    inactiveThumbColor: const Color(inactiveThumbColor),
                    activeTrackColor: const Color(activeTrackColor),
                    inactiveTrackColor: const Color(inactiveTrackColor),
                    onChanged: (_) => onTap(),
                  ),
                ),
              ],
            ),
          ),
        ),
        Divider(
          height: 1,
          thickness: 1,
          color:
              isDarkMode ? const Color(dividerDark) : const Color(dividerLight),
        ),
      ],
    );
  }
}
