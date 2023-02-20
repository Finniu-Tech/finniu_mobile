import 'package:flutter/material.dart';
import 'package:finniu/constants/themes.dart';

class SettingsProvider extends ChangeNotifier {
  ThemeData? currentTheme;
  bool isDarkMode = false;
  bool showWelcomeModal = true;

  SettingsProvider({required bool isDarkMode, required bool showWelcomeModal}) {
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

  setShowWelcomeModal(bool value) {
    showWelcomeModal = value;
    notifyListeners();
  }
}
