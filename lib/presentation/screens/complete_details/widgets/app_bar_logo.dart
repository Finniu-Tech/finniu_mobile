import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AppBarLogo extends ConsumerWidget implements PreferredSizeWidget {
  const AppBarLogo({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(settingsNotifierProvider).isDarkMode;
    const int backgroundDark = 0xff191919;
    const int backgroundLight = 0xffFFFFFF;
    const int iconColorDark = 0xffA2E6FA;
    const int iconColorLight = 0xff0D3A5C;
    return AppBar(
      backgroundColor: isDarkMode
          ? const Color(backgroundDark)
          : const Color(backgroundLight),
      automaticallyImplyLeading: true,
      iconTheme: isDarkMode
          ? const IconThemeData(color: Color(iconColorDark))
          : const IconThemeData(color: Color(iconColorLight)),
      actions: [
        Row(
          children: [
            Image.asset(
              "assets/images/logo_register_v2_${isDarkMode ? 'dark' : 'light'}.png",
              width: 38,
              height: 38,
            ),
            const SizedBox(width: 20),
          ],
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 1.0);
}
