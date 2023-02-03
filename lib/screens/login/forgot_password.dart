import 'package:finniu/widgets/buttons.dart';
import 'package:finniu/widgets/fonts.dart';
import 'package:finniu/widgets/scaffold.dart';
import 'package:finniu/widgets/textfield.dart';
import 'package:flutter/material.dart';
import 'package:finniu/constants/colors.dart';
import 'package:google_fonts/google_fonts.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  @override
  Widget build(BuildContext context) {
    return CustomScaffoldReturn(
        body: Center(
            child: Column(children: <Widget>[
      const SizedBox(height: 90),
      const TextPoppins(
        text: '¿Olvidaste tu contraseña?',
        colorText: primaryDark,
        fontSize: 24,
        fontWeight: FontWeight.w600,
      ),
      const SizedBox(height: 10),
      const TextPoppins(
        text: 'No te preocupes es posible recuperarla',
        colorText: primaryDark,
        fontSize: 12,
        fontWeight: FontWeight.w500,
      ),
      Stack(children: <Widget>[
        SizedBox(
          width: 89,
          height: 76,
          child: Image.asset('assets/forgotpassword/padlock.png'),
        ),
      ]),
      Container(
        width: 267,
        height: 130,
        decoration: BoxDecoration(color: const Color(primaryLightAlternative), borderRadius: BorderRadius.circular(15)),
        child: const Align(
          alignment: Alignment(-0.0, -0.0),
          child: SizedBox(
            width: 184,
            height: 103,
            child: Text(
              'Por favor ingresa tu correo electrónico que ingresaste al crear tu cuenta en la App , en unos minutos recibiras un correo para recuperar tu contraseña.',
              textAlign: TextAlign.right,
              style: TextStyle(
                color: Colors.black,
                fontSize: 11,
                fontWeight: FontWeight.w400,
                height: 1.5,
              ),
            ),
          ),
        ),
      ),
      const SizedBox(height: 50),
      const SizedBox(
        width: 224,
        height: 38,
        child: ButtonDecoration(textHint: 'Escribe tu correo electrónico', textLabel: "Correo electrónico"),
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
    ])));
  }
}
