import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginViewProvider extends ChangeNotifier {
  GlobalKey<FormState> loginKey = new GlobalKey<FormState>();

  String _email = '';
  String _password = '';
  bool _isLoading = true;

  // Getters
  String get email => _email;
  String get password => _password;
  bool get isLoading => _isLoading;

  // Setters
  set email(String value) {
    _email = value;
    notifyListeners();
  }

  set password(String value) {
    _password = value;
    notifyListeners();
  }

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  // Método para validar el formulario
  bool isValidForm() {
    return loginKey.currentState?.validate() ?? false;
  }

  // Método para iniciar sesión
  Future<User?> loginUser(authService) async {
    if (!isValidForm()) return null;
    isLoading = true;
    
    final user = await authService.login(email: _email, password: _password,);
    
    isLoading = false;
    
    return user;
  }
}
