import 'package:finniu/services/share_preferences_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EyeHomeNotifier extends StateNotifier<bool> {
  EyeHomeNotifier() : super(Preferences.eyeHome);

  void toggleEyeHome() {
    final newValue = !state;
    state = newValue;
    Preferences.eyeHome = newValue;
  }

  void updateFromPreferences() {
    state = Preferences.eyeHome;
  }
}

final eyeHomeProvider =
    StateNotifierProvider<EyeHomeNotifier, bool>((ref) => EyeHomeNotifier());
