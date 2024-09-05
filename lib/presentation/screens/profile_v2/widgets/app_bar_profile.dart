import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AppBarProfile extends ConsumerWidget implements PreferredSizeWidget {
  const AppBarProfile({
    super.key,
    required this.title,
  });
  final String title;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(settingsNotifierProvider).isDarkMode;
    const int backgroundDark = 0xff191919;
    const int backgroundLight = 0xffFFFFFF;
    const int titleColorDark = 0xffFFFFFF;
    const int titleColorLight = 0xff000000;
    const int iconColorDark = 0xffA2E6FA;
    const int iconColorLight = 0xff0D3A5C;

    return AppBar(
      centerTitle: true,
      backgroundColor: isDarkMode
          ? const Color(backgroundDark)
          : const Color(backgroundLight),
      automaticallyImplyLeading: true,
      title: Text(
        title,
        style: TextStyle(
          fontFamily: "Poppins",
          fontSize: 17,
          color: isDarkMode
              ? const Color(titleColorDark)
              : const Color(titleColorLight),
          fontWeight: FontWeight.w600,
        ),
      ),
      leading: IconButton(
        onPressed: () => Navigator.pop(context),
        icon: Icon(
          Icons.arrow_back,
          color: isDarkMode
              ? const Color(iconColorDark)
              : const Color(iconColorLight),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 1.0);
}
