import 'package:finniu/constants/colors.dart';
import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class NotificationButton extends HookConsumerWidget {
  const NotificationButton({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final currentTheme = ref.watch(settingsNotifierProvider);
    return IconButton(
      iconSize: 24,
      icon: Image.asset(
        'assets/icons/notification_icon.png',
        width: 24,
        height: 24,
        color: currentTheme.isDarkMode ? const Color(whiteText) : const Color(primaryDark),
      ),
      tooltip: 'Notificaciones',
      onPressed: () {},
    );
  }
}
