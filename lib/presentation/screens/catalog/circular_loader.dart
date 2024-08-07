import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CircularLoader extends ConsumerWidget {
  const CircularLoader({super.key, required this.width, required this.height});
  final double width;
  final double height;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(settingsNotifierProvider).isDarkMode;
    const int colorDark = 0xffA2E6FA;
    const int colorLight = 0xff0D3A5C;
    return SizedBox(
      width: width,
      height: height,
      child: Center(
        child: CircularProgressIndicator(
          color: isDarkMode ? const Color(colorDark) : const Color(colorLight),
        ),
      ),
    );
  }
}
