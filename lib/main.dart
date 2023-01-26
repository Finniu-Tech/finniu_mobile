import 'package:flutter/material.dart';
import 'package:finniu/routes/routes.dart';
import 'package:finniu/screens/intro_screen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Finniu',
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      // theme: ThemeData.dark(),
      routes: getApplicationRoutes(),
      onGenerateRoute: (RouteSettings settings) {
        return MaterialPageRoute(
            builder: (BuildContext context) => IntroScreen());
      },
    );
  }
}
