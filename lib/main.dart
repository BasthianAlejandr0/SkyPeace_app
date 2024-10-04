import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'firebase_options.dart';
import 'presentation/pages/form_flight_page.dart';
import 'presentation/pages/home_page.dart';
import 'presentation/pages/login_page.dart';
import 'presentation/pages/profile_page.dart';
import 'presentation/pages/signup_page.dart';

void main () async {
  WidgetsFlutterBinding.ensureInitialized();
  //*Inicializar Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Login SkyPeace',
      initialRoute: 'Inicio',
      routes: {
        //Funcion anonima
        'Registro': (_) => const SignupPage(),
        'Inicio Sesion': (_) =>  LoginPage(),
        'Inicio': (_) =>  const HomePage(),
        'Perfil': (_) =>  const ProfilePage(),
        'Formulario de vuelo': (_) =>  const FormFlightPage(),
      }
      
    );
  }
}
