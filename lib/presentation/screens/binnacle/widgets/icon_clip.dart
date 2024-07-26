import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class IconClip extends ConsumerWidget {
  const IconClip({
    super.key,
    required this.character,
  });
  final String character;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(settingsNotifierProvider).isDarkMode;
    const int containerDark = 0xff052E5C;
    const int containerLight = 0xffD2E7FF;
    return ClipOval(
      child: Container(
        width: 25,
        height: 25,
        color: isDarkMode
            ? const Color(containerDark)
            : const Color(containerLight),
        child: Center(child: Text(character)),
      ),
    );
  }
}
