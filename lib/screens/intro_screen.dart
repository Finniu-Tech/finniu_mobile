import 'dart:async';
import 'package:finniu/providers/theme_provider.dart';
import 'package:finniu/widgets/fonts.dart';
import 'package:flutter/material.dart';
import 'package:finniu/screens/login/start_screen.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

class IntroScreen extends StatefulWidget {
  @override
  // ignore: library_private_types_in_public_api
  _IntroScreenState createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  _IntroScreenState();

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: false);

    Timer(
      const Duration(seconds: 3),
      () => Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (BuildContext context) => const StartLoginScreen(),
        ),
      ),
    );

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: Theme.of(context),
      home: Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: 300,
                  height: 300,
                  child: Image(
                    image: AssetImage(
                      themeProvider.isDarkMode ? "assets/images/logo_finniu_dark.png" : "assets/images/logo_finniu_light.png",
                    ),
                  ),
                ),
                TextPoppins(
                  text: 'Vive el #ModoFinniu',
                  colorText: Theme.of(context).colorScheme.secondary.value,
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                ),
                const SizedBox(height: 40.0),
                const SpinKitCircle(
                  color: Colors.grey,
                  size: 50.0,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
