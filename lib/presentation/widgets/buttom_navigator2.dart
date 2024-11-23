import 'package:flutter/material.dart';

class CustomBottomBar extends StatelessWidget {
  const CustomBottomBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: const Color.fromARGB(255, 71, 175, 255),
      items: const [
        BottomNavigationBarItem(
          icon: Icon(
            Icons.cloud,
            color: Color.fromARGB(255, 255, 255, 255),
          ),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.sunny,
            color: Color.fromARGB(255, 255, 255, 255),
          ),
          label: '',
        ),
        
      ],
      currentIndex: 0, // establece el índice predeterminado
      onTap: (index) {
        // Cambiar la página
        if (index == 0) {
          Navigator.pushNamed(context, 'Clima');
        }
      },
    );
  }
}