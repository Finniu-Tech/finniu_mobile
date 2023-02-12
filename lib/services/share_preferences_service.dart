import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  static late SharedPreferences _prefs;
  // static String _name = '';
  static bool _isDarkMode = false;
  // static String _authToken = '';

  static Future init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static bool get isDarkMode {
    return _prefs.getBool('isDarkMode') ?? _isDarkMode;
  }

  static set isDarkMode(bool value) {
    _isDarkMode = value;
    _prefs.setBool('isDarkMode', value);
  }

  // static String get authToken {
  //   return _prefs.getString('authToken') ?? _authToken;
  // }

  // static set authToken(String token) {
  //   _authToken = token;
  //   _prefs.setString('authToken', token);
  // }
}
