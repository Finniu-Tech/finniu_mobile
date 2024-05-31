import 'package:finniu/constants/colors.dart';
import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class StepBarReInvestment extends ConsumerStatefulWidget {
  final int step;

  const StepBarReInvestment({
    Key? key,
    required this.step,
  });

  @override
  _StepBarReInvestmentState createState() => _StepBarReInvestmentState();
}

class _StepBarReInvestmentState extends ConsumerState<StepBarReInvestment> {
  @override
  Widget build(BuildContext context) {
    final currentTheme = ref.watch(settingsNotifierProvider);
    final Color activeBackgroundColor = currentTheme.isDarkMode ? const Color(secondary) : const Color(primaryLight);
    final Color inactiveBackgroundColor = currentTheme.isDarkMode ? Colors.transparent : Colors.transparent;

    final Color inactiveBorderColor = currentTheme.isDarkMode ? const Color(primaryLight) : const Color(primaryDark);
    const Color activeBorderColor = Colors.transparent;
    final Color activeIconColor = currentTheme.isDarkMode ? const Color(primaryDark) : const Color(primaryDark);
    final Color inactiveIconColor = currentTheme.isDarkMode ? const Color(primaryLight) : const Color(primaryDark);

    // Color backgroundColor = currentTheme.isDarkMode
    //     ? const Color(secondary)
    //     : const Color(primaryLight);
    // Color containerColor = inactiveColor; // Color por defecto

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 13,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 40,
              width: 55,
              decoration: BoxDecoration(
                color: widget.step == 1 ? activeBackgroundColor : inactiveBackgroundColor,
                border: Border.all(
                  color: widget.step == 1 ? activeBorderColor : inactiveBorderColor,
                  width: 2,
                ),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(5),
                  topRight: Radius.circular(5),
                  bottomLeft: Radius.circular(4),
                  bottomRight: Radius.circular(4),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(4),
                child: Image.asset(
                  'assets/icons/dollar.png',
                  color: widget.step == 1 ? activeIconColor : inactiveIconColor,

                  // fit:BoxFit.scaleDown,
                  fit: BoxFit.fitHeight,
                ),
              ),
            ),
            SizedBox(
              width: 38,
              child: Column(
                children: [
                  Divider(
                    color: currentTheme.isDarkMode ? const Color(primaryLight) : const Color(primaryDark),
                    thickness: 1,
                  ),
                ],
              ),
            ),
            SizedBox(
              width: 38,
              child: Column(
                children: [
                  Divider(
                    color: currentTheme.isDarkMode ? const Color(primaryLight) : const Color(primaryDark),
                    thickness: 1,
                  ),
                ],
              ),
            ),
            Container(
              height: 40,
              width: 55,
              decoration: BoxDecoration(
                color: widget.step == 3 ? activeBackgroundColor : inactiveBackgroundColor,
                border: Border.all(
                  color: widget.step == 3 ? activeBorderColor : inactiveBorderColor,
                  width: 2,
                ),
                shape: BoxShape.rectangle,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(5),
                  topRight: Radius.circular(5),
                  bottomLeft: Radius.circular(4),
                  bottomRight: Radius.circular(4),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Image.asset(
                  'assets/icons/square2.png',
                  color: widget.step == 3 ? activeIconColor : inactiveIconColor,
                  fit: BoxFit.fitHeight,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
