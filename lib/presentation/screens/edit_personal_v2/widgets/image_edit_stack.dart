import 'dart:io';
import 'package:finniu/presentation/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:finniu/presentation/providers/add_voucher_provider.dart';
import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:finniu/presentation/screens/catalog/helpers/add_image.dart';
import 'package:finniu/presentation/screens/profile_v2/widgets/image_profile.dart';

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
    const int backgroundImage = 0xffC1F1FF;

    return SizedBox(
      height: 130,
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: 64,
            color: const Color(backgroundImage),
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
                            fit: BoxFit.fill,
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

class PickImageEditStack extends ConsumerWidget {
  const PickImageEditStack({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(settingsNotifierProvider).isDarkMode;
    final userProfile = ref.watch(userProfileNotifierProvider);
    final String? imagePath = ref.watch(imagePathProvider);
    const int backgroundDark = 0xff191919;
    const int backgroundLight = 0xffFFFFFF;
    const int backgroundImage = 0xffC1F1FF;
    const int iconDark = 0xffA2E6FA;
    const int iconLight = 0xff0D3A5C;

    return SizedBox(
      height: 130,
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: 64,
            color: const Color(backgroundImage),
          ),
          Positioned(
            top: 25,
            width: MediaQuery.of(context).size.width / 2,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: isDarkMode
                          ? const Color(backgroundDark)
                          : const Color(backgroundLight),
                      width: 8,
                    ),
                  ),
                  child: ClipOval(
                    child: userProfile.imageProfileUrl == "" ||
                            userProfile.imageProfileUrl == null
                        ? const UserImageHelp()
                        : Image.network(
                            userProfile.imageProfileUrl!,
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
                            fit: BoxFit.fill,
                          ),
                  ),
                ),
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.transparent,
                      width: 8,
                    ),
                  ),
                  child: ClipOval(
                    child: imagePath != null
                        ? GestureDetector(
                            onTap: () {
                              addImage(context: context, ref: ref);
                            },
                            child: ClipOval(
                              clipBehavior: Clip.hardEdge,
                              child: Image.file(
                                File(imagePath),
                                fit: BoxFit.fill,
                                width: 80,
                                height: 80,
                              ),
                            ),
                          )
                        : GestureDetector(
                            onTap: () {
                              addImage(context: context, ref: ref);
                            },
                            child: Container(
                              width: 80,
                              height: 80,
                              decoration: BoxDecoration(
                                color: isDarkMode
                                    ? const Color(iconDark).withOpacity(0.3)
                                    : const Color(iconDark).withOpacity(0.3),
                                borderRadius: BorderRadius.circular(100),
                              ),
                              child: Center(
                                child: SvgPicture.asset(
                                  "assets/svg_icons/gallery_add_icon_v2.svg",
                                  width: 30,
                                  height: 30,
                                  color: isDarkMode
                                      ? const Color(iconLight)
                                      : const Color(iconLight),
                                ),
                              ),
                            ),
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

class IconEditStack extends ConsumerWidget {
  const IconEditStack({
    super.key,
    required this.svgUrl,
    required this.backgroundImage,
    this.isLoading = false,
  });

  final String svgUrl;
  final bool isLoading;
  final int backgroundImage;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(settingsNotifierProvider).isDarkMode;
    const int backgroundDark = 0xff191919;
    const int backgroundLight = 0xffFFFFFF;
    const int iconDark = 0xffA2E6FA;
    const int iconLight = 0xff0D3A5C;

    return SizedBox(
      height: 130,
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: 64,
            color: Color(backgroundImage),
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
                    color: isDarkMode
                        ? const Color(backgroundDark)
                        : const Color(backgroundLight),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: SvgPicture.asset(
                      svgUrl,
                      width: 30,
                      height: 30,
                      color: isDarkMode
                          ? const Color(iconDark)
                          : const Color(iconLight),
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
