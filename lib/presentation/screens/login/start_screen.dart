import 'package:finniu/constants/colors.dart';
import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:finniu/widgets/buttons.dart';
import 'package:finniu/widgets/fonts.dart';
import 'package:finniu/widgets/scaffold.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class StartLoginScreen extends ConsumerStatefulWidget {
  // const StartLoginScreen({super.key});

  @override
  _StartLoginScreenState createState() => _StartLoginScreenState();
}

class _StartLoginScreenState extends ConsumerState<StartLoginScreen> {
  _StartLoginScreenState();
  // final bool _isSwitchOn = false;

  @override
  Widget build(BuildContext context) {
    final themeProvider = ref.watch(settingsNotifierProvider);
    // final themeProvider = Provider.of<SettingsProvider>(context, listen: false);

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
          child: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 50,
                  ),
                  // ignore: sized_box_for_whitespace
                  SizedBox(
                    height: 200,
                    width: 200,
                    child: Image(
                      fit: BoxFit.cover,
                      image: AssetImage(
                        themeProvider.isDarkMode
                            ? "assets/images/logo_finniu_dark.png"
                            : "assets/images/logo_finniu_light.png",
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 224,
                    height: 50,
                    child: TextPoppins(
                        text:
                            'Empieza a vivir una nueva experiencia con Finniu',
                        colorText: Theme.of(context).colorScheme.tertiary.value,
                        fontSize: 16,
                        fontWeight: FontWeight.w500)
                        ,
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 35),
                    child:  CustomButton(
                        text: 'Iniciar sesión',
                        colorBackground: primaryDark,
                        colorText: whiteText,
                        pushName: '/login_email'),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 20),
                    child: CustomButton(
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
      ),
    );
  }
}
