import 'package:finniu/widgets/fonts.dart';
import 'package:finniu/widgets/scaffold.dart';
import 'package:finniu/widgets/textfield.dart';
import 'package:flutter/material.dart';
import 'package:finniu/constants/colors.dart';
import 'package:google_fonts/google_fonts.dart';

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
      const SizedBox(height: 90),
      const TextPoppins(
        text: 'Correo inválido',
        colorText: primaryDark,
        fontSize: 24,
        fontWeight: FontWeight.w600,
      ),
      const SizedBox(height: 10),
      const TextPoppins(
        text: 'Este correo no está registrado en el App',
        colorText: primaryDark,
        fontSize: 12,
        fontWeight: FontWeight.w500,
      ),
      const SizedBox(height: 25),
      Stack(children: <Widget>[
        SizedBox(
          width: 125,
          height: 103,
          child: Image.asset('assets/forgotpassword/sad.png'),
        ),
      ]),
      const SizedBox(height: 40),
      const SizedBox(
        width: 224,
        height: 38,
        child: ButtonDecoration(
          textHint: 'Correo inválido',
          textLabel: 'Correo electrónico',
        ),
      ),
      const SizedBox(height: 15),
      const Center(
          child: TextPoppins(
        text: '¿Aún no tienes una cuenta creada?',
        colorText: blackText,
        fontSize: 11,
        fontWeight: FontWeight.w400,
      )),
      const SizedBox(height: 2),
      Center(
          child: InkWell(
              onTap: () {
                Navigator.pushNamed(context, '/login_email');
              },
              child: const TextPoppins(
                text: 'Registrarme',
                colorText: primaryDark,
                fontSize: 11,
                fontWeight: FontWeight.bold,
              )))
    ])));
  }
}
