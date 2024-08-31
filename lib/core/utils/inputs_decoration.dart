// File: Decoracion_inputs.dart
import 'package:flutter/material.dart';

class InputDecorations {

  static InputDecoration authInputDecoration({
     required String labelText,
     IconData? prefixIcon
  }){
    return  InputDecoration(
      enabledBorder: const UnderlineInputBorder(
        borderSide: BorderSide(
          color: Color.fromARGB(255, 255, 255, 255),
          strokeAlign: 12,
          width: 1.5
        ),
      ),
      focusedBorder: const UnderlineInputBorder(
        borderSide: BorderSide(
          color: Colors.white,
          width: 0
        )
      ),
      //hintText: 'Nombre de Usuario',
      labelText: labelText,
      labelStyle: const TextStyle(
        color: Colors.white
      ),
      prefixIcon: prefixIcon != null
        ?  Icon(prefixIcon, color:  Colors.white,)
        : null 
      
    );
  }


}