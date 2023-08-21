import 'dart:async';
import 'package:finniu/domain/entities/app_version_entity.dart';
import 'package:finniu/infrastructure/datasources/app_version_datasource_imp.dart';
import 'package:finniu/presentation/providers/graphql_provider.dart';
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
  String appCurrentVersion = '';
  late AppVersionEntity appVersion;
  _IntroScreenState();

  @override
  initState() {
    super.initState();
    _getCurrentAppVersion();
  }

  void _showUpdateModal(BuildContext context, bool isForceUpgrade) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return UpgradeAppDialog(forcedUpgrade: isForceUpgrade);
      },
    );
  }

  Future<void> _getCurrentAppVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    setState(() {
      appCurrentVersion = packageInfo.version;
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = ref.watch(settingsNotifierProvider);
    final client = ref.watch(gqlClientProvider).value;

    Timer(const Duration(seconds: 3), () async {
      appVersion =
          await AppVersionDataSourceImp().getLastVersion(client: client!);
      appVersion.currentVersion = appCurrentVersion;
      String statusVersion = appVersion.getStatusVersion();
      if (statusVersion == StatusVersion.upgrade) {
        _showUpdateModal(context, false);
      } else if (statusVersion == StatusVersion.forceUpgrade) {
        _showUpdateModal(context, true);
      } else {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (BuildContext context) => StartLoginScreen(),
          ),
        );
      }
    });

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
