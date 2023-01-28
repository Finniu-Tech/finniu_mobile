import 'package:finniu/providers/theme_provider.dart';
import 'package:finniu/share_preferences/preferences.dart';
import 'package:finniu/widgets/buttons.dart';
import 'package:finniu/widgets/fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:provider/provider.dart';

import '../constants/colors.dart';

class CustomScaffoldStart extends StatefulWidget {
  final dynamic body;

  const CustomScaffoldStart({super.key, required this.body});

  @override
  State<CustomScaffoldStart> createState() => _CustomScaffoldStartState();
}

class _CustomScaffoldStartState extends State<CustomScaffoldStart> {
  // bool _isSwitchOn = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.0,
        // backgroundColor: const Color(primary_light),
        title: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              const TextPoppins(
                  text: 'Light mode',
                  colorText: primary_dark,
                  fontSize: 10,
                  fontWeight: FontWeight.w500),
              const SizedBox(width: 5),
              FlutterSwitch(
                width: 45,
                height: 24,
                value: Preferences.isDarkMode,
                inactiveColor: const Color(primary_dark),
                activeColor: const Color(primary_light),
                inactiveToggleColor: const Color(primary_light),
                onToggle: (value) {
                  Preferences.isDarkMode = value;
                  final themeProvider =
                      Provider.of<ThemeProvider>(context, listen: false);
                  value
                      ? themeProvider.setDarkMode()
                      : themeProvider.setLightMode();
                  setState(() {});
                },
              ),
            ],
          ),
        ),
      ),
      // para acceder al parametro en un statefull widget se tiene q empezar con widget.nombre_del_parametro
      body: widget.body,
    );
  }
}

//custom_scaffold_return

class CustomScaffoldReturn extends StatefulWidget {
  final dynamic body;
  final int backgroundColor;
  final int colorBoxdecoration;
  final int colorIcon;

  const CustomScaffoldReturn(
      {super.key,
      required this.body,
      this.backgroundColor = 0xffFFFFFF,
      this.colorBoxdecoration = primary_dark,
      this.colorIcon = primary_light});

  @override
  State<CustomScaffoldReturn> createState() => _CustomScaffoldReturnState();
}

class _CustomScaffoldReturnState extends State<CustomScaffoldReturn> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Color(widget.backgroundColor),
        leading: const CustomReturnButton(),
      ),
      body: widget.body,
    );
  }
}

//custom_scaffold_logo

class CustomScaffoldLogo extends StatefulWidget {
  const CustomScaffoldLogo({super.key});

  @override
  _CustomScaffoldLogoState createState() => _CustomScaffoldLogoState();
}

class _CustomScaffoldLogoState extends State<CustomScaffoldStart> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        leading: const CustomReturnButton(),
      ),
    );
  }
}

//custom_scaffold_returnlogo

class CustomScaffoldReturnLogo extends StatefulWidget {
  const CustomScaffoldReturnLogo({super.key});

  @override
  _CustomScaffoldReturnLogo createState() => _CustomScaffoldReturnLogo();
}

class _CustomScaffoldReturnLogo extends State<CustomScaffoldStart> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        leading: const CustomReturnButton(),
      ),
    );
  }
}
