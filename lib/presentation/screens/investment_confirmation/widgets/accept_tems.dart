import 'package:finniu/constants/colors.dart';
import 'package:finniu/presentation/providers/pre_investment_provider.dart';
import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AcceptedTermCheckBox extends StatefulHookConsumerWidget {
  const AcceptedTermCheckBox({
    super.key,
  });

  @override
  ConsumerState<AcceptedTermCheckBox> createState() => _CustomCheckBoxState();
}

class _CustomCheckBoxState extends ConsumerState<AcceptedTermCheckBox> {
  @override
  Widget build(BuildContext context) {
    final currentTheme = ref.watch(settingsNotifierProvider);
    bool userAcceptedTerms = ref.watch(userAcceptedTermsProvider);
    Color getColor(Set<MaterialState> states) {
      return currentTheme.isDarkMode
          ? const Color(primaryLight)
          : const Color(primaryDark);
    }

    return Checkbox(
      checkColor: Colors.white,
      fillColor: MaterialStateProperty.resolveWith(getColor),
      value: userAcceptedTerms,
      onChanged: (bool? value) {
        ref
            .read(userAcceptedTermsProvider.notifier)
            .update((state) => state = value ?? false);
      },
    );
  }
}
