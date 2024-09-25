import 'dart:async';
import 'package:finniu/main.dart';
import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:finniu/presentation/screens/on_boarding_v2/widgets/page_one.dart';
import 'package:finniu/presentation/screens/on_boarding_v2/widgets/positiones_column.dart';
import 'package:finniu/widgets/fonts.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:package_info_plus/package_info_plus.dart';

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
  String appCurrentVersion = '';

  Future<void> _getCurrentAppVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    setState(() {
      appCurrentVersion = packageInfo.version;
    });
  }

  @override
  void initState() {
    super.initState();
    _startAutoScroll();
    _getCurrentAppVersion();
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

  void pushLogin() => Navigator.pushNamed(context, '/v2/login_email');
  void pushRegister() => Navigator.pushNamed(context, '/v2/register');

  @override
  Widget build(BuildContext context) {
    final themeProvider = ref.watch(settingsNotifierProvider);
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
          Positioned(
            top: 40,
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 40,
              child: VersionAppSectionWidget(themeProvider: themeProvider, version: appCurrentVersion),
            ),
          ),
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

class VersionAppSectionWidget extends StatelessWidget {
  const VersionAppSectionWidget({super.key, required this.themeProvider, required this.version});

  final SettingsProviderState themeProvider;
  final String version;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Text(
            'V$version',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 12,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          if (appConfig.environment != 'production') ...[
            const SizedBox(width: 5),
            TextPoppins(
              text: appConfig.environment,
              colorText: 0xffff0000,
              fontSize: 10,
              fontWeight: FontWeight.w500,
            ),
          ],
        ],
      ),
    );
  }
}
