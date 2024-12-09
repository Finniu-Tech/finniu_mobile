import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  static late SharedPreferences _prefs;
  // static String _name = '';
  static bool _isDarkMode = false;
  static bool _showWelcomeModal = true;
  static bool _rememberMe = false;
  static String? _token;
  static String? _username;
  static bool _showedPushNotificationReminder = false;
  static bool _eyeHome = false;

  static bool _hasRequestedPushNotificationPermission = false;
  static String? _pendingNotificationRoute;
  static String? _installationId;

  static String? get installationId {
    return _prefs.getString('installationId') ?? _installationId;
  }

  static set installationId(String? id) {
    _installationId = id;
    if (id != null) {
      _prefs.setString('installationId', id);
    } else {
      _prefs.remove('installationId');
    }
  }

  static String? get pendingNotificationRoute {
    return _prefs.getString('pendingNotificationRoute') ?? _pendingNotificationRoute;
  }

  static set pendingNotificationRoute(String? route) {
    _pendingNotificationRoute = route;
    if (route != null) {
      _prefs.setString('pendingNotificationRoute', route);
    } else {
      _prefs.remove('pendingNotificationRoute');
    }
  }

  static Future init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static bool get isDarkMode {
    return _prefs.getBool('isDarkMode') ?? _isDarkMode;
  }

  static bool get showedPushNotificationReminder {
    return _prefs.getBool('showedPushNotificationReminder') ?? _showedPushNotificationReminder;
  }

  static bool get hasRequestedPushNotificationPermission {
    return _prefs.getBool('hasRequestedPushNotificationPermission') ?? _hasRequestedPushNotificationPermission;
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

  static bool get rememberMe {
    return _prefs.getBool('rememberMe') ?? _rememberMe;
  }

  static set rememberMe(bool value) {
    _rememberMe = value;
    _prefs.setBool('rememberMe', value);
  }

  static set showedPushNotificationReminder(bool value) {
    _showedPushNotificationReminder = value;
    _prefs.setBool('showedPushNotificationReminder', value);
  }

  static set hasRequestedPushNotificationPermission(bool value) {
    _hasRequestedPushNotificationPermission = value;
    _prefs.setBool('hasRequestedPushNotificationPermission', value);
  }

  static bool get eyeHome {
    return _prefs.getBool('eyeHome') ?? _eyeHome;
  }

  static set eyeHome(bool value) {
    _eyeHome = value;
    _prefs.setBool('eyeHome', value);
  }
  // static String get authToken {
  //   return _prefs.getString('authToken') ?? _authToken;
  // }

  // static set authToken(String token) {
  //   _authToken = token;
  //   _prefs.setString('authToken', token);
  // }
}
