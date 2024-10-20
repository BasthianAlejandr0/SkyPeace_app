import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthServicesSignup {
  final FirebaseAuth _auth = FirebaseAuth.instance;//Esta clase maneja la autenticación del usuario con Firebase.
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;//Esta clase maneja la base de datos Firestore de Firebase.

  Future<void> signup({//Este método se encarga de registrar un usuario en Firebase Authentication y guardar información adicional en Firestore.
    required String email,
    required String password,
    required String username,
    required String repassword,
  }) async {
    if (password != repassword) {
      throw Exception("Las contraseña no coinciden");
    }

    try {
  // Registro de usuario con Firebase Authentication
    UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    // Guardar información adicional en Firestore
    await _firestore.collection('usuarios').doc(userCredential.user?.uid).set({
      'username': username,
      'email': email,
      'createdAt': FieldValue.serverTimestamp(),
    });

  } on FirebaseAuthException catch (e) {
    if (e.code == 'email-already-in-use') {
      throw Exception("El correo ya está en uso. Intenta con otro.");
    } else if (e.code == 'weak-password') {
      throw Exception("La contraseña es demasiado débil.");
    } else {
      throw Exception("Error al registrar el usuario: ${e.message}");
    }
  } catch (e) {
    throw Exception("Error al registrar el usuario: $e");
  }
  }
}