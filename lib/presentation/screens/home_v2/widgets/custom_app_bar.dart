import 'package:finniu/constants/colors.dart';
import 'package:finniu/presentation/screens/home_v2/widgets/notification_button.dart';
import 'package:finniu/presentation/screens/home_v2/widgets/profile_button.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final dynamic currentTheme;
  final dynamic userProfile;

  const CustomAppBar({
    Key? key,
    required this.currentTheme,
    required this.userProfile,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: 50,
      elevation: 0.0,
      backgroundColor: Color(
        currentTheme.isDarkMode ? backgroundColorDark : scaffoldLightGradientPrimary,
      ),
      leading: Image.asset(
        'assets/images/logo_small.png',
        width: 80,
        height: 80,
        color: currentTheme.isDarkMode ? const Color(whiteText) : const Color(blackText),
      ),
      title: Text(
        'Hola, ${userProfile.nickName ?? ''}!',
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: currentTheme.isDarkMode ? const Color(whiteText) : const Color(primaryDark),
        ),
      ),
      actions: const [
        NotificationButton(),
        ProfileButton(),
        SizedBox(width: 10),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(50);
}
