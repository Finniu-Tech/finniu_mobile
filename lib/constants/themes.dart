import 'package:finniu/widgets/fonts.dart';
import 'package:flutter/material.dart';
import 'package:finniu/constants/colors.dart';

class AppTheme {
  get darkTheme => ThemeData(
        // primarySwatch:,
        appBarTheme: const AppBarTheme(color: Color(primary_dark)),
        backgroundColor: const Color(backgroundColorDark),
        primaryColor: const Color(primary_dark), // usado para gradiente
        primaryColorLight: const Color(primary_light), // usado para gradiente
        textTheme: const TextTheme(
          titleLarge: TextStyle(
            color: Color(sky_blue_text),
          ),
        ),
        colorScheme: const ColorScheme.dark(
          primary: Colors.white,
          secondary: Color(primary_light),
          tertiary: Color(secondary_text_dark),
        ),
        inputDecorationTheme: InputDecorationTheme(
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25.0),
            borderSide: const BorderSide(
              color: Color(borderInputDarkColor),
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25.0),
            borderSide: const BorderSide(
              color: Color(borderInputDarkColor),
            ),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25.0),
            borderSide: const BorderSide(
              color: Color(borderInputLightColor),
            ),
          ),
          hintStyle: fontPoppins(
            fontSize: 11,
            colorHex: hintTextDarkColor,
            fontWeight: FontWeight.w600,
          ),
          labelStyle: fontInter(
            fontSize: 12,
            colorHex: labelTextDarkColor,
            fontWeight: FontWeight.w600,
          ),
          suffixIconColor: const Color(suffixIconDarkColor),
        ),
      );

  get lightTheme => ThemeData(
        // primarySwatch: Colors.grey,
        backgroundColor: const Color(backgroundColorLight),
        primaryColor: const Color(primary_light), // usado para gradiente
        primaryColorLight: const Color(secondary), // usado para gradiente
        appBarTheme: const AppBarTheme(color: Color(primary_light)),
        textTheme: const TextTheme(
          titleLarge: TextStyle(
            color: Color(black_text),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25.0),
            borderSide: const BorderSide(
              color: Color(borderInputLightColor),
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25.0),
            borderSide: const BorderSide(
              color: Color(borderInputLightColor),
            ),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25.0),
            borderSide: const BorderSide(
              color: Color(borderInputLightColor),
            ),
          ),
          hintStyle: fontPoppins(
            fontSize: 11,
            colorHex: hintTextLightColor,
            fontWeight: FontWeight.w600,
          ),
          labelStyle: fontInter(
            fontSize: 12,
            colorHex: labelTextLightColor,
            fontWeight: FontWeight.w600,
          ),
          suffixIconColor: const Color(suffixIconColorLight),
        ),

        colorScheme: const ColorScheme.dark(
          primary: Colors.black,
          secondary: Color(primary_dark),
          tertiary: Color(primary_dark),
        ),
      );
}
