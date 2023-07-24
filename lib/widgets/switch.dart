import 'package:finniu/constants/colors.dart';
import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:finniu/services/share_preferences_service.dart';
import 'package:finniu/widgets/fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SwitchMoney extends HookConsumerWidget {
  final double switchWidth;
  final double switchHeight;
  final String switchText;

  const SwitchMoney({
    Key? key,
    required this.switchWidth,
    required this.switchHeight,
    required this.switchText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeProvider = ref.watch(settingsNotifierProvider);

    return Row(
      children: [
        Text(
          switchText,
          style: TextStyle(
            color: Theme.of(context).colorScheme.primary,
            fontSize: 10,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(width: 5),
        FlutterSwitch(
          width: switchWidth,
          height: switchHeight,
          value: Preferences.isDarkMode,
          inactiveColor: const Color(primaryDark),
          activeColor: const Color(primaryLight),
          inactiveToggleColor: const Color(primaryLight),
          activeToggleColor: const Color(primaryDark),
          onToggle: (value) {
            // Asegúrate de cambiar Preferences.isDarkMode por tu lógica para cambiar el tema
            Preferences.isDarkMode = value;
            value
                ? ref.read(settingsNotifierProvider.notifier).setDarkMode()
                : ref.read(settingsNotifierProvider.notifier).setLightMode();
          },
        ),
      ],
    );
  }
}
