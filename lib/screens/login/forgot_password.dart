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
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
            elevation: 0.0,
            backgroundColor: Colors.white,
            leading: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  margin: EdgeInsets.all(10),
                  // padding: EdgeInsets.all(6),
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Color(primary_dark),
                  ),
                  child: Center(
                      child: Icon(
                    size: 20,
                    color: Color(primary_light),
                    Icons.arrow_back_ios_new_outlined,
                  )),
                ))),
        body: Center(
            child: Column(children: <Widget>[
          SizedBox(height: 90),
          TextPoppinsFont(
            text: '¿Olvidaste tu contraseña?',
            colorText: primary_dark,
            fontSize: 24,
            fontWeight: FontWeight.w600,
          ),
          SizedBox(height: 10),
          TextPoppinsFont(
            text: 'No te preocupes es posible recuperarla',
            colorText: primary_dark,
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
          SizedBox(height: 25),
          Container(
            width: 267,
            height: 130,
            decoration: BoxDecoration(
                color: const Color(primary_light_alternative),
                borderRadius: BorderRadius.circular(10)),
            child: Center(
              child: Text(
                'Por favor ingresa tu correo electrónico que ingresaste al crear tu cuenta en la App , en unos minutos recibiras un correo para recuperar tu contraseña.',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 11,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
          SizedBox(height: 50),
          Container(
            width: 224,
            height: 38,
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Escribe tu correo electrónico',
                hintStyle: GoogleFonts.poppins(
                    textStyle:
                        TextStyle(color: Color(gray_text), fontSize: 11)),
                label: Text(
                  "Correo electrónico",
                  style: GoogleFonts.inter(
                      textStyle: TextStyle(
                    color: Color(primary_dark),
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  )),
                ),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.0),
                    borderSide: BorderSide(
                      color: const Color(primary_dark),
                    )),
              ),
            ),
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
                    color_background: primary_dark,
                    color_text: white_text,
                    pushName: '/sign_up_welcome')),
          ),
        ])));
  }
}
