import 'package:flutter/material.dart';

class LoginProvider extends ChangeNotifier {
  String _username = '';
  String get username => _username;
  bool _isUsernameValid = true;
  bool get isUsernameValid => _isUsernameValid;

  String _password = '';
  String get password => _password;
  bool _isPasswordValid = true;
  bool get isPasswordValid => _isPasswordValid;

  bool _isValid = false;
  bool get isValid => _isValid;

  bool checkValidity() {
    return isUsernameValid && isPasswordValid;
  }

  void updateUsername(String val) {
    _username = val;
    _isUsernameValid = _username.length > 5;
    _isValid = checkValidity();
    notifyListeners();
  }

  void updatePassword(String val) {
    _password = val;
    _isPasswordValid = _password.isNotEmpty &&
                       RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$')
                       .hasMatch(_password);
    _isValid = checkValidity();
    notifyListeners();
  }

   Map<String, String> getLoginData() {
    return {
      'username': _username,
      'password': _password,
    };
  }
}
