import 'package:flutter/material.dart';
import 'package:finniu/constants/themes.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeData? currentTheme;
  bool isDarkMode = false;

  ThemeProvider({required bool isDarkMode}) {
    currentTheme = isDarkMode ? AppTheme().darkTheme : AppTheme().lightTheme;
    // ignore: prefer_initializing_formals
    this.isDarkMode = isDarkMode;
  }

  setLightMode() {
    currentTheme = AppTheme().lightTheme;
    isDarkMode = false;
    notifyListeners();
  }

  setDarkMode() {
    isDarkMode = true;
    currentTheme = AppTheme().darkTheme;
    notifyListeners();
  }
}
