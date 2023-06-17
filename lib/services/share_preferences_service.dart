import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  static late SharedPreferences _prefs;
  // static String _name = '';
  static bool _isDarkMode = false;
  static bool _showWelcomeModal = true;
  static String? _token = null;
  static String? _username = null;
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

  static bool get showWelcomeModal {
    return _prefs.getBool('showWelcomeModal') ?? _showWelcomeModal;
  }

  static set showWelcomeModal(bool value) {
    _showWelcomeModal = value;
    _prefs.setBool('showWelcomeModal', value);
  }

  static String? get token {
    return _prefs.getString('token') ?? _token;
  }

  static set token(String? token) {
    _token = token;
    _prefs.setString('token', token!);
  }

  static set username(String? username) {
    _username = username;
    _prefs.setString('username', username!);
  }

  static String? get username {
    return _prefs.getString('username') ?? _username;
  }

  // static String get authToken {
  //   return _prefs.getString('authToken') ?? _authToken;
  // }

  // static set authToken(String token) {
  //   _authToken = token;
  //   _prefs.setString('authToken', token);
  // }
}
