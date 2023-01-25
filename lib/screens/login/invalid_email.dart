import 'package:flutter/material.dart';
import 'package:finniu/constants/colors.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../widgets/buttons.dart';
import '../../widgets/fonts.dart';

class InvalidEmail extends StatefulWidget {
  const InvalidEmail({super.key});

  @override
  State<InvalidEmail> createState() => _InvalidEmailState();
}

class _InvalidEmailState extends State<InvalidEmail> {
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
            text: 'Correo inválido',
            colorText: primary_dark,
            fontSize: 24,
            fontWeight: FontWeight.w600,
          ),
          SizedBox(height: 10),
          TextPoppinsFont(
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
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Correo inválido',
                hintStyle: GoogleFonts.poppins(
                    textStyle: TextStyle(color: Color(red_text), fontSize: 11)),
                label: Text(
                  "Correo electrónico",
                  style: GoogleFonts.inter(
                      textStyle: TextStyle(
                    color: Color(red_text),
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  )),
                ),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.0),
                    borderSide: BorderSide(
                      color: const Color(red_text),
                    )),
              ),
            ),
          ),
          SizedBox(height: 15),
          Container(
              child: Center(
                  child: TextPoppinsFont(
            text: '¿Aún no tienes una cuenta creada?',
            colorText: black_text,
            fontSize: 11,
            fontWeight: FontWeight.w400,
          ))),
          SizedBox(height: 2),
          Container(
              child: Center(
                  child: TextPoppinsFont(
            text: 'Registrarme',
            colorText: primary_dark,
            fontSize: 11,
            fontWeight: FontWeight.bold,
          )))
        ])));
  }
}
