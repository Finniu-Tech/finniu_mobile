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

    const borderWidth = 2.0;
    final secondBorder = isDarkMode ? Colors.black : Colors.white;
    final borderColor =
        isDarkMode ? const Color(0xffA2E6FA) : const Color(0xff4C8DBE);
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/v2/profile');
      },
      child: Container(
        width: size + borderWidth + borderWidth,
        height: size + borderWidth + borderWidth,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: borderColor,
            width: borderWidth,
          ),
        ),
        child: Container(
          width: size + borderWidth,
          height: size + borderWidth,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: secondBorder,
              width: borderWidth,
            ),
          ),
          child: ClipOval(
            child: userProfile.imageProfileUrl == null ||
                    userProfile.imageProfileUrl == ""
                ? Image.asset(
                    "assets/avatars/profile_image_${isDarkMode ? "dark" : "light"}.png",
                    width: size,
                    height: size,
                    fit: BoxFit.cover,
                    filterQuality: FilterQuality.medium,
                  )
                : Image.network(
                    userProfile.imageProfileUrl!,
                    filterQuality: FilterQuality.medium,
                    width: size,
                    height: size,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Image.asset(
                      "assets/avatars/profile_image_${isDarkMode ? "dark" : "light"}.png",
                      width: size,
                      height: size,
                      fit: BoxFit.cover,
                    ),
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) {
                        return child;
                      }
                      return CircularLoader(width: size, height: size);
                    },
                  ),
          ),
        ),
      ),
    );
  }
}
