import 'package:finniu/constants/colors.dart';
import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class EnterpriseFundTitle extends ConsumerWidget {
  const EnterpriseFundTitle({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentTheme = ref.watch(settingsNotifierProvider);

    return Container(
      height: 33,
      width: 250,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        border: Border.all(
          color: currentTheme.isDarkMode
              ? const Color(primaryDark)
              : const Color(primaryLight),
        ),
        color: currentTheme.isDarkMode
            ? const Color(backGroundColorFundTitleContainer)
            : const Color(lightBackgroundTitleFund),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Text(
          '🏢 Inversiones empresariales',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: currentTheme.isDarkMode ? Colors.white : Colors.black,
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}

class AggroFundTitle extends ConsumerWidget {
  const AggroFundTitle({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container();
  }
}
