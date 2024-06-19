import 'package:flutter/material.dart';
import 'package:finniu/constants/themes.dart';
import 'package:riverpod/riverpod.dart';

class SettingsProviderState {
  final ThemeData currentTheme;
  final bool isDarkMode;
  final bool showWelcomeModal;

  SettingsProviderState({
    required this.currentTheme,
    this.isDarkMode = false,
    required this.showWelcomeModal,
  });

  SettingsProviderState copyWith({
    ThemeData? currentTheme,
    bool? isDarkMode,
    bool? showWelcomeModal,
  }) {
    return SettingsProviderState(
      currentTheme: currentTheme ?? this.currentTheme,
      isDarkMode: isDarkMode ?? this.isDarkMode,
      showWelcomeModal: showWelcomeModal ?? this.showWelcomeModal,
    );
  }
}

class SettingsNotifierProvider extends StateNotifier<SettingsProviderState> {
  SettingsNotifierProvider({
    required bool isDarkMode,
    required bool showWelcomeModal,
  }) : super(
          SettingsProviderState(
            currentTheme:
                isDarkMode ? AppTheme().darkTheme : AppTheme().lightTheme,
            isDarkMode: isDarkMode,
            showWelcomeModal: showWelcomeModal,
          ),
        );

  void setLightMode() {
    state = state.copyWith(
      currentTheme: AppTheme().lightTheme,
      isDarkMode: false,
    );
  }

  void setDarkMode() {
    state = state.copyWith(
      currentTheme: AppTheme().darkTheme,
      isDarkMode: true,
    );
  }

  void setShowWelcomeModal(bool value) {
    state = state.copyWith(
      showWelcomeModal: value,
    );
  }

  void toggleTheme() {}
}

final settingsNotifierProvider =
    StateNotifierProvider<SettingsNotifierProvider, SettingsProviderState>(
        (ref) {
  return SettingsNotifierProvider(
    isDarkMode: false,
    showWelcomeModal: true,
  );
});



// import 'package:flutter/material.dart';
// import 'package:finniu/constants/themes.dart';

// class SettingsProvider extends ChangeNotifier {
//   ThemeData? currentTheme;
//   bool isDarkMode = false;
//   bool showWelcomeModal = true;

//   SettingsProvider({required bool isDarkMode, required bool showWelcomeModal}) {
//     currentTheme = isDarkMode ? AppTheme().darkTheme : AppTheme().lightTheme;
//     // ignore: prefer_initializing_formals
//     this.isDarkMode = isDarkMode;
//   }

//   setLightMode() {
//     currentTheme = AppTheme().lightTheme;
//     isDarkMode = false;
//     notifyListeners();
//   }

//   setDarkMode() {
//     isDarkMode = true;
//     currentTheme = AppTheme().darkTheme;
//     notifyListeners();
//   }

//   setShowWelcomeModal(bool value) {
//     showWelcomeModal = value;
//     notifyListeners();
//   }
// }
