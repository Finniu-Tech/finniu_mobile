import 'package:finniu/presentation/observers/network_observer.dart';
import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:finniu/presentation/screens/intro_screen.dart';
import 'package:finniu/routes/routes.dart';
import 'package:finniu/widgets/connectivity.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AppStaging extends ConsumerWidget {
  const AppStaging({super.key});
  static FirebaseAnalytics analytics = FirebaseAnalytics.instance;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

    return MaterialApp(
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
