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
