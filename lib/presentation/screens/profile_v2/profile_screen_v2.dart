import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:finniu/presentation/providers/user_provider.dart';
import 'package:finniu/presentation/screens/catalog/widgets/text_poppins.dart';
import 'package:finniu/presentation/screens/profile_v2/widgets/app_bar_profile.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class UserProfileV2 extends ConsumerWidget {
  const UserProfileV2({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(settingsNotifierProvider).isDarkMode;
    const int backgroundDark = 0xff191919;
    const int backgroundLight = 0xffFFFFFF;
    return Scaffold(
      appBar: const AppBarProfile(title: "Mi perfil"),
      backgroundColor: isDarkMode
          ? const Color(backgroundDark)
          : const Color(backgroundLight),
      body: const SingleChildScrollView(
        child: _BodyProfile(),
      ),
    );
  }
}

class _BodyProfile extends ConsumerWidget {
  const _BodyProfile({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userProfile = ref.watch(userProfileNotifierProvider);
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ImageProfileStack(),
      ],
    );
  }
}

class ImageProfileStack extends ConsumerWidget {
  const ImageProfileStack({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(settingsNotifierProvider).isDarkMode;
    const int backgroundDark = 0xff191919;
    const int backgroundLight = 0xffFFFFFF;
    return SizedBox(
      height: 200,
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          Image.asset(
            "assets/backgroud/profile_background_${isDarkMode ? "dark" : "light"}.png",
            width: MediaQuery.of(context).size.width,
            height: 100,
            fit: BoxFit.fill,
          ),
          const Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextPoppins(text: "mariana", fontSize: 16, isBold: true),
              TextPoppins(text: "mariana", fontSize: 15, isBold: true),
            ],
          ),
          Positioned(
            top: 50,
            width: MediaQuery.of(context).size.width / 2,
            child: Container(
              width: 90,
              height: 90,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isDarkMode
                      ? const Color(backgroundDark)
                      : const Color(backgroundLight),
                  width: 10,
                ),
              ),
              child: ClipOval(
                child: Image.asset(
                  "assets/avatars/profile_image_${isDarkMode ? "dark" : "light"}.png",
                  width: 80,
                  height: 80,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
