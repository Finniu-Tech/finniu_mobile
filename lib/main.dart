import 'package:finniu/providers/theme_provider.dart';
import 'package:finniu/services/graphql_service.dart';
import 'package:finniu/services/share_preferences_service.dart';
import 'package:flutter/material.dart';
import 'package:finniu/routes/routes.dart';
import 'package:finniu/screens/intro_screen.dart';
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
          create: (_) => ThemeProvider(isDarkMode: Preferences.isDarkMode),
        ),
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
    return GraphQLProvider(
      client: GraphQLService().client,
      child: MaterialApp(
        title: 'Finniu',
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        // theme: ThemeData.dark(),
        theme: Provider.of<ThemeProvider>(context).currentTheme,
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
