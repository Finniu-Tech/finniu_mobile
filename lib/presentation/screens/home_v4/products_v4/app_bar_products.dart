import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:finniu/presentation/screens/catalog/widgets/text_poppins.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AppBarProducts extends ConsumerWidget implements PreferredSizeWidget {
  const AppBarProducts({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(settingsNotifierProvider).isDarkMode;
    const int backgroundColorDark = 0xff0E0E0E;
    const int backgroundColorLight = 0xffFFFFFF;
    const int borderDark = 0xff3C3C3C;
    const int borderLight = 0xffE6E6E6;
    const int iconDark = 0xffA2E6FA;
    const int iconLight = 0xff0D3A5C;

    return AppBar(
      backgroundColor: isDarkMode
          ? const Color(backgroundColorDark)
          : const Color(backgroundColorLight),
      iconTheme: isDarkMode
          ? const IconThemeData(color: Color(iconDark))
          : const IconThemeData(color: Color(iconLight)),
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(1),
        child: Container(
          color:
              isDarkMode ? const Color(borderDark) : const Color(borderLight),
          height: 1,
        ),
      ),
      title: const TextPoppins(
        text: 'Productos',
        fontSize: 17,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(50);
}
