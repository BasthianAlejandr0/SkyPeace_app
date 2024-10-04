import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserProvider with ChangeNotifier {
  // Declaramos las variables a utilizar
  String _username = "Cargando...";
  String _email = "Cargando...";

  // Declaramos los métodos a utilizar
  String get username => _username;
  String get email => _email;

  // Método para obtener los detalles del usuario
  Future<void> getUserDetails() async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      _email = user.email ?? "Correo no disponible";

      try {
        DocumentSnapshot<Map<String, dynamic>> userDoc = await FirebaseFirestore.instance
            .collection('usuarios')
            .doc(user.uid)
            .get();

        if (userDoc.exists) {
          _username = userDoc.data()?['username'] ?? "Nombre no disponible";
        } else {
          _username = "Usuario no encontrado en Firestore";
        }
      } catch (error) {
        _username = "Error al obtener el usuario";
        print('Error al obtener los detalles del usuario: $error');
      }
    } else {
      _username = "Usuario no autenticado";
    }

    // Notificar a los oyentes que los datos del usuario han sido actualizados
    notifyListeners();
  }
}