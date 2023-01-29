import 'package:flutter/material.dart';
import 'package:finniu/constants/colors.dart';

class AppTheme {
  get darkTheme => ThemeData(
        // primarySwatch:,
        appBarTheme: const AppBarTheme(color: Color(primary_dark)),
        backgroundColor: const Color(primary_dark),
        primaryColor: const Color(primary_dark), // usado para gradiente
        primaryColorLight: const Color(primary_light), // usado para gradiente
        // primaryColorDark: ,
        // color
        colorScheme: const ColorScheme.dark(
          primary: Colors.white,
          secondary: Color(primary_light),
          tertiary: Color(secondary_text_dark),
        ),
      );

  get lightTheme => ThemeData(
        // primarySwatch: Colors.grey,
        backgroundColor: const Color(primary_light),
        primaryColor: const Color(primary_light), // usado para gradiente
        primaryColorLight: const Color(secondary), // usado para gradiente
        appBarTheme: const AppBarTheme(color: Color(primary_light)),
        colorScheme: const ColorScheme.dark(
            primary: Colors.black,
            secondary: Color(primary_dark),
            tertiary: const Color(primary_dark)),
      );
}
