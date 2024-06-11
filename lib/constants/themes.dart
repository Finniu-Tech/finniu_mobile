import 'package:finniu/widgets/fonts.dart';
import 'package:flutter/material.dart';
import 'package:finniu/constants/colors.dart';

class AppTheme {
  get darkTheme => ThemeData(
        pageTransitionsTheme: const PageTransitionsTheme(
          builders: {
            TargetPlatform.android: CupertinoPageTransitionsBuilder(),
            TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
          },
        ),
        appBarTheme: const AppBarTheme(
            color: Color(primaryDark), scrolledUnderElevation: 0),
        primaryColor: const Color(primaryDark), // usado para gradiente
        primaryColorLight: const Color(primaryLight), // usado para gradiente
        textTheme: const TextTheme(
          titleLarge: TextStyle(
            color: Color(skyBlueText),
          ),
          titleMedium: TextStyle(
            color: Color(whiteText),
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: ButtonStyle(
            elevation: MaterialStateProperty.all<double>(4),
            shadowColor: MaterialStateProperty.all<Color>(Colors.grey),
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
          floatingLabelBehavior: FloatingLabelBehavior.always,
          contentPadding:
              const EdgeInsets.only(top: 10, bottom: 10, left: 20, right: 20),
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
        colorScheme: const ColorScheme.dark(
          primary: Colors.white,
          secondary: Color(primaryLight),
          // tertiary: Color(0xff164D7D),
        ).copyWith(background: Color(backgroundColorDark)),
      );

  get lightTheme => ThemeData(
        // useMaterial3: true,
        // primarySwatch: Colors.grey,
        pageTransitionsTheme: const PageTransitionsTheme(
          builders: {
            TargetPlatform.android: CupertinoPageTransitionsBuilder(),
            TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
          },
        ),
        primaryColor: const Color(primaryLight), // usado para gradiente
        primaryColorLight: const Color(secondary), // usado para gradiente
        appBarTheme: const AppBarTheme(
            color: Color(primaryLight), scrolledUnderElevation: 0),

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
          floatingLabelBehavior: FloatingLabelBehavior.always,
          contentPadding:
              const EdgeInsets.only(top: 10, bottom: 10, left: 20, right: 20),
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
        ).copyWith(background: const Color(backgroundColorLight)),
      );
}
