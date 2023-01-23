import 'package:flutter/material.dart';
import 'package:finniu/constants/colors.dart';
import 'package:google_fonts/google_fonts.dart';

class PoppinsFont extends StatelessWidget {
  final int colorText;
  final String text;
  final double fontSize;
  final FontWeight fontWeight;

  const PoppinsFont({
    super.key,
    required this.text,
    this.colorText = primary_dark,
    this.fontSize = 16,
    this.fontWeight = FontWeight.w500,
  });

  @override
  Widget build(BuildContext context) {
    return Text(text,
        textAlign: TextAlign.center,
        style: GoogleFonts.poppins(
            textStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: fontWeight,
                color: Color(
                  colorText,
                ))));
  }
}
