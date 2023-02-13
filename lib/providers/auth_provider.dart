import 'package:flutter/material.dart';

class AuthTokenProvider extends ChangeNotifier {
  late String _token;

  AuthTokenProvider({required token}) {
    _token = token;
  }

  String get token {
    return _token;
  }

  set token(String token) {
    _token = token;
    notifyListeners();
  }
}

class UserProvider extends ChangeNotifier {
  late String? _nickName;
  late String? _email;
  late String? _firstName;
  late String? _lastName;
  late int? _phone;
  late bool _onboardingCompleted;

  UserProvider({
    nickName,
    email,
    firstName,
    lastName,
    phone,
  }) {
    _nickName = nickName;
    _email = email;
    _firstName = firstName;
    _lastName = lastName;
    _phone = phone;
  }
  String? get nickName => _nickName;
  String? get email => _email;
  String? get firstName => _firstName;
  String? get lastName => _lastName;
  int? get phone => _phone;
  bool get onboardingCompleted => _onboardingCompleted;

  set nickName(String? nickName) {
    _nickName = nickName;
    notifyListeners();
  }

  set email(String? email) {
    _email = email;
    notifyListeners();
  }

  set firstName(String? firstName) {
    _firstName = firstName;
    notifyListeners();
  }

  set lastName(String? lastName) {
    _lastName = lastName;
    notifyListeners();
  }

  set phone(int? phone) {
    _phone = phone;
    notifyListeners();
  }

  set onboardingCompleted(bool onboardingCompleted) {
    _onboardingCompleted = onboardingCompleted;
    notifyListeners();
  }
}
