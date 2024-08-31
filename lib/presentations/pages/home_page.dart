import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("SkyPeace"),
          actions: [
            
          ],

        ),
        body: Container(
          child: Center(
            child: Column(
              children: [
                Text("Bienvenido a SkyPeace"),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, 'Inicio Sesion');
                  },
                  child: Text("Iniciar Sesion"),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, 'Registro');
                  },
                  child: Text("Registrarse"),
                ),
              ],
            ),
              
          ),
        )
    );
  }
}