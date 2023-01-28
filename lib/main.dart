import 'package:finniu/providers/theme_provider.dart';
import 'package:finniu/share_preferences/preferences.dart';
import 'package:flutter/material.dart';
import 'package:finniu/routes/routes.dart';
import 'package:finniu/screens/intro_screen.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Preferences.init();
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
    return MaterialApp(
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
    );
  }
}
