import 'package:finniu/presentation/observers/network_observer.dart';
import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:finniu/presentation/screens/intro_screen.dart';
import 'package:finniu/routes/routes.dart';
import 'package:finniu/services/deep_link_service.dart';
import 'package:finniu/widgets/connectivity.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AppProduction extends ConsumerStatefulWidget {
  const AppProduction({Key? key}) : super(key: key);

  static FirebaseAnalytics analytics = FirebaseAnalytics.instance;

  @override
  ConsumerState<AppProduction> createState() => _AppProductionState();
}

class _AppProductionState extends ConsumerState<AppProduction> {
  final _navigatorKey = GlobalKey<NavigatorState>();

  @override
  void initState() {
    super.initState();
    ref.read(deepLinkHandlerProvider).initialize();
  }

  @override
  void dispose() {
    ref.read(deepLinkHandlerProvider).dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

    return MaterialApp(
      navigatorKey: _navigatorKey,
      title: 'Finniu',
      debugShowCheckedModeBanner: false,
      navigatorObservers: [
        FirebaseAnalyticsObserver(analytics: AppProduction.analytics),
        ConnectionAwareNavigatorObserver(),
      ],
      initialRoute: '/',
      theme: ref.watch(settingsNotifierProvider).currentTheme,
      routes: getApplicationRoutes(),
      onGenerateRoute: (RouteSettings settings) {
        // Aquí puedes manejar rutas dinámicas si es necesario
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
