import 'package:flutter/material.dart';
import 'package:finniu/constants/themes.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeData currentTheme;
  // bool isDarkMode = false;

  ThemeProvider({required bool isDarkMode})
      : currentTheme =
            isDarkMode ? AppTheme().darkTheme : AppTheme().lightTheme;

  setLightMode() {
    currentTheme = AppTheme().lightTheme;
    notifyListeners();
  }

  setDarkMode() {
    currentTheme = AppTheme().darkTheme;
    notifyListeners();
  }

  bool isDarkMode() {
    if (currentTheme == AppTheme().darkTheme) return true;
    return false;
  }
}
