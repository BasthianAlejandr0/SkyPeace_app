import 'package:app_skypeace_flight/presentation/pages/weather_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'firebase_options.dart';
import 'presentation/pages/form_flight_page.dart';
import 'presentation/pages/home_page.dart';
import 'presentation/pages/login_page.dart';
import 'presentation/pages/profile_page.dart';
import 'presentation/pages/pronostico_vuelo_page.dart';
import 'presentation/pages/signup_page.dart';

void main () async {
  WidgetsFlutterBinding.ensureInitialized();
  //*Inicializar Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );
  runApp(const MyApp());
}
//@
class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Login SkyPeace',
      initialRoute: 'Pronostico de vuelo',
      routes: {
        //Funcion anonima
        'Registro': (_) => const SignupPage(),
        'Inicio Sesion': (_) =>  LoginPage(),
        'Inicio': (_) =>  const HomePage(),
        'Perfil': (_) =>  const ProfilePage(),
        'Formulario de vuelo': (_) =>  const FormFlightPage(),
        'Pronostico de vuelo': (_) =>   const PronosticoVueloPage(),
        'Clima': (_) =>   const WeatherPage(),
        'Mindfulness': (_) =>   const Buttom_modal(),
      }
      
    );
  }
}
