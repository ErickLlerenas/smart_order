import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class AppProvider with ChangeNotifier {
  String _phone = "3121047740";
  bool _isUser = false;

  String get phone => _phone;
  bool get isUser => _isUser;

  Future savePhoneNumber() async {}

  Future readPhoneNumber() async {
    return _phone;
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

  void changeUserUI() {
    _isUser = !_isUser;
    notifyListeners();
  }

  Future<String> readPhone() async {
    try {
      final file = await _localFile;
      return await file.readAsString();
    } catch (e) {
      return "";
    }
  }
}
