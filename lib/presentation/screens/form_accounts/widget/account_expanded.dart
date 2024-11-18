import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:finniu/presentation/screens/catalog/widgets/text_poppins.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AccountExpanded extends ConsumerWidget {
  const AccountExpanded({
    super.key,
    required this.children,
    required this.controllerExpanded,
  });
  final List<Widget> children;
  final ExpansionTileController controllerExpanded;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(settingsNotifierProvider).isDarkMode;
    final extendedState = useState<bool>(false);

    const int iconDark = 0xffA2E6FA;
    const int iconLight = 0xff0D3A5C;

    onTap() {
      extendedState.value = !extendedState.value;
      extendedState.value
          ? controllerExpanded.expand()
          : controllerExpanded.collapse();
    }

    return ValueListenableBuilder<bool>(
      valueListenable: extendedState,
      builder: (context, value, child) {
        return ExpansionTile(
          tilePadding: EdgeInsets.zero,
          initiallyExpanded: value,
          trailing: SwitchAcount(
            value: value,
            onTap: onTap,
          ),
          controller: controllerExpanded,
          shape: const Border(),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Expanded(
                child: TextPoppins(
                  text: '¿Es una cuenta mancomunada?',
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  align: TextAlign.start,
                ),
              ),
              SvgPicture.asset(
                'assets/svg_icons/message_question_icon.svg',
                width: 20,
                height: 20,
                color:
                    isDarkMode ? const Color(iconDark) : const Color(iconLight),
              ),
              const SizedBox(width: 5),
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
