import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:finniu/presentation/screens/catalog/widgets/text_poppins.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ImageProfileStack extends ConsumerWidget {
  const ImageProfileStack({
    super.key,
    required this.fullName,
    required this.email,
    required this.profileImage,
    required this.backgroundImage,
    this.isLoading = false,
  });
  final String fullName;
  final String email;
  final String profileImage;
  final String backgroundImage;
  final bool isLoading;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(settingsNotifierProvider).isDarkMode;
    const int backgroundDark = 0xff191919;
    const int backgroundLight = 0xffFFFFFF;
    const int titleDark = 0xffA2E6FA;
    const int titleLight = 0xff0D3A5C;
    return SizedBox(
      height: 200,
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          backgroundImage.isEmpty
              ? const BackgroundImageHelp()
              : Image.network(
                  backgroundImage,
                  width: MediaQuery.of(context).size.width,
                  height: 100,
                  fit: BoxFit.fill,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) {
                      return child;
                    } else {
                      return const BackgroundImageHelp();
                    }
                  },
                  errorBuilder: (context, error, stackTrace) =>
                      const BackgroundImageHelp(),
                ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: 250,
                child: TextPoppins(
                  text: isLoading ? "Cargando..." : fullName,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  textDark: titleDark,
                  textLight: titleLight,
                  align: TextAlign.center,
                ),
              ),
              TextPoppins(
                text: isLoading ? "Cargando..." : email,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
          Positioned(
            top: 50,
            width: MediaQuery.of(context).size.width / 2,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Container(
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
                    child: profileImage == ""
                        ? const UserImageHelp()
                        : Image.network(
                            profileImage,
                            width: 10,
                            height: 10,
                            loadingBuilder: (context, child, loadingProgress) {
                              if (loadingProgress == null) {
                                return child;
                              } else {
                                return const UserImageHelp();
                              }
                            },
                            errorBuilder: (context, error, stackTrace) =>
                                const UserImageHelp(),
                          ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class UserImageHelp extends ConsumerWidget {
  const UserImageHelp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(settingsNotifierProvider).isDarkMode;
    return Image.asset(
      "assets/avatars/profile_image_${isDarkMode ? "dark" : "light"}.png",
      width: 80,
      height: 80,
    );
  }
}

class BackgroundImageHelp extends ConsumerWidget {
  const BackgroundImageHelp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(settingsNotifierProvider).isDarkMode;
    return Image.asset(
      "assets/backgroud/profile_background_${isDarkMode ? "dark" : "light"}.png",
      width: MediaQuery.of(context).size.width,
      height: 100,
      fit: BoxFit.fill,
    );
  }
}
