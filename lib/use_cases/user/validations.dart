import 'package:finniu/infrastructure/models/user.dart';
import 'package:finniu/utils/strings.dart';

bool hasCompleteProfile(UserProfile userProfile) {
  if (exists(userProfile.email) ||
      exists(userProfile.phoneNumber) ||
      exists(userProfile.distrito) ||
      exists(userProfile.provincia) ||
      exists(userProfile.region)) {
    return false;
  }
  return true;
}
