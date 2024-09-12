import 'package:flutter/material.dart';

class ListMenu extends StatelessWidget {
  const ListMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(itemBuilder:(context) {
      return [
        const PopupMenuItem(
          child: ListTile(
            leading: Icon(Icons.home),
            title: Text('Inicio'),
          ),
        ),
        const PopupMenuItem(
          child: ListTile(
            leading: Icon(Icons.person),
            title: Text('Perfil'),
          ),
        ),
        const PopupMenuItem(
          child: ListTile(
            leading: Icon(Icons.settings),
            title: Text('Configuración'),
          ),
        ),
        const PopupMenuItem(
          child: ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Cerrar Sesión'),
          ),
        ),
      ];
    }, 
    icon: const Icon(
      Icons.menu,
      size: 30,
      color: Colors.white,
      ),
    );
  }
}