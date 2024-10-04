
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../../core/utils/inputs_decoration.dart';
import '../providers/auth_google.dart';
import '../providers/auth_services_login.dart';
import '../providers/login_view_provider.dart';
import '../widgets/card_container.dart';
import '../widgets/fondo_view.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});
  
  //Controladores de los campos de texto
  final usernameCtrl = TextEditingController();
  final passwordCtrl = TextEditingController();

  //Inicio de sesion metodos



  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: FondoScreens(
        child: SingleChildScrollView(
          child: Column(
            children: [
               const SizedBox(height: 320,),
              CardContainer(
                child: Column(
                  children: [
                     const SizedBox(height: 5),
                     const Text(
                      "Bienvenido a SkyPeace",
                      style: TextStyle(
                        fontSize: 24,
                        color: Colors.white
                      ),
                    ),
                     const SizedBox(height: 10),
                     const Text(
                      "Inicia Sesión",
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white
                      ),
                    ),
                     const SizedBox(height: 20),
                    //! Esto sirve para que el provider se pueda usar en el widget hijo
                    ChangeNotifierProvider(
                      create: ( _ ) => LoginViewProvider(),
                      child:  const FormLogin(),//¿Que hace esto? es para que el provider se pueda usar en el widget hijo
                      ),
                  ],
                )
              ),
              const SizedBox(height: 50),
              const Text("Ya tienes una cuenta? Ingresa aquí"),
                 Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children:[
                    IconButton(
                      style: ButtonStyle(
                        iconSize: WidgetStateProperty.all(40),
                        iconColor: WidgetStateProperty.all(Colors.blue),
                      ),
                      icon: FaIcon(FontAwesomeIcons.google),
                      onPressed: () async {
                        try {
                          // Crear una instancia de AuthUserGoogle
                          final authService = AuthUserGoogle();
                          
                          // Iniciar sesión con Google y esperar el resultado
                          final user = await authService.loginGoogle();

                          if (user != null) {
                            // Si el login es exitoso, redirige a la página principal
                            Navigator.pushReplacementNamed(context, 'Inicio');
                          } else {
                            // Si falla el login, muestra un mensaje de error
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Error al iniciar sesión con Google'),
                                backgroundColor: Colors.red,
                              ),
                            );
                          }
                        } catch (e) {
                          // Si ocurre una excepción, muestra un mensaje de error
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Error al iniciar sesión con Google: $e'),
                              backgroundColor: Colors.red,
                            ),
                          );
                        }
                      },

                    ),
                    IconButton(
                      style: ButtonStyle(
                        iconSize: WidgetStateProperty.all(50),
                        iconColor: WidgetStateProperty.all(Colors.blue),
                      ),
                      icon: FaIcon(FontAwesomeIcons.facebook),
                      onPressed: () {
                        // Handle Google login
                        

                      },
                    ),
                  ],
                ),
                const SizedBox(height: 50,)
            ],
          ),
        )
      ),
    );
  }
}


//Formulario de registro
class FormLogin extends StatelessWidget {
  const FormLogin({super.key});
  @override
  Widget build(BuildContext context) {
    final loginProvider = Provider.of<LoginViewProvider>(context);
    // ignore: avoid_unnecessary_containers
    return Container(
      child: Form(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        //!MANTENER LA REFERENCIA AL KEY
        key: loginProvider.loginKey,
        child: Column(
          children: [
            const SizedBox(height: 30),
            TextFormField(
              style: const TextStyle(
                color: Colors.white,
              ),
              autocorrect: false,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecorations.authInputDecoration(
                labelText: "Correo Electrónico",
                prefixIcon: Icons.email 
              ),
              onChanged: (value) => loginProvider.email = value,
              validator: (value) {
                String pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                RegExp regExp  = new RegExp(pattern);
                return regExp.hasMatch(value ?? '')
                  ? null
                  : 'Correo no válido';
              },

            ),
            const SizedBox(height: 30),
            TextFormField(
              style: const TextStyle(
                color: Colors.white
              ),
              autocorrect: false,
              obscureText: true,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecorations.authInputDecoration(
                labelText: "Contraseña",
                prefixIcon: Icons.lock 
              ),
              onChanged: (value) => loginProvider.password = value,
              validator: (value) {
                if (value != null && value.length >= 6) {
                  return null;
                } else {
                  return 'Contraseña no válida';
                }
              },
            ),
            const SizedBox(height: 30),
            MaterialButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              disabledColor: Colors.black,
              elevation: 0,
              color: const Color.fromARGB(255, 255, 255, 255),
              // ignore: avoid_unnecessary_containers
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 5),
                // ignore: avoid_unnecessary_containers
                child: Container(
                  child: const Text(
                    "Iniciar Sesión",
                    style: TextStyle(
                      
                      fontSize: 18
                    ),
                    ),
                  
                ),
              ),
              //*Boton de registro de usuario
              onPressed: () async {
                    // Valida que el formulario sea válido
                if (!loginProvider.isValidForm()) return;
                    // Muestra un indicador de carga o desactiva el botón mientras se procesa la autenticación
                    loginProvider.isLoading = true;
                    final authService = AuthServicesLogin();
                    final user = await authService.login(
                      email: loginProvider.email,
                      password: loginProvider.password,
                    );
                    // Oculta el indicador de carga una vez completado
                    loginProvider.isLoading = false;
                    if (user != null) {
                      // Si el login es exitoso, redirige a la página principal
                      Navigator.pushReplacementNamed(context, 'Inicio');
                    } else {
                      // Si falla el login, muestra un mensaje de error
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Correo o contraseña incorrectos'),
                          backgroundColor: Colors.red,
                        ),
                      );
                    }
              },
            ),
            const SizedBox(height: 10),
            const Text("¿Olvidaste tu contraseña?", style: TextStyle(color: Colors.white),)
          ],
        ),
      ),
    );
  }
}

