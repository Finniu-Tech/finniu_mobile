import 'package:finniu/constants/colors.dart';
import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:finniu/presentation/screens/catalog/circular_loader.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:loader_overlay/loader_overlay.dart';

class StepScaffold extends ConsumerWidget {
  const StepScaffold({
    super.key,
    required this.children,
  });
  final Widget children;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(settingsNotifierProvider).isDarkMode;
    const int backgroundDark = 0xff0E0E0E;
    const int backgroundLight = 0xffDEF7FF;
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
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
      child: PopScope(
        child: Scaffold(
          floatingActionButton: const SizedBox(
            height: 80,
          ),
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(
                color: isDarkMode
                    ? const Color(primaryLight)
                    : const Color(primaryDark),
                Icons.arrow_back,
              ),
              onPressed: () => Navigator.of(context).pushNamedAndRemoveUntil(
                '/v2/investment/step-1',
                arguments: {'fund': args['fund']},
                (route) => false,
              ),
            ),
            automaticallyImplyLeading: false,
            backgroundColor: isDarkMode
                ? const Color(backgroundDark)
                : const Color(backgroundLight),
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
      ),
    );
  }
}
