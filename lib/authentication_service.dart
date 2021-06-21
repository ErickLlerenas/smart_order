import 'package:firebase_auth/firebase_auth.dart';

class AuthenticationService {
  final FirebaseAuth _firebaseAuth;

  AuthenticationService(this._firebaseAuth);

  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  Future<String?> signIn({required String cellphone}) async {
    try {
      await _firebaseAuth.signInWithPhoneNumber(cellphone);

      return "Logeado";
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }
}
