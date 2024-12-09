import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AppBarProduct extends ConsumerWidget implements PreferredSizeWidget {
  const AppBarProduct({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(settingsNotifierProvider).isDarkMode;
    const int backgroundColorDark = 0xff0E0E0E;
    const int backgroundColorLight = 0xffFFFFFF;
    const int iconDark = 0xffA2E6FA;
    const int iconLight = 0xff0D3A5C;

    return AppBar(
      backgroundColor: isDarkMode
          ? const Color(backgroundColorDark)
          : const Color(backgroundColorLight),
      iconTheme: isDarkMode
          ? const IconThemeData(color: Color(iconDark))
          : const IconThemeData(color: Color(iconLight)),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(50);
}
