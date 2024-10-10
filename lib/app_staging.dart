import 'package:finniu/presentation/observers/network_observer.dart';
import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:finniu/presentation/screens/intro_screen.dart';
import 'package:finniu/routes/routes.dart';
import 'package:finniu/services/deep_link_service.dart';
import 'package:finniu/services/push_notifications_service.dart';
import 'package:finniu/widgets/connectivity.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AppStaging extends ConsumerStatefulWidget {
  final PushNotificationService pushNotificationService;

  AppStaging({Key? key, required this.pushNotificationService}) : super(key: key);

  static FirebaseAnalytics analytics = FirebaseAnalytics.instance;

  @override
  ConsumerState<AppStaging> createState() => _AppStagingState();
}

class _AppStagingState extends ConsumerState<AppStaging> {
  late final DeepLinkHandler _deepLinkHandler;

  @override
  void initState() {
    super.initState();
    _deepLinkHandler = ref.read(deepLinkHandlerProvider);
    _deepLinkHandler.initialize();
  }

  @override
  void dispose() {
    // ref.read(deepLinkHandlerProvider).dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

    return MaterialApp(
      navigatorKey: _deepLinkHandler.navigatorKey,
      title: 'Finniu Staging',
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      theme: ref.watch(settingsNotifierProvider).currentTheme,
      routes: getApplicationRoutes(),
      navigatorObservers: [
        ConnectionAwareNavigatorObserver(),
      ],
      onGenerateRoute: (RouteSettings settings) {
        return MaterialPageRoute(
          builder: (BuildContext context) => const IntroScreen(),
        );
      },
      builder: (context, child) {
        return InternetConnectionAlertWidget(child: child ?? const SizedBox.shrink());
      },
    );
  }
}
