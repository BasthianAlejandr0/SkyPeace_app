
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sky_peace_/presentations/controllers/auth_services_signup.dart';
import '../../core/utils/inputs_decoration.dart';
import '../providers/registro_view_provider.dart';
import '../widgets/card_container.dart';
import '../widgets/fondo_view.dart';

class SignupPage extends StatelessWidget {
  const SignupPage({super.key});
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FondoScreens(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 320),
              CardContainer(
                child: Column(
                  children: [
                    const SizedBox(height: 5),
                    const Text(
                      "Regístrate",
                      style: TextStyle(
                        fontSize: 24,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 20),
                    ChangeNotifierProvider(
                      create: (_) => RegistroViewProvider(),
                      child: const FormRegister(),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 50),
              const Text("¿Ya tienes una cuenta? Ingresa aquí"),
              const SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }
}

class FormRegister extends StatelessWidget {
  const FormRegister({super.key});

  @override
  Widget build(BuildContext context) {
    final formRegister = Provider.of<RegistroViewProvider>(context);

    return Form(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      key: formRegister.registroKey,
      child: Column(
        children: [
          TextFormField(
            style: const TextStyle(
              color: Color.fromARGB(255, 255, 255, 255),
            ),
            autocorrect: false,
            keyboardType: TextInputType.text,
            decoration: InputDecorations.authInputDecoration(
              labelText: "Nombre de usuario",
              prefixIcon: Icons.person,
            ),
            onChanged: (value) => formRegister.username = value,
          ),
          const SizedBox(height: 30),
          TextFormField(
            style: const TextStyle(color: Colors.white),
            autocorrect: false,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecorations.authInputDecoration(
              labelText: "Correo Electrónico",
              prefixIcon: Icons.email,
            ),
            onChanged: (value) => formRegister.email = value,
            validator: (value) {
              String pattern =
                  r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$';
              RegExp regExp = RegExp(pattern);
              return regExp.hasMatch(value ?? '')
                  ? null
                  : 'No es un correo válido';
            },
          ),
          const SizedBox(height: 30),
          TextFormField(
            style: const TextStyle(color: Colors.white),
            autocorrect: false,
            obscureText: true,
            decoration: InputDecorations.authInputDecoration(
              labelText: "Crea tu contraseña",
              prefixIcon: Icons.lock,
            ),
            onChanged: (value) => formRegister.password = value,
            validator: (value) {
              if (value != null && value.length >= 6) {
                return null;
              } else {
                return 'La contraseña debe tener al menos 6 caracteres';
              }
            },
          ),
          const SizedBox(height: 30),
          TextFormField(
            style: const TextStyle(color: Colors.white),
            autocorrect: false,
            obscureText: true,
            decoration: InputDecorations.authInputDecoration(
              labelText: "Reingresa tu contraseña",
              prefixIcon: Icons.lock,
            ),
            onChanged: (value) => formRegister.repassword = value,
            validator: (value) {
              if (value != null && value.length >= 6) {
                return null;
              } else {
                return 'La contraseña debe tener al menos 6 caracteres';
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
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 50, vertical: 5),
              child: Text(
                "Crear cuenta",
                style: TextStyle(fontSize: 18),
              ),
            ),
            onPressed: () async {
              if (formRegister.isvalidForm()) {
                try {
                  await AuthServicesSignup().signup(
                    email: formRegister.email,
                    password: formRegister.password,
                    username: formRegister.username,
                    repassword: formRegister.repassword,
                  );
                  Navigator.pushNamed(context, 'Inicio Sesion');
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(e.toString())),
                  );
                }
              }
            },
          ),
        ],
      ),
    );
  }
}
