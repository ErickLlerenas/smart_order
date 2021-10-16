import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:smart_order/screens/home.dart';

class LoginProvider with ChangeNotifier {
  String _verificationCode = "";

  String get verificationCode => _verificationCode;

  Future verifyCode(String phone) async {
    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: "+52$phone",
        verificationCompleted: _verificationCompleted,
        verificationFailed: _verificationFailed,
        codeSent: _codeSent,
        codeAutoRetrievalTimeout: _codeAutoRetrievalTimeout,
        timeout: Duration(seconds: 60));
  }

  void _codeSent(String verificationID, int? resendToken) {
    _verificationCode = verificationID;
    notifyListeners();
  }

  void _verificationFailed(FirebaseAuthException authException) {
    print("Failed: ${authException.message}");
  }

  void _verificationCompleted(PhoneAuthCredential authCredential) async {
    UserCredential userCredential =
        await FirebaseAuth.instance.signInWithCredential(authCredential);
    if (userCredential.user != null) {
      print("User Logged In");
    }
  }

  void _codeAutoRetrievalTimeout(String verificationID) {
    _verificationCode = verificationID;
    notifyListeners();
  }

  Future signInWithCredential(String verificationId, String smsCode,
      BuildContext context, String phoneNumber) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithCredential(PhoneAuthProvider.credential(
              verificationId: verificationId, smsCode: smsCode));
      if (userCredential.user != null) {
        await writePhone(phoneNumber);
        await saveUserOnFirebase(phoneNumber);
        Navigator.pop(context);
        Navigator.push(context, MaterialPageRoute(builder: (_) => Home()));
      }
    } catch (e) {
      print("Error: $e");
    }
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
      return await file.readAsString();
    } catch (e) {
      return "";
    }
  }

  Future saveUserOnFirebase(String _phone)async{
    DocumentSnapshot user = await FirebaseFirestore.instance.collection('users').doc(_phone).get();
    if(!user.exists){
      await FirebaseFirestore.instance.collection('users').doc(_phone).set({
        'id': _phone,
        'image': "",
        'name': "",
        'orders': []
      });

      await FirebaseFirestore.instance.collection('sellers').doc(_phone).set({
        'id': _phone,
        'image': "",
        'name': "",
        'orders': [],
        'location': GeoPoint(10,10),
        'foods': []
      });
    }
  }
}
