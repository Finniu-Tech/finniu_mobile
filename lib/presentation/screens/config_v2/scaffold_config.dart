import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:finniu/presentation/screens/profile_v2/widgets/app_bar_profile.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ScaffoldConfig extends ConsumerWidget {
  const ScaffoldConfig({
    super.key,
    required this.children,
    required this.title,
  });
  final Widget children;
  final String title;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(settingsNotifierProvider).isDarkMode;

    const int backgroundDark = 0xff191919;
    const int backgroundLight = 0xffFFFFFF;
    return Scaffold(
      appBar: AppBarProfile(title: title),
      backgroundColor: isDarkMode
          ? const Color(backgroundDark)
          : const Color(backgroundLight),
      body: SingleChildScrollView(
        child: children,
      ),
    );
  }
}
