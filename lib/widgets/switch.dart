import 'package:finniu/constants/colors.dart';
import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:finniu/services/share_preferences_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SwitchMoney extends StatefulHookConsumerWidget {
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
  _SwitchMoneyState createState() => _SwitchMoneyState();
}

class _SwitchMoneyState extends ConsumerState<SwitchMoney> {
  bool isSoles = true;
  bool isDarkMode = false;
  Color daySolesColor = Color(primaryDark);
  Color dayDollarsColor = Color(whiteText);
  Color nightSolesColor = Color(primaryDark);
  Color nightDollarsColor = Color(primaryLight);

  Color get symbolColor => isSoles
      ? (isDarkMode ? nightSolesColor : daySolesColor)
      : (isDarkMode ? nightDollarsColor : dayDollarsColor);

  Widget build(BuildContext context) {
    final currentTheme = ref.watch(settingsNotifierProvider);
    isDarkMode = currentTheme.isDarkMode;

    return Row(
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            FlutterSwitch(
              width: widget.switchWidth,
              height: widget.switchHeight,
              value: Preferences.isDarkMode,
              inactiveColor: currentTheme.isDarkMode
                  ? const Color(primaryDark)
                  : const Color(primaryLight),
              activeColor: currentTheme.isDarkMode
                  ? const Color(primaryLight)
                  : const Color(primaryDark),
              inactiveToggleColor: currentTheme.isDarkMode
                  ? const Color(primaryLight)
                  : const Color(primaryDark),
              activeToggleColor: currentTheme.isDarkMode
                  ? const Color(primaryDark)
                  : const Color(primaryLight),
              toggleSize: 20,
              onToggle: (value) {
                setState(() {
                  isSoles = !isSoles;
                  isDarkMode = currentTheme.isDarkMode;
                });
                Preferences.isDarkMode = value;
              },
            ),
            Text(
              isSoles ? 'S/' : '\$',
              style: TextStyle(
                color: symbolColor,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
