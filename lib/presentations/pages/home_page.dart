import 'package:flutter/material.dart';
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(181, 0, 119, 255),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(25.0),
              child: Center(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        //Texto de bienvenida
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Holaaa Dakota",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.w400
                              ),
                            ),
                            SizedBox(height: 10,),
                            Text(
                              "¿A dónde volamos hoy?",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w400
                              ),
                            )
                          ],
                        ),
                        SizedBox(width: 10,),
                        //Icono de perfil
                        Container(
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 26, 146, 244),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          padding: EdgeInsets.all(12),
                          child: Icon(
                            Icons.notifications,
                            size: 30,
                            color: const Color.fromARGB(255, 255, 255, 255),
                          ),
                        )
                      ],
                    )
                  ],
                )
                  
              ),
            ),
        ),

//-----------------BottonNavigationBar-----------------
        //BottomNavigationBar es un widget que se coloca en la parte inferior de la pantalla
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.white,
          items: [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.cloud,
                color: const Color.fromARGB(255, 0, 61, 135),
                ),
              label: 'Inicio'
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.add,
                color: const Color.fromARGB(255, 0, 61, 135),
                ),
              label: 'Agregar vuelo'
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.settings,
                color: const Color.fromARGB(255, 0, 61, 135),
                ),
              label: 'Ajustes',
              
            ),
          ],
        ),
    );
  }
}
