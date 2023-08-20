import 'dart:async';
import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:finniu/widgets/fonts.dart';
import 'package:finniu/widgets/upgrade_modal.dart';
import 'package:flutter/material.dart';
import 'package:finniu/presentation/screens/login/start_screen.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:package_info_plus/package_info_plus.dart';

class IntroScreen extends ConsumerStatefulWidget {
  const IntroScreen({Key? key}) : super(key: key);
  @override
  // ignore: library_private_types_in_public_api
  _IntroScreenState createState() => _IntroScreenState();
}

class _IntroScreenState extends ConsumerState<IntroScreen> {
  String appVersion = '';
  _IntroScreenState();

  @override
  void initState() {
    super.initState();
    _getAppVersion();
  }

  void _showUpdateModal(BuildContext context, String appVersion) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return UpgradeAppDialog(appVersion: appVersion);
      },
    );
  }

  Future<void> _getAppVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    setState(() {
      appVersion = packageInfo.version;
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = ref.watch(settingsNotifierProvider);

    Timer(
        const Duration(seconds: 3), () => _showUpdateModal(context, appVersion)
        // () => Navigator.of(context).pushReplacement(
        //   MaterialPageRoute(
        //     builder: (BuildContext context) => StartLoginScreen(),
        //   ),
        // ),
        );

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: Theme.of(context),
      home: Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: 300,
                  height: 300,
                  child: Image(
                    image: AssetImage(
                      themeProvider.isDarkMode
                          ? "assets/images/logo_finniu_dark.png"
                          : "assets/images/logo_finniu_light.png",
                    ),
                  ),
                ),
                TextPoppins(
                  text: 'Vive el #ModoFinniu',
                  colorText: Theme.of(context).colorScheme.secondary.value,
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                ),
                const SizedBox(height: 40.0),
                const SpinKitCircle(
                  color: Colors.grey,
                  size: 50.0,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
