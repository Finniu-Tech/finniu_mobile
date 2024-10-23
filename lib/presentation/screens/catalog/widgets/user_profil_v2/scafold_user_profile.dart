import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:finniu/presentation/screens/catalog/circular_loader.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:loader_overlay/loader_overlay.dart';

class ScaffoldUserProfile extends ConsumerWidget {
  const ScaffoldUserProfile({
    super.key,
    required this.children,
    this.appBar,
    this.bottomNavigationBar,
    this.floatingActionButton,
    this.mainAxisAlignment,
    this.crossAxisAlignment,
  });
  final PreferredSizeWidget? appBar;
  final Widget? bottomNavigationBar;
  final Widget? floatingActionButton;
  final List<Widget> children;
  final MainAxisAlignment? mainAxisAlignment;
  final CrossAxisAlignment? crossAxisAlignment;
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
        appBar: appBar ?? const AppBarNull(),
        bottomNavigationBar: bottomNavigationBar,
        floatingActionButton: floatingActionButton,
        backgroundColor: isDarkMode
            ? const Color(backgroundDark)
            : const Color(backgroundLight),
        body: GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: SingleChildScrollView(
            child: Center(
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.85,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  child: Column(
                    mainAxisAlignment:
                        mainAxisAlignment ?? MainAxisAlignment.spaceAround,
                    crossAxisAlignment:
                        crossAxisAlignment ?? CrossAxisAlignment.start,
                    children: children,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class AppBarNull extends ConsumerWidget implements PreferredSizeWidget {
  const AppBarNull({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(settingsNotifierProvider).isDarkMode;
    const int backgroundDark = 0xff191919;
    const int backgroundLight = 0xffFFFFFF;
    return AppBar(
      backgroundColor: isDarkMode
          ? const Color(backgroundDark)
          : const Color(backgroundLight),
      automaticallyImplyLeading: true,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 1.0);
}
