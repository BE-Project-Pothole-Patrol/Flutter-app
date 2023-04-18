import 'package:flutter/material.dart';

class UserDataProvider extends ChangeNotifier {
  String _firstName = '';
  String get firstName => _firstName;
  bool _isFirstNameValid = true;
  bool get isFirstNameValid => _isFirstNameValid;

  String _lastName = '';
  String get lastName => _lastName;
  bool _isLastNameValid = true;
  bool get isLastNameValid => _isLastNameValid;

  String _username = '';
  String get username => _username;
  bool _isUsernameValid = true;
  bool get isUsernameValid => _isUsernameValid;

  String _email = '';
  String get email => _email;
  bool _isEmailValid = true;
  bool get isEmailValid => _isEmailValid;

  String _password = '';
  String get password => _password;
  bool _isPasswordValid = true;
  bool get isPasswordValid => _isPasswordValid;

  String _confirmPassword = '';
  String get confirmPassword => _confirmPassword;
  bool _isConfirmPasswordValid = true;
  bool get isConfirmPasswordValid => _isConfirmPasswordValid;

  bool _isValid = false;
  bool get isValid => _isValid;

  bool checkValidity() {
    return isFirstNameValid &&
        isLastNameValid &&
        isUsernameValid &&
        isEmailValid &&
        isPasswordValid &&
        isConfirmPasswordValid;
  }

  void updateFirstName(String val) {
    _firstName = val;
    _isFirstNameValid = _firstName.isNotEmpty;
    _isValid = checkValidity();
    notifyListeners();
  }

  void updateLastName(String val) {
    _lastName = val;
    _isLastNameValid = _lastName.isNotEmpty;
    _isValid = checkValidity();
    notifyListeners();
  }

  void updateUsername(String val) {
    _username = val;
    _isUsernameValid = _username.length > 5;
    _isValid = checkValidity();
    notifyListeners();
  }

  void updateEmail(String val) {
    _email = val;
    _isEmailValid = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(_email);
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

  void updateConfirmPassword(String val) {
    _confirmPassword = val;
    _isConfirmPasswordValid = isPasswordValid && _confirmPassword == _password;
    _isValid = checkValidity();
    notifyListeners();
  }
  
  Map<String, String> getUserData() {
    return {
      'firstName': _firstName,
      'lastName': _lastName,
      'username': _username,
      'email': _email,
      'password': _password,
    };
  }
}
