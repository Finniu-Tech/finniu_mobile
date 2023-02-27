import 'package:finniu/providers/auth_provider.dart';
import 'package:finniu/providers/settings_provider.dart';
import 'package:finniu/services/share_preferences_service.dart';
import 'package:flutter/material.dart';
import 'package:finniu/routes/routes.dart';
import 'package:finniu/screens/intro_screen.dart';
import 'package:flutter/services.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Preferences.init();
  await initHiveForFlutter(); //graphql cache

  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
  // runApp(
  //   MultiProvider(
  //     providers: [
  //       ChangeNotifierProvider(
  //         create: (_) => SettingsProvider(
  //           isDarkMode: Preferences.isDarkMode,
  //           showWelcomeModal: Preferences.showWelcomeModal,
  //         ),
  //       ),
  //       ChangeNotifierProvider(
  //         create: (_) => AuthTokenProvider(token: ''),
  //       ),
  //       ChangeNotifierProvider(create: (_) => UserProvider())
  //     ],
  //     child: const MyApp(),
  //   ),
  // );
  // runApp(const MyApp())
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    final gqlClient = ref.watch(gqlClientProvider);
    return GraphQLProvider(
      client: gqlClient,
      child: MaterialApp(
        title: 'Finniu',
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        // theme: ThemeData.dark(),
        theme: ref.watch(settingsNotifierProvider).currentTheme,
        routes: getApplicationRoutes(),
        onGenerateRoute: (RouteSettings settings) {
          return MaterialPageRoute(
            builder: (BuildContext context) => const IntroScreen(),
          );
        },
      ),
    );
  }
}
