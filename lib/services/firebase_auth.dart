import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  //instancia del servicio obtenida, (patron singleton)
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //registrar usuario
  Future<User?> registerWithEmail(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return result.user;
    } on FirebaseAuthException catch (exceptionFBA) {
      //TODO: controlar error
      return null;
    }
  }

  //iniciar sesion
  Future<User?> signInWithEmail(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return result.user;
    } on FirebaseAuthException catch (exceptionFBA) {
      //TODO: controlar error
      return null;
    }
  }
}
