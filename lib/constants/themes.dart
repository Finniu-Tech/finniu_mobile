import 'package:finniu/widgets/fonts.dart';
import 'package:flutter/material.dart';
import 'package:finniu/constants/colors.dart';

class AppTheme {
  get darkTheme => ThemeData(
        // primarySwatch:,
        appBarTheme: const AppBarTheme(color: Color(primaryDark)),
        backgroundColor: const Color(backgroundColorDark),
        primaryColor: const Color(primaryDark), // usado para gradiente
        primaryColorLight: const Color(primaryLight), // usado para gradiente
        textTheme: const TextTheme(
          titleLarge: TextStyle(
            color: Color(skyBlueText),
          ),
          titleMedium: TextStyle(
            color: Color(hintTextDarkColor),
          ),
        ),
        colorScheme: const ColorScheme.dark(
          primary: Colors.white,
          secondary: Color(primaryLight),
          // tertiary: Color(0xff164D7D),
        ),
        textButtonTheme: TextButtonThemeData(
          style: ButtonStyle(
            // textStyle: MaterialStateProperty.resolveWith<TextStyle>(
            //   (_) {
            //     return const TextStyle(
            //       color: Color(colorTextButtonDarkColor),
            //     );
            //   },
            // ),
            backgroundColor: MaterialStateProperty.resolveWith<Color>(
              (states) => const Color(buttonBackgroundColorDark),
            ),
            foregroundColor: MaterialStateProperty.all<Color>(
              const Color(colorTextButtonDarkColor),
            ),
            shape: MaterialStateProperty.resolveWith<OutlinedBorder>(
              (_) {
                return RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                );
              },
            ),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          isDense: true,
          contentPadding:
              EdgeInsets.only(top: 13, bottom: 13, left: 20, right: 20),
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
        primaryColor: const Color(primaryLight), // usado para gradiente
        primaryColorLight: const Color(secondary), // usado para gradiente
        appBarTheme: const AppBarTheme(color: Color(primaryLight)),

        textTheme: const TextTheme(
          titleLarge: TextStyle(
            color: Color(blackText),
          ),
          titleMedium: TextStyle(
            color: Color(hintTextLightColor),
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: ButtonStyle(
            // textStyle: MaterialStateProperty.resolveWith<TextStyle>(
            //   (_) {
            //     return const TextStyle(
            //         // color: Color(colorTextButtonLightColor),
            //         // color: Colors.red,
            //         );
            //   },
            // ),
            backgroundColor: MaterialStateProperty.resolveWith<Color>(
                (states) => const Color(buttonBackgroundColorLight)),
            foregroundColor: MaterialStateProperty.all<Color>(
              const Color(colorTextButtonLightColor),
            ),
            shape: MaterialStateProperty.resolveWith<OutlinedBorder>(
              (_) {
                return RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                );
              },
            ),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          isDense: true,
          contentPadding:
              EdgeInsets.only(top: 13, bottom: 13, left: 20, right: 20),
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

        colorScheme: const ColorScheme.light(
          primary: Colors.black,
          secondary: Color(primaryDark),
          // tertiary: Color(0xffA2E6FA),
        ),
      );
}
