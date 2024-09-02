import 'package:finniu/presentation/screens/profile_v2/widgets/button_switch_profile.dart';
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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(width: 40),
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
    );
  }
}

class ChildrenEmail extends ConsumerWidget {
  const ChildrenEmail({
    super.key,
    required this.title,
    required this.subtitle,
    required this.email,
  });
  final String title;
  final String subtitle;
  final String email;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const int emailDark = 0xffA2E6FA;
    const int emailLight = 0xff0D3A5C;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(width: 40),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.6,
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
                const SizedBox(
                  height: 5,
                ),
                TextPoppins(
                  text: email,
                  fontSize: 14,
                  isBold: true,
                  lines: 2,
                  align: TextAlign.start,
                  textDark: emailDark,
                  textLight: emailLight,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ChildrenSwitchTitle extends HookConsumerWidget {
  const ChildrenSwitchTitle({
    super.key,
    required this.title,
    required this.subtitle,
  });
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ValueNotifier<bool> value = useState(false);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(width: 40),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.6,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 5,
                ),
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
          const Expanded(child: SizedBox()),
          SwitchWidget(
            value: value.value,
            onTap: () => value.value = !value.value,
          ),
        ],
      ),
    );
  }
}

class ChildrenOnlyText extends ConsumerWidget {
  const ChildrenOnlyText({
    super.key,
    required this.text,
    this.textBig = false,
  });
  final String text;
  final bool textBig;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.8,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextPoppins(
              text: text,
              fontSize: textBig ? 14 : 12,
              isBold: false,
              lines: 3,
              align: TextAlign.start,
            ),
          ],
        ),
      ),
    );
  }
}

class ExpansionTitleLegal extends HookConsumerWidget {
  const ExpansionTitleLegal({
    super.key,
    required this.title,
    required this.children,
  });

  final String title;
  final List<Widget> children;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ValueNotifier<bool> extended = useState(false);
    final isDarkMode = ref.watch(settingsNotifierProvider).isDarkMode;
    const int dividerDark = 0xff292828;
    const int dividerLight = 0xffD9D9D9;

    return Column(
      children: [
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
          title: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.6,
              height: 40,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  TextPoppins(
                    text: title,
                    fontSize: 16,
                    isBold: true,
                    align: TextAlign.start,
                  ),
                ],
              ),
            ),
          ),
          children: children,
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.9,
          child: Divider(
            height: 2,
            thickness: 1,
            color: isDarkMode
                ? const Color(dividerDark)
                : const Color(dividerLight),
          ),
        ),
      ],
    );
  }
}

class ChildrenCheckboxTitle extends HookConsumerWidget {
  const ChildrenCheckboxTitle({
    super.key,
    required this.subtitle,
  });

  final String subtitle;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ValueNotifier<bool> value = useState(false);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(width: 20),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.7,
            height: 65,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 5,
                ),
                TextPoppins(
                  text: subtitle,
                  fontSize: 14,
                  isBold: false,
                  lines: 3,
                  align: TextAlign.start,
                ),
              ],
            ),
          ),
          const Expanded(child: SizedBox()),
          CheckBoxWidget(value: value),
        ],
      ),
    );
  }
}

class CheckBoxWidget extends ConsumerWidget {
  const CheckBoxWidget({
    super.key,
    required this.value,
  });

  final ValueNotifier<bool> value;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(settingsNotifierProvider).isDarkMode;
    const backgroundLight = Color(0xff0D3A5C);
    const backgroundDark = Color(0xffA2E6FA);

    return Transform.scale(
      scale: 1.3,
      child: Checkbox(
        value: value.value,
        onChanged: (_) => value.value = !value.value,
        fillColor: WidgetStateProperty.resolveWith<Color>(
          (Set<WidgetState> states) {
            if (states.contains(WidgetState.selected)) {
              return isDarkMode ? backgroundDark : backgroundLight;
            }
            return Colors.transparent;
          },
        ),
        checkColor: isDarkMode ? backgroundLight : backgroundDark,
        shape: RoundedRectangleBorder(
          side: BorderSide(
            color: isDarkMode ? backgroundDark : backgroundLight,
            width: 1.5,
          ),
          borderRadius: BorderRadius.circular(4.0),
        ),
      ),
    );
  }
}
