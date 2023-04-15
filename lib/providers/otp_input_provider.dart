import 'package:flutter/material.dart';

class OtpInputProvider extends ChangeNotifier {
  String _digit1 = '';
  String get digit1 => _digit1;

  String _digit2 = '';
  String get digit2 => _digit2;

  String _digit3 = '';
  String get digit3 => _digit3;

  String _digit4 = '';
  String get digit4 => _digit4;

  bool get isValid =>
      _digit1.isNotEmpty &&
      _digit2.isNotEmpty &&
      _digit3.isNotEmpty &&
      _digit4.isNotEmpty;

  String get otp => "$_digit1$_digit2$digit3$_digit4";

  void updateDigit1(String val) {
    _digit1 = val;
    notifyListeners();
  }

  void updateDigit2(String val) {
    _digit2 = val;
    notifyListeners();
  }

  void updateDigit3(String val) {
    _digit3 = val;
    notifyListeners();
  }

  void updateDigit4(String val) {
    _digit4 = val;
    notifyListeners();
  }
}
