import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:finniu/presentation/screens/catalog/circular_loader.dart';
import 'package:finniu/presentation/screens/profile_v2/widgets/app_bar_profile.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:loader_overlay/loader_overlay.dart';

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
    return LoaderOverlay(
      useDefaultLoading: false,
      overlayWidgetBuilder: (progress) {
        return const Center(
          child: CircularLoader(
            width: 50,
            height: 50,
          ),
        );
      },
      child: Scaffold(
        appBar: AppBarProfile(title: title),
        floatingActionButton: Container(
          width: 0,
          height: 90,
          color: Colors.transparent,
        ),
        backgroundColor: isDarkMode
            ? const Color(backgroundDark)
            : const Color(backgroundLight),
        body: SingleChildScrollView(
          child: children,
        ),
      ),
    );
  }
}
