import 'package:flutter/material.dart';

//* Este es el provider que se encarga de validar el formulario de registro
class RegistroViewProvider extends ChangeNotifier{
  GlobalKey<FormState> registroKey = new GlobalKey<FormState>();
  String _username= '';
  String _email = '';
  String _password = '';
  String _repassword = '';
  bool _isloading = true;

//? Getters y Setters
    String get username => _username;
  set username(String value) {
    _username = value;
    notifyListeners();
  }

  String get email => _email;
  set email(String value) {
    _email = value;
    notifyListeners();
  }

  String get password => _password;
  set password(String value) {
    _password = value;
    notifyListeners();
  }

  String get repassword => _repassword;
  set repassword(String value) {
    _repassword = value;
    notifyListeners();
  }

  bool isvalidForm(){
     return registroKey.currentState?.validate() ?? false;

  }
  
  bool get isloading => _isloading;
  set isloading(bool value) {
    _isloading = value;
    notifyListeners();
  }
}
