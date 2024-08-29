import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:finniu/presentation/screens/catalog/widgets/text_poppins.dart';

class ExpansionTitleProfile extends HookConsumerWidget {
  const ExpansionTitleProfile({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.children,
  });

  final String icon;
  final String title;
  final String subtitle;
  final List<Widget> children;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ValueNotifier<bool> extended = useState(false);
    final isDarkMode = ref.watch(settingsNotifierProvider).isDarkMode;
    const int dividerDark = 0xff292828;
    const int dividerLight = 0xffF6F6F6;
    const int iconDark = 0xffA2E6FA;
    const int iconLight = 0xff000000;

    return Column(
      children: [
        Divider(
          height: 1,
          thickness: 1,
          color:
              isDarkMode ? const Color(dividerDark) : const Color(dividerLight),
        ),
        ExpansionTile(
          trailing: AnimatedRotation(
            turns: extended.value ? 0.25 : 0,
            duration: const Duration(milliseconds: 200),
            child: const Icon(Icons.arrow_forward_ios),
          ),
          onExpansionChanged: (bool expanded) {
            extended.value = expanded;
          },
          shape: const Border(),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
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
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.6,
                height: 85,
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
            ],
          ),
          children: children,
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

class ChildrenTitle extends ConsumerWidget {
  const ChildrenTitle({
    super.key,
    required this.title,
    required this.subtitle,
  });
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(width: 53),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.6,
          height: 85,
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
      ],
    );
  }
}
