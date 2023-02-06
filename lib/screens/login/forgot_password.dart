import 'package:finniu/providers/theme_provider.dart';
import 'package:finniu/widgets/buttons.dart';
import 'package:finniu/widgets/fonts.dart';
import 'package:finniu/widgets/scaffold.dart';
import 'package:finniu/widgets/textfield.dart';
import 'package:flutter/material.dart';
import 'package:finniu/constants/colors.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  @override
  Widget build(BuildContext context) {
    final currentTheme = Provider.of<ThemeProvider>(context, listen: false);

    return CustomScaffoldReturn(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            const SizedBox(height: 80),
            TextPoppins(
              text: '¿Olvidaste tu contraseña?',
              colorText: Theme.of(context).textTheme.titleLarge!.color!.value,
              fontSize: 24,
              fontWeight: FontWeight.w600,
            ),
            SizedBox(height: 20),
            const TextPoppins(
              text: 'No te preocupes es posible recuperarla',
              colorText: grayText,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
            SizedBox(height: 20),
            Stack(
              children: <Widget>[
                Align(
                  alignment: Alignment.center,
                  child: Card(
                    shadowColor: Colors.transparent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Container(
                      padding: const EdgeInsets.only(
                          left: 50, right: 30, top: 15, bottom: 15),
                      decoration: BoxDecoration(
                        color: currentTheme.isDarkMode
                            ? const Color(cardBackgroundColorDark)
                            : const Color(cardBackgroundColorLight),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      height: 130,
                      width: 267,
                      child: const Align(
                        alignment: Alignment.center,
                        child: Text(
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 11, color: Colors.black),
                            "Por favor ingresa tu correo electrónico que ingresaste al crear tu cuenta en la App , en unos minutos recibiras un correo para recuperar tu contraseña."),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 20,
                  left: 30,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      height: 90,
                      width: 80,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image:
                              AssetImage("assets/forgotpassword/padlock.png"),
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            const SizedBox(
              width: 224,
              height: 38,
              child: ButtonDecoration(
                  textHint: 'Escribe tu correo electrónico',
                  textLabel: "Correo electrónico"),
            ),
            const SizedBox(height: 25),
            Container(
              height: 50,
              width: 224,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: const Color(primaryDark),
              ),
              child: const Center(
                  child: CustomButton(
                      text: 'Enviar correo',
                      // colorBackground: primaryDark,
                      // colorText: white_text,
                      pushName: '/login_invalid')),
            ),
          ],
        ),
      ),
    );
  }
}
