import 'package:finniu/constants/colors/home_v4_colors.dart';
import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:finniu/presentation/providers/user_provider.dart';
import 'package:finniu/presentation/screens/catalog/widgets/button_to_profile.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CustomAppBarV4 extends ConsumerWidget implements PreferredSizeWidget {
  const CustomAppBarV4({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(settingsNotifierProvider).isDarkMode;
    final userProfile = ref.watch(userProfileNotifierProvider);

    return AppBar(
      toolbarHeight: 100,
      elevation: 0.0,
      backgroundColor: isDarkMode
          ? const Color(HomeV4Colors.appBarColorDark)
          : const Color(HomeV4Colors.appBarColorLight),
      leading: Image.asset(
        'assets/images/logo_small.png',
        width: 80,
        height: 80,
        color: isDarkMode
            ? const Color(HomeV4Colors.logoColorDark)
            : const Color(HomeV4Colors.logoColorLight),
      ),
      title: Text(
        'Hola, ${userProfile.firstName ?? ''}!',
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: isDarkMode
              ? const Color(HomeV4Colors.logoColorDark)
              : const Color(HomeV4Colors.logoColorLight),
        ),
      ),
      actions: const [
        // NotificationButton(),
        ButtonToProfile(size: 36),
        SizedBox(width: 10),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(90);
}
