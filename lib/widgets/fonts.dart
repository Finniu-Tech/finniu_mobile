import 'package:flutter/material.dart';
import 'package:finniu/constants/colors.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'package:meta/meta.dart';

class TextPoppins extends StatelessWidget {
  final int colorText;
  final String text;
  final double fontSize;
  final FontWeight fontWeight;

  const TextPoppins({
    super.key,
    required this.text,
    this.colorText = primaryDark,
    this.fontSize = 16,
    this.fontWeight = FontWeight.w500,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: GoogleFonts.poppins(
        textStyle: TextStyle(
          fontSize: fontSize,
          fontWeight: fontWeight,
          color: Color(
            colorText,
          ),
        ),
      ),
    );
  }
}

class TextInter extends StatelessWidget {
  final int colorText;
  final String text;
  final double fontSize;
  final FontWeight fontWeight;

  const TextInter({
    super.key,
    required this.text,
    this.colorText = primaryDark,
    this.fontSize = 16,
    this.fontWeight = FontWeight.w500,
  });

  @override
  Widget build(BuildContext context) {
    return Text(text,
        textAlign: TextAlign.center,
        style: GoogleFonts.inter(
            textStyle: TextStyle(fontSize: fontSize, fontWeight: fontWeight, color: Color(colorText))));
  }
}

//function que retornar font poppins
TextStyle fontPoppins({required double fontSize, required int colorHex, FontWeight fontWeight = FontWeight.w100}) {
  return GoogleFonts.poppins(textStyle: TextStyle(fontSize: fontSize, fontWeight: fontWeight, color: Color(colorHex)));
}

TextStyle fontInter({required double fontSize, required int colorHex, FontWeight fontWeight = FontWeight.w100}) {
  return GoogleFonts.inter(textStyle: TextStyle(fontSize: fontSize, fontWeight: fontWeight, color: Color(colorHex)));
}
