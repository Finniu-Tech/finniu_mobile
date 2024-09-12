import 'dart:async';
import 'package:finniu/constants/colors.dart';
import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:finniu/presentation/screens/catalog/widgets/text_poppins.dart';
import 'package:finniu/presentation/screens/on_boarding_v2/widgets/page_one.dart';
import 'package:finniu/presentation/screens/on_boarding_v2/widgets/positiones_column.dart';
import 'package:finniu/services/share_preferences_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class OnBoardingScreen extends ConsumerWidget {
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Scaffold(
      body: SingleChildScrollView(
        child: StackOnBoarding(),
      ),
    );
  }
}

class StackOnBoarding extends ConsumerStatefulWidget {
  const StackOnBoarding({
    super.key,
  });

  @override
  StackOnBoardingState createState() => StackOnBoardingState();
}

class StackOnBoardingState extends ConsumerState<StackOnBoarding> {
  int _index = 0;
  final PageController _controller = PageController(
    initialPage: 0,
    keepPage: false,
    viewportFraction: 1.0,
  );
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startAutoScroll();
  }

  void _startAutoScroll() {
    _timer = Timer.periodic(const Duration(seconds: 2), (Timer timer) {
      if (_index < 4) {
        _index++;
      } else {
        _timer?.cancel();
      }
      _controller.animateToPage(
        _index,
        duration: const Duration(milliseconds: 800),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  void pushLogin() => Navigator.pushNamed(context, '/login_email');
  void pushRegister() => Navigator.pushNamed(context, '/v2/register');

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: Stack(
        children: [
          PageView(
            controller: _controller,
            onPageChanged: (value) => setState(() => _index = value),
            children: const [
              PageOneContainer(),
              PageTwoContainer(),
              PageThreeContainer(),
              PageFourContainer(),
              PageFiveContainer(),
            ],
          ),
          _index == 0 ? const SwitchTheme() : const SizedBox(),
          Positioned(
            bottom: 25,
            child: PositionedColumn(
              index: _index,
              pushLogin: pushLogin,
              pushRegister: pushRegister,
            ),
          ),
        ],
      ),
    );
  }
}

class SwitchTheme extends ConsumerWidget {
  const SwitchTheme({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.read(settingsNotifierProvider.notifier);
    final isDarkMode = ref.watch(settingsNotifierProvider).isDarkMode;
    return Positioned(
      top: MediaQuery.of(context).size.height * 0.1,
      right: 20,
      child: Row(
        children: [
          TextPoppins(
            text: isDarkMode ? 'Dark mode' : 'Light mode',
            fontSize: 10,
            isBold: true,
          ),
          const SizedBox(width: 10),
          FlutterSwitch(
            width: 45,
            height: 24,
            value: isDarkMode ? true : false,
            inactiveColor: const Color(primaryDark),
            activeColor: const Color(primaryLight),
            inactiveToggleColor: const Color(primaryLight),
            activeToggleColor: const Color(primaryDark),
            onToggle: (value) {
              Preferences.isDarkMode = value;
              value ? settings.setDarkMode() : settings.setLightMode();
            },
          ),
        ],
      ),
    );
  }
}
