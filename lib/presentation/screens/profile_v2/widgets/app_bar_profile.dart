import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AppBarProfile extends ConsumerWidget implements PreferredSizeWidget {
  const AppBarProfile({
    super.key,
    required this.title,
    this.onLeadingPressed,
  });
  final String title;
  final VoidCallback? onLeadingPressed;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(settingsNotifierProvider).isDarkMode;
    const int backgroundDark = 0xff191919;
    const int backgroundLight = 0xffFFFFFF;
    const int titleColorDark = 0xffFFFFFF;
    const int titleColorLight = 0xff000000;
    const int iconColorDark = 0xffA2E6FA;
    const int iconColorLight = 0xff0D3A5C;
    const int borderColorDark = 0xff535050;
    const int borderColorLight = 0xffE6E6E6;

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
        onPressed: () => onLeadingPressed != null
            ? onLeadingPressed!()
            : Navigator.of(context).pop(),
        icon: Icon(
          Icons.arrow_back,
          color: isDarkMode
              ? const Color(iconColorDark)
              : const Color(iconColorLight),
        ),
      ),
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(1.0),
        child: Container(
          color: isDarkMode
              ? const Color(borderColorDark)
              : const Color(borderColorLight),
          height: 0.5,
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 1.0);
}
