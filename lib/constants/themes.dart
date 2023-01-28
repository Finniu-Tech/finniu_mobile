import 'package:flutter/material.dart';
import 'package:finniu/constants/colors.dart';

class AppTheme {
  get darkTheme => ThemeData(
        primarySwatch: Colors.grey,
        appBarTheme: const AppBarTheme(color: Color(primary_dark)),
        backgroundColor: const Color(primary_dark),
      );

  get lightTheme => ThemeData(
        primarySwatch: Colors.grey,
        backgroundColor: const Color(primary_light),
      );
}
