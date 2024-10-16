import 'dart:async';
import 'package:finniu/domain/entities/app_version_entity.dart';
import 'package:finniu/infrastructure/datasources/app_version_datasource_imp.dart';
import 'package:finniu/presentation/providers/graphql_provider.dart';
import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:finniu/presentation/screens/catalog/widgets/snackbar/network_warning.dart';
import 'package:finniu/presentation/screens/on_boarding_v2/on_boarding_screen_v2.dart';
import 'package:finniu/services/deep_link_service.dart';
import 'package:finniu/widgets/fonts.dart';
import 'package:finniu/widgets/upgrade_modal.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:package_info_plus/package_info_plus.dart';

class IntroScreen extends ConsumerStatefulWidget {
  const IntroScreen({Key? key}) : super(key: key);
  @override
  _IntroScreenState createState() => _IntroScreenState();
}

class _IntroScreenState extends ConsumerState<IntroScreen> {
  String appCurrentVersion = '';
  late AppVersionEntity appVersion;
  bool _initialized = false;

  @override
  void initState() {
    super.initState();
    _getCurrentAppVersion();
    print("IntroScreen: initState called");
  }

  void _showUpdateModal(BuildContext context, bool isForceUpgrade) {
    print("IntroScreen: Showing update modal, forceUpgrade: $isForceUpgrade");
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return UpgradeAppDialog(forcedUpgrade: isForceUpgrade);
      },
    );
  }

  Future<void> _initializeAppVersion(BuildContext context) async {
    print("IntroScreen: _initializeAppVersion called");
    if (_initialized) {
      print("IntroScreen: Already initialized, returning");
      return;
    }
    _initialized = true;

    try {
      final client = ref.read(gqlClientProvider).value;
      if (client == null) {
        print("IntroScreen: GraphQL client is null");
        _proceedToNextScreen(context);
        return;
      }

      bool isConnected = await InternetConnectionChecker().hasConnection;
      if (!isConnected) {
        print("IntroScreen: No internet connection");
        showNetworkWarning(context: context);
        return;
      }

      appVersion = await AppVersionDataSourceImp().getLastVersion(client: client);
      appVersion.currentVersion = appCurrentVersion;
      String statusVersion = appVersion.getStatusVersion();
      print("IntroScreen: Status version: $statusVersion");

      if (statusVersion == StatusVersion.upgrade) {
        _showUpdateModal(context, false);
      } else if (statusVersion == StatusVersion.forceUpgrade) {
        _showUpdateModal(context, true);
      } else {
        print("IntroScreen: No update needed, proceeding to next screen");
        _proceedToNextScreen(context);
      }
    } catch (e) {
      print("IntroScreen: Error in _initializeAppVersion: $e");
      _proceedToNextScreen(context);
    }
  }

  void _proceedToNextScreen(BuildContext context) {
    print("IntroScreen: _proceedToNextScreen called");
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final deepLinkHandler = ref.read(deepLinkHandlerProvider);
      final savedRoute = ref.read(deepLinkRouteProvider);

      if (savedRoute != null) {
        print("IntroScreen: Processing saved deep link: $savedRoute");
        deepLinkHandler.handleDeepLink(Uri.parse('finniuappstaging://finniu.com$savedRoute'));
        // No limpiamos el savedRoute aquí, se hará después de procesarlo completamente
      } else {
        print("IntroScreen: Navigating to OnBoardingScreen");
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (BuildContext context) => OnBoardingScreen(),
          ),
        );
      }
    });
  }

  Future<void> _getCurrentAppVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    setState(() {
      appCurrentVersion = packageInfo.version;
    });
    print("IntroScreen: Current app version: $appCurrentVersion");
  }

  @override
  Widget build(BuildContext context) {
    print("IntroScreen: build method called");
    final themeProvider = ref.watch(settingsNotifierProvider);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initializeAppVersion(context);
    });

    return Scaffold(
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
    );
  }
}
