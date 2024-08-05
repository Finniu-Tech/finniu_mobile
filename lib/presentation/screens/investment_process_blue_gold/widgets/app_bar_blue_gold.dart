import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AppBarBlueGoldScreen extends ConsumerWidget
    implements PreferredSizeWidget {
  const AppBarBlueGoldScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(settingsNotifierProvider).isDarkMode;
    const int appBarColorDark = 0xff0E0E0E;
    const int appBarColorLight = 0xffFFFFFF;
    const int iconColorDark = 0xffA2E6FA;
    const int iconColorLight = 0xff0D3A5C;

    return SafeArea(
      child: AppBar(
        backgroundColor: isDarkMode
            ? const Color(appBarColorDark)
            : const Color(appBarColorLight),
        iconTheme: IconThemeData(
          color: isDarkMode
              ? const Color(
                  iconColorDark,
                )
              : const Color(
                  iconColorLight,
                ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 1.0);
}
