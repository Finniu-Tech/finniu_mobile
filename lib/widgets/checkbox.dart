import 'package:finniu/constants/colors.dart';
import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CustomCheckBox extends StatefulHookConsumerWidget {
  const CustomCheckBox({super.key});

  @override
  ConsumerState<CustomCheckBox> createState() => _CustomCheckBoxState();
}

class _CustomCheckBoxState extends ConsumerState<CustomCheckBox> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    final currentTheme = ref.watch(settingsNotifierProvider);
    Color getColor(Set<MaterialState> states) {
      // const Set<MaterialState> interactiveStates = <MaterialState>{
      //   MaterialState.pressed,
      //   MaterialState.hovered,
      //   MaterialState.focused,
      // };

      return currentTheme.isDarkMode
          ? const Color(primaryLight)
          : const Color(primaryDark);
    }

    return Checkbox(
      checkColor: Colors.white,
      fillColor: MaterialStateProperty.resolveWith(getColor),
      value: isChecked,
      onChanged: (bool? value) {
        setState(() {
          isChecked = value!;
        });
      },
    );
  }
}
