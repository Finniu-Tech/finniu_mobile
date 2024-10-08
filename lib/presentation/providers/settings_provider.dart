import 'package:finniu/services/share_preferences_service.dart';
import 'package:flutter/material.dart';
import 'package:finniu/constants/themes.dart';
import 'package:riverpod/riverpod.dart';

class SettingsProviderState {
  final ThemeData currentTheme;
  final bool isDarkMode;
  final bool showWelcomeModal;

  SettingsProviderState({
    required this.currentTheme,
    required this.isDarkMode,
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
  SettingsNotifierProvider()
      : super(
          SettingsProviderState(
            currentTheme: Preferences.isDarkMode ? AppTheme().darkTheme : AppTheme().lightTheme,
            isDarkMode: Preferences.isDarkMode,
            showWelcomeModal: Preferences.showWelcomeModal,
          ),
        );

  void setLightMode() {
    Preferences.isDarkMode = false;
    state = state.copyWith(
      currentTheme: AppTheme().lightTheme,
      isDarkMode: false,
    );
  }

  void setDarkMode() {
    Preferences.isDarkMode = true;
    state = state.copyWith(
      currentTheme: AppTheme().darkTheme,
      isDarkMode: true,
    );
  }

  void setShowWelcomeModal(bool value) {
    Preferences.showWelcomeModal = value;
    state = state.copyWith(
      showWelcomeModal: value,
    );
  }

  void toggleTheme() {
    if (state.isDarkMode) {
      setLightMode();
    } else {
      setDarkMode();
    }
  }
}

final settingsNotifierProvider = StateNotifierProvider<SettingsNotifierProvider, SettingsProviderState>(
  (ref) => SettingsNotifierProvider(),
);
