import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthUpdateEmailButton extends ChangeNotifier {
  // ignore: unused_field
  final FirebaseAuth _auth = FirebaseAuth.instance;

  User? _user;
  User? get user => _user;


  Future<void> updateEmail(String newEmail) async {
    try {
      // ignore: deprecated_member_use
      await _user!.updateEmail(newEmail);
      print('Email actualizado');
    } catch (e) {
      print("Error al actualizar el correo:$e");
    }
    notifyListeners();
  }
}