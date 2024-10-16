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

class AppStaging extends ConsumerStatefulWidget {
  final PushNotificationService pushNotificationService;
  static FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  const AppStaging({super.key, required this.pushNotificationService});

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
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    AppStaging.analytics.setAnalyticsCollectionEnabled(true);

    return MaterialApp(
      navigatorKey: _deepLinkHandler.navigatorKey,
      title: 'Finniu Staging',
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      theme: ref.watch(settingsNotifierProvider).currentTheme,
      routes: getApplicationRoutes(),
      navigatorObservers: [
        FirebaseAnalyticsObserver(analytics: AppStaging.analytics),
        ConnectionAwareNavigatorObserver(),
      ],
      onGenerateRoute: (RouteSettings settings) {
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
        WidgetsBinding.instance.addPostFrameCallback((_) {
          _deepLinkHandler.processPendingNavigations();
        });

        return InternetConnectionAlertWidget(child: child ?? const SizedBox.shrink());
      },
    );
  }
}
