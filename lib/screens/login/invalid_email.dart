import 'package:finniu/widgets/textfield.dart';
import 'package:flutter/material.dart';
import 'package:finniu/constants/colors.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../widgets/buttons.dart';
import '../../widgets/fonts.dart';
import '../../widgets/scaffold.dart';

class InvalidEmail extends StatefulWidget {
  const InvalidEmail({super.key});

  @override
  State<InvalidEmail> createState() => _InvalidEmailState();
}

class _InvalidEmailState extends State<InvalidEmail> {
  @override
  Widget build(BuildContext context) {
    return CustomScaffoldReturn(
        body: Center(
            child: Column(children: <Widget>[
      SizedBox(height: 90),
      TextPoppins(
        text: 'Correo inválido',
        colorText: primary_dark,
        fontSize: 24,
        fontWeight: FontWeight.w600,
      ),
      SizedBox(height: 10),
      TextPoppins(
        text: 'Este correo no está registrado en el App',
        colorText: primary_dark,
        fontSize: 12,
        fontWeight: FontWeight.w500,
      ),
      SizedBox(height: 25),
      Stack(children: <Widget>[
        Container(
          width: 125,
          height: 103,
          child: Image.asset('assets/forgotpassword/sad.png'),
        ),
      ]),
      SizedBox(height: 40),
      Container(
        width: 224,
        height: 38,
        child: ButtonDecoration(
          textHint: 'Correo inválido',
          textLabel: 'Correo electrónico',
        ),
      ),
      SizedBox(height: 15),
      Container(
          child: Center(
              child: TextPoppins(
        text: '¿Aún no tienes una cuenta creada?',
        colorText: black_text,
        fontSize: 11,
        fontWeight: FontWeight.w400,
      ))),
      SizedBox(height: 2),
      Container(
          child: Center(
              child: InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, '/login_email');
                  },
                  child: TextPoppins(
                    text: 'Registrarme',
                    colorText: primary_dark,
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                  ))))
    ])));
  }
}
