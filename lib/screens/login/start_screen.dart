import 'package:finniu/constants/colors.dart';
import 'package:finniu/providers/theme_provider.dart';
import 'package:finniu/screens/intro_screen.dart';
import 'package:finniu/widgets/buttons.dart';
import 'package:finniu/widgets/fonts.dart';
import 'package:finniu/widgets/scaffold.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:provider/provider.dart';

class StartLoginScreen extends StatefulWidget {
  const StartLoginScreen({super.key});

  @override
  State<StartLoginScreen> createState() => _StartLoginScreenState();
}

class _StartLoginScreenState extends State<StartLoginScreen> {
  // final bool _isSwitchOn = false;

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: false);

    return CustomScaffoldStart(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomRight,
            // tileMode: TileMode.mirror,
            // stops: [0.4, 0.9],
            colors: [
              Theme.of(context).primaryColor,
              Theme.of(context).primaryColorLight
            ],
          ),
        ),
        child: Center(
          // padding: EdgeInsets.all(10),
          // margin: EdgeInsets.all(10),
          child: Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 50,
                ),
                // ignore: sized_box_for_whitespace
                Container(
                  width: 224,
                  height: 188,
                  child: Image(
                    fit: BoxFit.cover,
                    image: AssetImage(
                      themeProvider.isDarkMode()
                          ? "assets/images/logo_finniu_dark.png"
                          : "assets/images/logo_finniu_light.png",
                    ),
                  ),
                ),
                // ignore: sized_box_for_whitespace
                Container(
                  width: 224,
                  height: 50,
                  child: TextPoppins(
                      text: 'Empieza a vivir una nueva experiencia con Finniu',
                      colorText: Theme.of(context).colorScheme.tertiary.value,
                      fontSize: 16,
                      fontWeight: FontWeight.w500),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 35),
                  child: const CustomButton(
                      text: 'Iniciar sesión',
                      colorBackground: primaryDark,
                      colorText: white_text,
                      pushName: '/login_email'),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 20),
                  child: const CustomButton(
                      text: 'Registrarme',
                      colorBackground: primaryLight,
                      colorText: primaryDark,
                      pushName: '/sign_up_email'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
