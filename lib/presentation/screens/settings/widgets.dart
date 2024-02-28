import 'dart:io';

import 'package:finniu/constants/colors.dart';
import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class IconContainer extends StatelessWidget {
  final String image;

  const IconContainer({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 46.48,
      height: 34.87,
      decoration: BoxDecoration(
        color: Color(primaryDark),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Image.asset(
        image,
        width: 30,
        height: 30,
      ),
    );
  }
}

class CircularPercentAvatar extends ConsumerWidget {
  const CircularPercentAvatar({
    Key? key,
    required this.percentage,
    required this.imageFile,
  }) : super(key: key);

  final ValueNotifier<double> percentage;
  final ValueNotifier<String> imageFile;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeProvider = ref.watch(settingsNotifierProvider);
    final imageUrl = imageFile.value;

    return CircularPercentIndicator(
      radius: 50.0,
      lineWidth: 10.0,
      circularStrokeCap: CircularStrokeCap.round,
      percent: percentage.value,
      center: CircleAvatar(
        radius: 40, // Image radius
        backgroundImage: imageUrl.isNotEmpty
            ? _isNetworkUrl(imageUrl)
                ? NetworkImage(imageUrl) as ImageProvider
                : FileImage(File(imageUrl))
            : const AssetImage(
                'assets/images/avatar_alone_v2.png',
              ),
      ),
      progressColor:
          Color(themeProvider.isDarkMode ? primaryLight : primaryDark),
      backgroundColor:
          Color(themeProvider.isDarkMode ? primaryDark : primaryLight),
    );
  }

  bool _isNetworkUrl(String url) {
    return url.startsWith('http://') || url.startsWith('https://');
  }
}

