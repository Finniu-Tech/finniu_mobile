import 'package:finniu/presentation/providers/nabbar_provider.dart';
import 'package:finniu/presentation/providers/navigator_provider.dart';
import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:finniu/presentation/screens/catalog/circular_loader.dart';
import 'package:finniu/presentation/screens/catalog/widgets/send_proof_button.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:loader_overlay/loader_overlay.dart';

class StepScaffold extends ConsumerWidget {
  const StepScaffold({
    super.key,
    required this.children,
    this.useDefaultLoading = false,
  });
  final bool useDefaultLoading;
  final Widget children;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(settingsNotifierProvider).isDarkMode;
    const int backgroundDark = 0xff0E0E0E;
    const int backgroundLight = 0xffDEF7FF;
    const int iconLight = 0xff0D3A5C;
    const int iconDark = 0xffA2E6FA;
    return PopScope(
      canPop: false,
      child: LoaderOverlay(
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
          bottomNavigationBar: Container(
            height: 70,
            color: isDarkMode ? const Color(backgroundDark) : const Color(backgroundLight),
            child: Center(
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.85,
                height: 50,
                child: const NavBarButton(),
              ),
            ),
          ),
          appBar: AppBar(
            automaticallyImplyLeading: useDefaultLoading,
            leading: IconButton(
              onPressed: () => {
                ScaffoldMessenger.of(context).clearSnackBars(),
                ref.read(navigatorStateProvider.notifier).state = 0,
                Navigator.pushNamedAndRemoveUntil(context, '/v4/home', (route) => false),
              },
              icon: Icon(
                Icons.arrow_back,
                color: isDarkMode ? const Color(iconDark) : const Color(iconLight),
              ),
            ),
            backgroundColor: isDarkMode ? const Color(backgroundDark) : const Color(backgroundLight),
          ),
          backgroundColor: isDarkMode ? const Color(backgroundDark) : const Color(backgroundLight),
          body: GestureDetector(
            onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
            child: SingleChildScrollView(
              child: children,
            ),
          ),
        ),
      ),
    );
  }
}

class Step2Scaffold extends ConsumerWidget {
  const Step2Scaffold({
    super.key,
    required this.children,
    this.useDefaultLoading = false,
    required this.onPressedButton, // Add this parameter
  });
  final bool useDefaultLoading;
  final Widget children;
  final VoidCallback onPressedButton;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(settingsNotifierProvider).isDarkMode;
    const int backgroundDark = 0xff0E0E0E;
    const int backgroundLight = 0xffDEF7FF;
    const int iconLight = 0xff0D3A5C;
    const int iconDark = 0xffA2E6FA;
    return PopScope(
      canPop: false,
      child: LoaderOverlay(
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
          bottomNavigationBar: Container(
            height: 70,
            color: isDarkMode ? const Color(backgroundDark) : const Color(backgroundLight),
            child: Center(
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.85,
                height: 50,
                child: ButtonInvestment(
                  text: 'Enviar constancia',
                  onPressed: onPressedButton,
                ),
              ),
            ),
          ),
          appBar: AppBar(
            automaticallyImplyLeading: useDefaultLoading,
            leading: IconButton(
              onPressed: () => {
                ScaffoldMessenger.of(context).clearSnackBars(),
                ref.read(navigatorStateProvider.notifier).state = 0,
                Navigator.pushNamedAndRemoveUntil(context, '/v4/home', (route) => false),
              },
              icon: Icon(
                Icons.arrow_back,
                color: isDarkMode ? const Color(iconDark) : const Color(iconLight),
              ),
            ),
            backgroundColor: isDarkMode ? const Color(backgroundDark) : const Color(backgroundLight),
          ),
          backgroundColor: isDarkMode ? const Color(backgroundDark) : const Color(backgroundLight),
          body: GestureDetector(
            onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
            child: SingleChildScrollView(
              child: children,
            ),
          ),
        ),
      ),
    );
  }
}

class ReinvestScaffold extends ConsumerWidget {
  const ReinvestScaffold({
    super.key,
    required this.children,
    this.useDefaultLoading = false,
  });
  final bool useDefaultLoading;
  final Widget children;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.read(settingsNotifierProvider).isDarkMode;

    const int backgroundDark = 0xff0E0E0E;
    const int backgroundLight = 0xffDEF7FF;
    const int iconLight = 0xff0D3A5C;
    const int iconDark = 0xffA2E6FA;
    return PopScope(
      canPop: false,
      child: LoaderOverlay(
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
          bottomNavigationBar: Container(
            height: 70,
            color: isDarkMode ? const Color(backgroundDark) : const Color(backgroundLight),
            child: Center(
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.85,
                height: 50,
                child: const NavBarButton(),
              ),
            ),
          ),
          appBar: AppBar(
            automaticallyImplyLeading: useDefaultLoading,
            leading: IconButton(
              onPressed: () => {
                ScaffoldMessenger.of(context).clearSnackBars(),
                ref.read(navigatorStateProvider.notifier).state = 0,
                // Navigator.pushNamedAndRemoveUntil(context, '/v4/home', (route) => false),
                Navigator.pop(context),
              },
              icon: Icon(
                Icons.arrow_back,
                color: isDarkMode ? const Color(iconDark) : const Color(iconLight),
              ),
            ),
            backgroundColor: isDarkMode ? const Color(backgroundDark) : const Color(backgroundLight),
          ),
          backgroundColor: isDarkMode ? const Color(backgroundDark) : const Color(backgroundLight),
          body: GestureDetector(
            onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
            child: SingleChildScrollView(
              child: children,
            ),
          ),
        ),
      ),
    );
  }
}

class NavBarButton extends ConsumerWidget {
  const NavBarButton({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final navBarProvider = ref.watch(nabbarProvider);
    return ButtonInvestment(
      text: navBarProvider.title,
      onPressed: navBarProvider.onTap,
    );
  }
}
