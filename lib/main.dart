import 'package:finniu/providers/auth_provider.dart';
import 'package:finniu/providers/settings_provider.dart';
import 'package:finniu/services/graphql_service.dart';
import 'package:finniu/services/share_preferences_service.dart';
import 'package:flutter/material.dart';
import 'package:finniu/routes/routes.dart';
import 'package:finniu/screens/intro_screen.dart';
import 'package:flutter/services.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Preferences.init();
  await initHiveForFlutter(); //graphql cache
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => SettingsProvider(
            isDarkMode: Preferences.isDarkMode,
            showWelcomeModal: Preferences.showWelcomeModal,
          ),
        ),
        ChangeNotifierProvider(
          create: (_) => AuthTokenProvider(token: ''),
        ),
        ChangeNotifierProvider(create: (_) => UserProvider())
      ],
      child: const MyApp(),
    ),
  );
  // runApp(const MyApp())
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return GraphQLProvider(
      client: GraphQLService().client,
      child: MaterialApp(
        title: 'Finniu',
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        // theme: ThemeData.dark(),
        theme: Provider.of<SettingsProvider>(context).currentTheme,
        routes: getApplicationRoutes(),
        onGenerateRoute: (RouteSettings settings) {
          return MaterialPageRoute(
            builder: (BuildContext context) => IntroScreen(),
          );
        },
      ),
    );
  }
}
