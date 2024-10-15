import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:finniu/presentation/providers/user_provider.dart';
import 'package:finniu/presentation/screens/catalog/circular_loader.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ButtonToProfile extends ConsumerWidget {
  const ButtonToProfile({
    super.key,
    required this.size,
  });
  final double size;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userProfile = ref.watch(userProfileNotifierProvider);
    final isDarkMode = ref.watch(settingsNotifierProvider).isDarkMode;

    return GestureDetector(
      onTap: () {
        Navigator.pushNamedAndRemoveUntil(context, '/v2/profile', (_) => false);
      },
      child: ClipOval(
        child: Image.network(
          userProfile.imageProfileUrl == null ||
                  userProfile.imageProfileUrl == ""
              ? "https://e7.pngegg.com/pngimages/84/165/png-clipart-united-states-avatar-organization-information-user-avatar-service-computer-wallpaper-thumbnail.png"
              : userProfile.imageProfileUrl!,
          width: size,
          height: size,
          errorBuilder: (context, error, stackTrace) => Image.asset(
            "assets/backgroud/profile_background_${isDarkMode ? "dark" : "light"}.png",
            width: size,
            height: size,
          ),
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) {
              return child;
            }
            return CircularLoader(width: size, height: size);
          },
        ),
      ),
    );
  }
}