import 'package:flutter/material.dart';
// import 'package:teve_empresa_app/src/pages/intro.dart';
// import 'package:teve_empresa_app/src/routes/routes.dart';
import 'package:finniu/routes/routes.dart';
import 'package:finniu/screens/intro_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
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
