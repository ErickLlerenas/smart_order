import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class AppProvider with ChangeNotifier {
  String _phone = "";
  bool _isUser = false;

  String get phone => _phone;
  bool get isUser => _isUser;

  Future readPhoneNumber() async {
    return _phone;
  }

  void changeUserUI() {
    _isUser = !_isUser;
    print(_isUser);
    notifyListeners();
  }

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/phone.txt');
  }

  Future<File> writePhone(String phone) async {
    final file = await _localFile;

    // Write the file
    return file.writeAsString('$phone');
  }

  Future<String> readPhone() async {
    try {
      final file = await _localFile;
      _phone = await file.readAsString();
      return phone;
    } catch (e) {
      return "";
    }
  }
}
