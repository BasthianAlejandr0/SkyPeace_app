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
        'createdAt': FieldValue.serverTimestamp(),//Se guarda la fecha de creación del usuario.

      });

      // Puedes manejar la navegación u otras lógicas aquí, si es necesario.

    } catch (e) { //¿Que es el e? Es un objeto que contiene información sobre el error que ocurrió.
      throw Exception("Error al registrar el usuario: $e");
    }
  }
}