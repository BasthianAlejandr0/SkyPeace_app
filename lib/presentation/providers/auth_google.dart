import 'package:google_sign_in/google_sign_in.dart';  // Importa el paquete para la autenticación con Google.
import 'package:firebase_auth/firebase_auth.dart';    // Importa el paquete de autenticación de Firebase.

class AuthUserGoogle {  
  // Esta clase maneja la autenticación del usuario con Google.

  Future<User?> loginGoogle() async {    try {
      final GoogleSignIn googleSignIn = GoogleSignIn();


      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();

      if (googleUser == null) {
        return null;
      }

      final GoogleSignInAuthentication? googleAuth = await googleUser.authentication;

      final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      final UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credential);

      return userCredential.user;

    } catch (e) {
      print("Error en loginGoogle: $e");

      return null; 
    }
  }
}
