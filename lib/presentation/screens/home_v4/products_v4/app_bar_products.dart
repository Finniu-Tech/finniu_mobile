import 'package:finniu/constants/colors/home_v4_colors.dart';
import 'package:finniu/presentation/providers/navigator_provider.dart';
import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:finniu/presentation/screens/catalog/widgets/text_poppins.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AppBarProducts extends ConsumerWidget implements PreferredSizeWidget {
  const AppBarProducts({
    super.key,
    this.title = 'Productos',
  });
  final String title;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(settingsNotifierProvider).isDarkMode;

    return AppBar(
      backgroundColor: isDarkMode
          ? const Color(NavBarV4Colors.backgroundColorDark)
          : const Color(NavBarV4Colors.backgroundColorLight),
      iconTheme: isDarkMode
          ? const IconThemeData(color: Color(NavBarV4Colors.iconDark))
          : const IconThemeData(color: Color(NavBarV4Colors.iconLight)),
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(1),
        child: Container(
          color: isDarkMode
              ? const Color(NavBarV4Colors.borderDark)
              : const Color(NavBarV4Colors.borderLight),
          height: 1,
        ),
      ),
      leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () {
          ref.read(navigatorStateProvider.notifier).state = 0;
          Navigator.pop(context);
        },
      ),
      title: TextPoppins(
        text: title,
        fontSize: 17,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(50);
}
