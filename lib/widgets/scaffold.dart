// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:finniu/constants/colors.dart';
import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:finniu/services/share_preferences_service.dart';
import 'package:finniu/widgets/buttons.dart';
import 'package:finniu/widgets/fonts.dart';

class CustomScaffoldStart extends ConsumerStatefulWidget {
  final dynamic body;

  const CustomScaffoldStart({super.key, required this.body});

  @override
  ConsumerState createState() => _CustomScaffoldStartState();
}

class _CustomScaffoldStartState extends ConsumerState<CustomScaffoldStart> {
  @override
  Widget build(BuildContext context) {
    final themeProvider = ref.watch(settingsNotifierProvider);
    // final themeProvider = Provider.of<SettingsProvider>(context, listen: false);

    return Scaffold(
      // backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.0,
        // backgroundColor: const Color(primary_light),
        title: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              TextPoppins(
                  text: themeProvider.isDarkMode ? 'Dark mode' : 'Light mode',
                  colorText: Theme.of(context).colorScheme.primary.value,
                  // colorText: ,
                  fontSize: 10,
                  fontWeight: FontWeight.w500),
              const SizedBox(width: 5),
              FlutterSwitch(
                width: 45,
                height: 24,
                value: Preferences.isDarkMode,
                inactiveColor: const Color(primaryDark),
                activeColor: const Color(primaryLight),
                inactiveToggleColor: const Color(primaryLight),
                activeToggleColor: const Color(primaryDark),
                onToggle: (value) {
                  Preferences.isDarkMode = value;
                  value
                      ? ref
                          .read(settingsNotifierProvider.notifier)
                          .setDarkMode()
                      : ref
                          .read(settingsNotifierProvider.notifier)
                          .setLightMode();
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

  const CustomScaffoldReturn({
    super.key,
    required this.body,
    this.backgroundColor = 0xffFFFFFF,
    this.colorBoxdecoration = primaryDark,
    this.colorIcon = primaryLight,
  });

  @override
  State<CustomScaffoldReturn> createState() => _CustomScaffoldReturnState();
}

class _CustomScaffoldReturnState extends State<CustomScaffoldReturn> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Theme.of(context).backgroundColor,
        leading: const CustomReturnButton(),
      ),
      body: widget.body,
    );
  }
}

//custom_scaffold_logo

class CustomScaffoldLogo extends StatefulWidget {
  const CustomScaffoldLogo({super.key, required Column body});

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

//custom_scaffold_return logo

class CustomScaffoldReturnLogo extends ConsumerWidget {
  final dynamic body;
  bool hideReturnButton;

  CustomScaffoldReturnLogo({
    required this.body,
    this.hideReturnButton = true,
  });
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeProvider = ref.watch(settingsNotifierProvider);

    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      bottomNavigationBar: const BottomNavigationBarHome(),
      appBar: AppBar(
        backgroundColor: Theme.of(context).backgroundColor,
        elevation: 0,
        leading: !hideReturnButton
            ? (themeProvider.isDarkMode
                ? const CustomReturnButton(
                    colorBoxdecoration: primaryDark,
                    colorIcon: primaryDark,
                  )
                : const CustomReturnButton())
            : null,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 14.0),
            child: SizedBox(
              width: 70,
              height: 70,
              child: themeProvider.isDarkMode
                  ? Image.asset('assets/images/logo_small_dark.png')
                  : Image.asset('assets/images/logo_small.png'),
            ),
          ),
        ],
      ),
      body: body,
    );
  }
}

class CustomScaffoldReturnDirect extends ConsumerWidget {
  final dynamic body;
  bool hideReturnButton;

  CustomScaffoldReturnDirect({
    required this.body,
    this.hideReturnButton = false,
  });
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeProvider = ref.watch(settingsNotifierProvider);

    return Scaffold(
      // backgroundColor: Theme.of(context).backgroundColor,
      bottomNavigationBar: const BottomNavigationBarHome(),
      appBar: AppBar(
        // backgroundColor: Theme.of(context).backgroundColor,
        elevation: 0,
        leading: !hideReturnButton
            ? (themeProvider.isDarkMode
                ? const CustomReturnButton(
                    colorBoxdecoration: primaryDark,
                    colorIcon: primaryDark,
                  )
                : const CustomReturnButton())
            : null,
      ),
      body: body,
    );
  }
}
