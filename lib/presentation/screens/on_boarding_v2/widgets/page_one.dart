import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class PageOneContainer extends ConsumerWidget {
  const PageOneContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(settingsNotifierProvider).isDarkMode;
    const List<Color> gradientDark = [
      Color(0xFF0D3A5C),
      Color(0xFF306281),
      Color(0xFFA2E6FA),
    ];
    const List<Color> gradientLight = [
      Color(0xFF9F8FFF),
      Color(0xFFA1D6FB),
      Color(0xFFA2E6FA),
    ];
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: isDarkMode ? gradientDark : gradientLight,
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          stops: const [0.0, 0.5, 1.0],
        ),
      ),
    );
  }
}
