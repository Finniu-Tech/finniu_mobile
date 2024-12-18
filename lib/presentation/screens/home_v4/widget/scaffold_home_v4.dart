import 'package:finniu/presentation/providers/notification_provider.dart';
import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:finniu/presentation/providers/user_provider.dart';
import 'package:finniu/presentation/screens/home_v4/push_notifications/push_helpers.dart';
import 'package:finniu/presentation/screens/home_v4/widget/app_bar_v4.dart';
import 'package:finniu/presentation/screens/home_v4/widget/nav_bar_v4.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:loader_overlay/loader_overlay.dart';

class ScaffoldHomeV4 extends HookConsumerWidget {
  const ScaffoldHomeV4({super.key, required this.body});
  final Widget body;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.read(userProfileNotifierProvider);
    final userProfileAsync = ref.watch(userProfileFutureProvider);
    final setupState = ref.watch(notificationSetupStateNotifierProvider);

    useEffect(() {
      context.loaderOverlay.show();

      userProfileAsync.whenData((profile) async {
        if (profile.id != null && !setupState.isInitialized) {
          await initializeNotifications(context, ref, profile);
        }
        context.loaderOverlay.hide();
      });
      return null;
    }, [userProfileAsync]);
    final isDarkMode = ref.watch(settingsNotifierProvider).isDarkMode;
    const int colorDark = 0xff000000;
    const int colorLight = 0xffFFFFFF;
    return PopScope(
      canPop: false,
      child: LoaderOverlay(
        useDefaultLoading: false,
        overlayWidgetBuilder: (progress) {
          return const Center(
            child: LogoLoader(
              width: 100,
              height: 100,
            ),
          );
        },
        child: Scaffold(
          backgroundColor:
              isDarkMode ? const Color(colorDark) : const Color(colorLight),
          extendBody: true,
          bottomNavigationBar: const NavBarV4(),
          appBar: const CustomAppBarV4(),
          body: SingleChildScrollView(
            child: Center(
              child: body,
            ),
          ),
        ),
      ),
    );
  }
}

class LogoLoader extends ConsumerWidget {
  const LogoLoader({super.key, required this.width, required this.height});
  final double width;
  final double height;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(settingsNotifierProvider).isDarkMode;
    const int colorDark = 0xffA2E6FA;
    const int colorLight = 0xff0D3A5C;
    return SizedBox(
      width: width,
      height: height,
      child: Stack(
        alignment: Alignment.center,
        children: [
          SizedBox(
            width: width,
            height: height,
            child: CircularProgressIndicator(
              color:
                  isDarkMode ? const Color(colorDark) : const Color(colorLight),
            ),
          ),
          Center(
            child: Image.asset(
              "assets/images/logo_finniu_${isDarkMode ? "dark" : "light"}.png",
              width: width,
              height: height,
            ),
          ),
        ],
      ),
    );
  }
}
