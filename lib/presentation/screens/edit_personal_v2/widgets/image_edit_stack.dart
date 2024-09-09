import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:finniu/presentation/screens/profile_v2/widgets/image_profile.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ImageEditStack extends ConsumerWidget {
  const ImageEditStack({
    super.key,
    required this.profileImage,
    this.isLoading = false,
  });

  final String profileImage;

  final bool isLoading;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(settingsNotifierProvider).isDarkMode;
    const int backgroundDark = 0xff191919;
    const int backgroundLight = 0xffFFFFFF;
    const int backgroundImageDark = 0xff191919;
    const int backgroundImageLight = 0xffC1F1FF;

    return SizedBox(
      height: 130,
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: 64,
            color: isDarkMode
                ? const Color(backgroundImageDark)
                : const Color(backgroundImageLight),
          ),
          Positioned(
            top: 25,
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
