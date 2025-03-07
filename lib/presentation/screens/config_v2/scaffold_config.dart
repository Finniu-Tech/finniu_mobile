import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:finniu/presentation/screens/catalog/circular_loader.dart';
import 'package:finniu/presentation/screens/investment_process.dart/widgets/step_scaffolf.dart';
import 'package:finniu/presentation/screens/profile_v2/widgets/app_bar_profile.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:loader_overlay/loader_overlay.dart';

class ScaffoldConfig extends ConsumerWidget {
  const ScaffoldConfig({
    super.key,
    required this.children,
    required this.title,
    this.floatingNull = false,
  });
  final Widget children;
  final String title;
  final bool floatingNull;
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
        floatingActionButton: floatingNull
            ? null
            : Container(
                width: 0,
                height: 60,
                color: Colors.transparent,
              ),
        appBar: AppBarProfile(title: title),
        backgroundColor: isDarkMode
            ? const Color(backgroundDark)
            : const Color(backgroundLight),
        body: GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: SingleChildScrollView(
            child: children,
          ),
        ),
      ),
    );
  }
}

class ScaffoldAddAcount extends ConsumerWidget {
  const ScaffoldAddAcount({
    super.key,
    required this.children,
    required this.title,
    this.floatingNull = false,
  });
  final Widget children;
  final String title;
  final bool floatingNull;
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
        bottomNavigationBar: Container(
          height: 70,
          color: isDarkMode
              ? const Color(backgroundDark)
              : const Color(backgroundLight),
          child: Center(
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.85,
              height: 50,
              child: const NavBarButton(),
            ),
          ),
        ),
        backgroundColor: isDarkMode
            ? const Color(backgroundDark)
            : const Color(backgroundLight),
        body: GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: SingleChildScrollView(
            child: children,
          ),
        ),
      ),
    );
  }
}
