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
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:package_info_plus/package_info_plus.dart';

class IntroScreen extends ConsumerStatefulWidget {
  const IntroScreen({super.key});
  @override
  _IntroScreenState createState() => _IntroScreenState();
}

class _IntroScreenState extends ConsumerState<IntroScreen> {
  String appCurrentVersion = '';
  late AppVersionEntity appVersion;
  bool _initialized = false;
  bool _isLoading = true;
  bool _disposed = false;

  @override
  void initState() {
    super.initState();
    _getCurrentAppVersion();
    _initializeApp();
  }

  @override
  void dispose() {
    _disposed = true;
    super.dispose();
  }

  Future<void> _initializeApp() async {
    if (_disposed) return;
    await _getCurrentAppVersion();
    await _waitForGraphQLClient();
    if (_disposed) return;
    await _initializeAppVersion(context);
    if (_disposed) return;
    setState(() {
      _isLoading = false;
    });
  }

  Future<void> _waitForGraphQLClient() async {
    while (!_disposed && ref.read(gqlClientProvider).value == null) {
      await Future.delayed(const Duration(milliseconds: 100));
    }
    if (!_disposed) {
      print("IntroScreen: GraphQL client is ready");
    }
  }

  void _showUpdateModal(BuildContext context, bool isForceUpgrade) {
    if (_disposed) return;
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return UpgradeAppDialog(forcedUpgrade: isForceUpgrade);
      },
    );
  }

  Future<void> _initializeAppVersion(BuildContext context) async {
    if (_initialized || _disposed) {
      return;
    }
    _initialized = true;

    try {
      final client = ref.read(gqlClientProvider).value;
      if (client == null) {
        _proceedToNextScreen();
        return;
      }

      bool isConnected = await InternetConnectionChecker().hasConnection;
      if (!isConnected) {
        if (!_disposed) showNetworkWarning(context: context);
        return;
      }
      appVersion =
          await AppVersionDataSourceImp().getLastVersion(client: client);
      appVersion.currentVersion = appCurrentVersion;
      String statusVersion = appVersion.getStatusVersion();

      if (_disposed) return;

      if (statusVersion == StatusVersion.upgrade) {
        _showUpdateModal(context, false);
      } else if (statusVersion == StatusVersion.forceUpgrade) {
        _showUpdateModal(context, true);
      } else {
        _proceedToNextScreen();
      }
    } catch (e) {
      print("IntroScreen: Error in _initializeAppVersion: $e");
      if (!_disposed) _proceedToNextScreen();
    }
  }

  void _proceedToNextScreen() {
    if (_disposed) {
      return;
    }

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_disposed) return;

      DeepLinkHandler? deepLinkHandler;
      String? savedRoute;

      try {
        deepLinkHandler = ref.read(deepLinkHandlerProvider);
        savedRoute = ref.read(deepLinkRouteProvider);
      } catch (e) {
        print("IntroScreen: Error reading providers: $e");
        _navigateToOnBoarding();
        return;
      }

      if (savedRoute != null) {
        deepLinkHandler?.handleDeepLink(
            Uri.parse('finniuappstaging://finniu.com$savedRoute'));
      } else {
        _navigateToOnBoarding();
      }
    });
  }

  void _navigateToOnBoarding() {
    if (!mounted) return;
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (BuildContext context) => const OnBoardingScreen(),
      ),
    );
  }

  Future<void> _getCurrentAppVersion() async {
    if (_disposed) return;
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    if (_disposed) return;
    setState(() {
      appCurrentVersion = packageInfo.version;
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = ref.watch(settingsNotifierProvider);

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
