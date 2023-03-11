import 'package:finniu/infrastructure/models/user.dart';
import 'package:finniu/services/share_preferences_service.dart';
import 'package:finniu/use_cases/user/validations.dart';

bool showCompleteProfileModal(UserProfile userProfile) {
  if (Preferences.showWelcomeModal == false) {
    return false;
  }
  if (hasCompleteProfile(userProfile)) {
    return false;
  }
  return true;
}
