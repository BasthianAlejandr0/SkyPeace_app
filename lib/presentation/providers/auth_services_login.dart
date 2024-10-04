import 'package:firebase_auth/firebase_auth.dart';

class AuthServicesLogin {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  
    Future<User?> login({
    required String email,
    required String password,
  }) async {
    try {
      // Intentar iniciar sesión con correo y contraseña
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      // Retornar el usuario autenticado
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      // ignore: unused_local_variable
      String message = "";
      // Manejar errores específicos
      if (e.code == 'user-not-found') {
        message= 'No se encontró un usuario con ese correo.';
      } else if (e.code == 'wrong-password') {
        message= 'Contraseña incorrecta.';
      }
    } catch (e) {
      // Manejar otros errores
      // ignore: avoid_print
      print(e.toString());
    }
    return null;
  }
}
