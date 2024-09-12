import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sky_peace_/presentations/components/details_user_components.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String _username = "Cargando...";
  String _email = "Cargando...";

  @override
  void initState() {
    super.initState();
    _getUserDetails();
  }
Future<void> _getUserDetails() async {
  User? user = FirebaseAuth.instance.currentUser;
  
  if (user != null) {
    setState(() {
      _email = user.email ?? "Correo no disponible";
    });

    try {
      // Obtener el documento del usuario desde Firestore usando el UID
      DocumentSnapshot<Map<String, dynamic>> userDoc = await FirebaseFirestore.instance
          .collection('usuarios')
          .doc(user.uid)  // Verifica que el UID sea correcto
          .get();

      if (userDoc.exists) {
        // Asegúrate de que el campo 'username' existe en el documento
        setState(() {
          _username = userDoc.data()?['username'] ?? "Nombre no disponible";
        });
      } else {
        setState(() {
          _username = "Usuario no encontrado en Firestore";
        });
      }
    } catch (e) {
      setState(() {
        _username = "Error al obtener datos: $e";
      });
    }
  } else {
    setState(() {
      _username = "Usuario no autenticado";
    });
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      appBar: AppBar(
        backgroundColor:  const Color.fromARGB(255, 15, 163, 255),
        centerTitle: true,
        title: const Text('Perfil de Usuario'),
        titleTextStyle: const TextStyle(
          color: Color.fromARGB(255, 255, 255, 255),
          fontSize: 25,
        ),
      ),
      body: ListView(
        children: [
          const SizedBox(height: 50),
          // Icono de perfil
          const Icon(
            Icons.person,
            size: 90,
            color: Color.fromARGB(255, 15, 163, 255),
          ),
          const SizedBox(height: 40),
          // Detalles del usuario
          const Padding(
            padding: EdgeInsets.only(left: 17),
            child: Text(
              'Mis detalles: ',
              style: TextStyle(
                fontSize: 18,
                fontFamily: 'Times New Roman',
                color: Color.fromARGB(255, 0, 0, 0),
              ),
              textAlign: TextAlign.left,
            ),
          ),
          // Mostrar el nombre de usuario obtenido de Firestore
          Card(
            margin: const EdgeInsets.all(8),
            color: const Color.fromARGB(255, 15, 163, 255),
            child: Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: DetailsUsers(
                text: _username,
                sectionName: 'Nombre de usuario: ',
              ),
            ),
          ),
          // Mostrar el correo electrónico obtenido de Firebase Auth
          Card(
            color: const Color.fromARGB(255, 15, 163, 255),
            margin: const EdgeInsets.all(8),
            child: Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: DetailsUsers(
                text: _email,
                sectionName: 'Email: ',
              ),
            ),
          ),
          IconButton(onPressed: (){},
           icon: const Icon(
            shadows: [
              Shadow(
                color: Colors.black,
                blurRadius: 10,
                offset: Offset(5, 5),
              ),
            ],
             Icons.logout,
             grade: 12,
             color: Colors.blue,
             size: 20,
           ), 
           )
        ],
      ),
    );
  }
}
