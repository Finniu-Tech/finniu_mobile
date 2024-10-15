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
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AppProduction extends ConsumerStatefulWidget {
  final PushNotificationService pushNotificationService;
  const AppProduction({super.key, required this.pushNotificationService});
  static FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  @override
  ConsumerState<AppProduction> createState() => _AppProductionState();
}

class _AppProductionState extends ConsumerState<AppProduction> {
  late final DeepLinkHandler _deepLinkHandler;

  @override
  void initState() {
    super.initState();
    _deepLinkHandler = ref.read(deepLinkHandlerProvider);
    _deepLinkHandler.initialize();
  }

  @override
/*************  ✨ Codeium Command ⭐  *************/
  /// Clean up resources used by the app.
  ///
  /// Currently, this doesn't do anything because the
  /// [DeepLinkHandler] doesn't have any resources to clean up, but this method
  /// is here in case it's needed in the future.
/******  8d0720dc-2810-41bb-ad3a-d04e60de101d  *******/ void dispose() {
    // ref.read(deepLinkHandlerProvider).dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

    AppProduction.analytics.setAnalyticsCollectionEnabled(true);

    return MaterialApp(
      navigatorKey: _deepLinkHandler.navigatorKey,
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
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('es', ''),
      ],
      builder: (context, child) {
        return InternetConnectionAlertWidget(
            child: child ?? const SizedBox.shrink());
      },
    );
  }
}
