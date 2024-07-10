import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AppBarBusinessScreen extends ConsumerWidget
    implements PreferredSizeWidget {
  const AppBarBusinessScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(settingsNotifierProvider).isDarkMode;
    const int titleColorDark = 0xffFFFFFF;
    const int titleColorLight = 0xff000000;
    const int appBarColorDark = 0xff0E0E0E;
    const int appBarColorLight = 0xffFFFFFF;
    const int iconColorDark = 0xffA2E6FA;
    const int iconColorLight = 0xff0D3A5C;
    const int borderColorDark = 0xff1E1E1E;
    const int borderColorLight = 0xff1E1E1E;

    return AppBar(
      centerTitle: true,
      title: Text(
        "Mis inversiones",
        style: TextStyle(
          fontFamily: "Poppins",
          fontSize: 17,
          color: isDarkMode
              ? const Color(titleColorDark)
              : const Color(titleColorLight),
          fontWeight: FontWeight.bold,
        ),
      ),
      scrolledUnderElevation: 1,
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
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(1.0),
        child: Container(
          color: isDarkMode
              ? const Color(borderColorDark)
              : const Color(borderColorLight),
          height: 1.0,
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 1.0);
}
