import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
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
    print(_verificationCode);
    notifyListeners();
  }

  Future signInWithCredential(
      String verificationId, String smsCode, BuildContext context) async {
    print("VERIFICATION CODE: $verificationId");
    UserCredential userCredential = await FirebaseAuth.instance
        .signInWithCredential(PhoneAuthProvider.credential(
            verificationId: verificationId, smsCode: smsCode));
    if (userCredential.user != null) {
      Navigator.pop(context);
      Navigator.push(context, MaterialPageRoute(builder: (_) => Home()));
    }
  }
}
