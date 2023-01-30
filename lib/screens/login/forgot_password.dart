import 'package:finniu/widgets/scaffold.dart';
import 'package:finniu/widgets/textfield.dart';
import 'package:flutter/material.dart';
import 'package:finniu/constants/colors.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../widgets/buttons.dart';
import '../../widgets/fonts.dart';

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
      SizedBox(height: 90),
      TextPoppins(
        text: '¿Olvidaste tu contraseña?',
        colorText: primary_dark,
        fontSize: 24,
        fontWeight: FontWeight.w600,
      ),
      SizedBox(height: 10),
      TextPoppins(
        text: 'No te preocupes es posible recuperarla',
        colorText: primary_dark,
        fontSize: 12,
        fontWeight: FontWeight.w500,
      ),
      Stack(children: <Widget>[
        Container(
          width: 89,
          height: 76,
          child: Image.asset('assets/forgotpassword/padlock.png'),
        ),
      ]),
      Container(
        width: 267,
        height: 130,
        decoration: BoxDecoration(
            color: const Color(primary_light_alternative),
            borderRadius: BorderRadius.circular(15)),
        child: Align(
          alignment: Alignment(-0.0, -0.0),
          child: Container(
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
      SizedBox(height: 50),
      Container(
        width: 224,
        height: 38,
        child: ButtonDecoration(
            textHint: 'Escribe tu correo electrónico',
            textLabel: "Correo electrónico"),
      ),
      SizedBox(height: 25),
      Container(
        height: 50,
        width: 224,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color: const Color(primary_dark),
        ),
        child: Center(
            child: CustomButton(
                text: 'Enviar correo',
                colorBackground: primary_dark,
                colorText: white_text,
                pushName: '/login_invalid')),
      ),
    ])));
  }
}
