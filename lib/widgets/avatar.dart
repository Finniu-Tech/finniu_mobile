import 'package:finniu/constants/colors.dart';
import 'package:finniu/providers/settings_provider.dart';
import 'package:finniu/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class CircularPercentAvatarWidget extends ConsumerWidget {
  const CircularPercentAvatarWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final themeProvider = ref.watch(settingsNotifierProvider);
    return CircularPercentIndicator(
      radius: 25.0,
      lineWidth: 10.0,
      // header:
      percent: 0.5,
      center: CircleAvatar(
        radius: 22, // Image radius
        backgroundImage: NetworkImage(
          ref.watch(userProfileNotifierProvider).imageProfileUrl ??
              "https://e7.pngegg.com/pngimages/84/165/png-clipart-united-states-avatar-organization-information-user-avatar-service-computer-wallpaper-thumbnail.png",
        ),
      ),

      progressColor:
          Color(themeProvider.isDarkMode ? primaryLight : primaryDark),
      backgroundColor:
          Color(themeProvider.isDarkMode ? primaryDark : primaryLight),
      // fillColor: Color(primaryLight),
    );
  }
}
