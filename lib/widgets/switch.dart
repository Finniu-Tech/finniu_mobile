import 'package:finniu/constants/colors.dart';
import 'package:finniu/presentation/providers/money_provider.dart';
import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SwitchMoney extends StatefulHookConsumerWidget {
  final double switchWidth;
  final double switchHeight;
  // final String switchText;

  const SwitchMoney({
    Key? key,
    required this.switchWidth,
    required this.switchHeight,
    // required this.switchText,
  }) : super(key: key);

  @override
  _SwitchMoneyState createState() => _SwitchMoneyState();
}

class _SwitchMoneyState extends ConsumerState<SwitchMoney> {
  bool isSoles = true;

  bool isDarkMode = false;

  Widget build(BuildContext context) {
    final currentTheme = ref.watch(settingsNotifierProvider);
    isDarkMode = currentTheme.isDarkMode;
    isSoles = ref.watch(isSolesStateProvider);
    final colorTextSoles = isDarkMode ? Color(primaryDark) : Color(whiteText);
    final colorTextDollars = isDarkMode ? Color(whiteText) : Color(primaryDark);
    // final currencyColors = ref.watch(currencyColorsProvider);

    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Stack(
          alignment: isSoles ? Alignment.centerRight : Alignment.centerLeft,
          children: [
            FlutterSwitch(
              width: widget.switchWidth,
              height: widget.switchHeight,
              value: isSoles,
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
                  // isDarkMode = currentTheme.isDarkMode;
                  isSoles = value;
                  ref.read(isSolesStateProvider.notifier).toggleSwitch(value);
                });
                // Preferences.isDarkMode = value;
              },
            ),
            Positioned(
              left: isSoles ? 0 : null,
              right: isSoles ? null : 0,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text(
                  isSoles ? 'S/' : '\$',
                  style: TextStyle(
                    color: isSoles ? colorTextSoles : colorTextDollars,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
