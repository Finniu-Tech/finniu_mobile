import 'package:flutter/material.dart';
import 'package:finniu/constants/colors.dart';

class AppTheme {
  get darkTheme => ThemeData(
        // primarySwatch:,
        appBarTheme: const AppBarTheme(color: Color(primary_dark)),
        backgroundColor: const Color(primary_dark),
        primaryColor: const Color(primary_dark),
        primaryColorLight: const Color(primary_light),
        // primaryColorDark: ,
        // color
        colorScheme: const ColorScheme.dark(
          primary: Colors.white,
          secondary: Color(primary_light),
        ),
      );

  get lightTheme => ThemeData(
        // primarySwatch: Colors.grey,
        backgroundColor: const Color(primary_light),
        primaryColor: const Color(primary_light),
        primaryColorLight: const Color(secondary),
        appBarTheme: const AppBarTheme(color: Color(primary_light)),
        colorScheme: const ColorScheme.dark(
          primary: Colors.black,
          secondary: Color(primary_light),
        ),
      );
}
