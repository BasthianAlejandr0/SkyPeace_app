import 'package:flutter/material.dart';

class AuthServicelogout with ChangeNotifier {
  bool _isAuthenticated = false;

  bool get isAuthenticated => _isAuthenticated;

  Future<void> signOut() async {
    try {
      // Lógica para cerrar sesión
      _isAuthenticated = false;
      notifyListeners();
    } catch (e) {
      // Manejo de errores
      print('Error al cerrar sesión: $e');
    }
  }
}