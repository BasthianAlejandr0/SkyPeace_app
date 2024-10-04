import 'dart:typed_data';
import 'package:app_skypeace_flight/core/utils/pickImage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../components/buttoms/logout_buttom.dart';
import '../providers/obtener_usuario.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
Uint8List? _image;

  void initState() {
    super.initState();
    // Cargar los detalles del usuario al iniciar el widget
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final userProvider = Provider.of<UserProvider>(context, listen: false);
      userProvider.getUserDetails();
    });
  }

  //Cargar Imagen
  void SelectImage() async{
   Uint8List? image = await pickImage(ImageSource.gallery);
   setState(() {
      _image = image;
   });
  }



  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context); // Obtener el usuario mediante el provider

    return ChangeNotifierProvider(
      create: (context) => UserProvider()..getUserDetails(),
      child: Scaffold(
        backgroundColor: const Color(0xFFF2F2F2), 
        appBar: AppBar(
          backgroundColor: const Color(0xFF0785F2), 
          centerTitle: true,
          elevation: 0,
          title: const Text(
            'Perfil de Usuario',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
        ),
        body: Column(
          children: [
            Column(
              children: [
                Container(
                  width: double.infinity, // Ocupa todo el ancho
                  decoration: const BoxDecoration(
                    color: Color(0xFF0785F2), // Azul intermedio
                    // borderRadius: BorderRadius.only(
                    //   bottomLeft: Radius.circular(30), // Bordes redondeados
                    //   bottomRight: Radius.circular(30),
                    // ),
                    // gradient: LinearGradient(
                    //   begin: Alignment.bottomLeft,
                    //   end: Alignment.bottomRight,
                    //   colors: [
                    //     Color.fromARGB(255, 14, 117, 201),
                    //     Color.fromARGB(255, 109, 194, 239),
                    //   ],
                    // ),
                  ),
                  padding: const EdgeInsets.only(top: 40, bottom: 80), // Espaciado del contenedor
                  child: Column(
                    children: [
                      _image != null ?
                      CircleAvatar(
                        radius: 75,
                        backgroundImage: MemoryImage(_image!),
                          )
                        ://el dos puntos es un else
                       const CircleAvatar(
                        backgroundColor: Color(0xFF99C8F2), // Azul claro para el fondo del avatar
                        //Tamaño del avatar
                        radius: 75,
                        backgroundImage: NetworkImage('https://i.pinimg.com/564x/de/6e/8d/de6e8d53598eecfb6a2d86919b267791.jpg'),
                        // child: Icon(
                        //   Icons.person,
                        //   size: 80,
                        //   color: Colors.white,
                        // ),
                      ),
                      const SizedBox(height: 5),
                      IconButton(
                        onPressed: () {
                          SelectImage();    
                        },
                        icon: const Icon(
                          Icons.add_a_photo,
                          color: Colors.white,
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: _buildUserDetails(userProvider),
                ),
                const SizedBox(height: 50),
                const LogoutButton(),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUserDetails(UserProvider userProvider) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Mis detalles:',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w500,
            color: Colors.black54,
          ),
        ),
        const SizedBox(height: 10),
        _buildDetailSection('Nombre de usuario:', userProvider.username),
        const SizedBox(height: 10),
        _buildDetailSection('Email:', userProvider.email),
      ],
    );
  }

  Widget _buildDetailSection(String label, String value) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
      decoration: BoxDecoration(
        color: const Color(0xFF0785F2), // Azul intermedio
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: const Color.fromARGB(255, 0, 0, 0).withOpacity(0.1),
            blurRadius: 10,
            spreadRadius: 10,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 18,
              color: Colors.white,
              fontWeight: FontWeight.w500
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                value,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
              IconButton(
                onPressed: () async{
                },
                icon: const Icon(
                  Icons.settings_outlined,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
