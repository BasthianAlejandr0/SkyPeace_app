import 'package:flutter/material.dart';
import 'package:sky_peace_/presentations/widgets/profile_icon.dart';
import 'package:sky_peace_/presentations/widgets/list_menu.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        // Aplicando el gradiente
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomLeft,
            end: Alignment.bottomRight,
            colors: [
              Color.fromARGB(255, 14, 117, 201),
              Color.fromARGB(255, 109, 194, 239),
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Texto de bienvenida
                        const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "¡Hola, Usuario!",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            SizedBox(height: 10),
                            Text(
                              "¿A dónde volamos hoy?",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(width: 10),
                        const Spacer(),
                        // Icono de notificaciones
                        Container(
                          decoration: BoxDecoration(
                            color: const Color(0xFF1A92F4),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          padding: const EdgeInsets.all(5),
                            child: const ProfileIcon(),
                         ),
                        const SizedBox(width: 20),
                        // Icono de perfil
                        Container(
                          decoration: BoxDecoration(
                            color: const Color(0xFF1A92F4),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          padding: const EdgeInsets.all(5),
                          child: const ListMenu(),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: Container(
                  color: Colors.white, // El área blanca para el contenido principal
                ),
              ),
            ],
          ),
        ),
      ),
      // BottomNavigationBar
      bottomNavigationBar: buttomBar(),
    );
  }

  BottomNavigationBar buttomBar() {
    return BottomNavigationBar(
      backgroundColor: const Color.fromARGB(255, 71, 175, 255),
      items: const [
        BottomNavigationBarItem(
          icon: Icon(
            Icons.cloud,
            color: Color.fromARGB(255, 0, 61, 135),
          ),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.add,
            size: 40,
            color: Color.fromARGB(255, 0, 61, 135),
          ),
          label: 'Agregar',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.settings,
            color: Color.fromARGB(255, 0, 61, 135),
          ),
          label: '',
        ),
      ],
    );
  }
}

