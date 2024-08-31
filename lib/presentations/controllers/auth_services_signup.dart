import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthServicesSignup {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> signup({
    required String email,
    required String password,
    required String username,
    required String repassword,
  }) async {
    if (password != repassword) {
      throw Exception("Passwords do not match");
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

      // Puedes manejar la navegación u otras lógicas aquí, si es necesario.

    } catch (e) {
      throw Exception("Error al registrar el usuario: $e");
    }
  }
}
