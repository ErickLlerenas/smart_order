import 'package:flutter/material.dart';

class AppProvider with ChangeNotifier {
  String _phone = "3121047740";
  bool _isUser = false;

  String get phone => _phone;
  bool get isUser => _isUser;

  Future savePhoneNumber() async {}

  Future readPhoneNumber() async {
    return _phone;
  }

  void changeUserUI() {
    _isUser = !_isUser;
    notifyListeners();
  }
}
