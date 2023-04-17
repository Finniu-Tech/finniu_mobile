import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:finniu/services/share_preferences_service.dart';
import 'package:flutter/material.dart';
import 'package:finniu/routes/routes.dart';
import 'package:finniu/presentation/screens/intro_screen.dart';
import 'package:flutter/services.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Preferences.init();
  Intl.defaultLocale = 'pt_BR';
  await initializeDateFormatting();
  await initHiveForFlutter(); //graphql cache

  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    // final gqlClient =  ref.watch(gqlClientProvider);
    return MaterialApp(
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
    );
  }
}
