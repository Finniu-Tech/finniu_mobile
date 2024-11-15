import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:finniu/presentation/screens/catalog/widgets/text_poppins.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AccountExpanded extends ConsumerWidget {
  const AccountExpanded({super.key, required this.children});
  final List<Widget> children;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(settingsNotifierProvider).isDarkMode;
    final ValueNotifier<bool> extendedState = ValueNotifier(false);
    final controller = ExpansionTileController();
    const int iconDark = 0xffA2E6FA;
    const int iconLight = 0xff0D3A5C;

    onTap() {
      extendedState.value = !extendedState.value;
      extendedState.value ? controller.expand() : controller.collapse();
    }

    return ValueListenableBuilder<bool>(
      valueListenable: extendedState,
      builder: (context, value, child) {
        return ExpansionTile(
          initiallyExpanded: value,
          trailing: SwitchAcount(
            value: value,
            onTap: onTap,
          ),
          controller: controller,
          shape: const Border(),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const TextPoppins(
                text: '¿Es una cuenta mancomunada?',
                fontSize: 12,
                fontWeight: FontWeight.w500,
                align: TextAlign.start,
              ),
              SvgPicture.asset(
                'assets/svg_icons/message_question_icon.svg',
                width: 20,
                height: 20,
                color:
                    isDarkMode ? const Color(iconDark) : const Color(iconLight),
              ),
              TextPoppins(
                text: value ? 'Si' : 'No',
                fontSize: 11,
                align: TextAlign.start,
              ),
            ],
          ),
          children: children,
          onExpansionChanged: (expanded) {
            extendedState.value = expanded;
          },
        );
      },
    );
  }
}

class SwitchAcount extends StatelessWidget {
  const SwitchAcount({super.key, required this.value, required this.onTap});
  final bool value;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    const int activeColor = 0xff0D3A5C;
    const int activeTrackColor = 0xffD4F5FF;
    const int inactiveThumbColor = 0xff828282;
    const int inactiveTrackColor = 0xffF3F3F3;
    return Switch(
      value: value,
      activeColor: const Color(activeColor),
      inactiveThumbColor: const Color(inactiveThumbColor),
      activeTrackColor: const Color(activeTrackColor),
      inactiveTrackColor: const Color(inactiveTrackColor),
      onChanged: (_) => {onTap()},
    );
  }
}
