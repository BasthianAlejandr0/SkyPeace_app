import 'package:flutter/material.dart';
import '../pages/form_flight_page.dart';

class AnimatedButtom extends StatefulWidget {
  const AnimatedButtom({super.key, required bool isPressed});

  @override
  _AnimatedFABState createState() => _AnimatedFABState();
}

class _AnimatedFABState extends State<AnimatedButtom> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  bool _isPressed = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

void _onButtonPressed() async {
  setState(() {
    _isPressed = !_isPressed;
  });

  // Ejecuta la animación
  if (_isPressed) {
    await _controller.forward();  // Espera que la animación avance
  } else {
    await _controller.reverse();  // Espera que la animación retroceda
  }

  // Añadir un pequeño retardo para que se vea la animación antes de la navegación
  await Future.delayed(const Duration(milliseconds: 300));

  // Navegar a la página del formulario después de la animación
  Navigator.push(
    // ignore: use_build_context_synchronously
    context,
    MaterialPageRoute(builder: (context) => const FormFlightPage()),
  ).then((_) {
    // Esto se ejecuta al regresar de la pantalla de FormFlightPage
    setState(() {
      _isPressed = false;  // Reinicia el estado del botón
    });
    _controller.reverse();  // Asegura que el botón regrese a su estado inicial
  });
}

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _onButtonPressed();
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        width: _isPressed ? 70 : 60,
        height: _isPressed ? 70 : 60,
        decoration: BoxDecoration(
          color: _isPressed ? Colors.lightBlueAccent : Colors.blue,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              spreadRadius: 4,
              blurRadius: 6,
            ),
          ],
        ),
        child: const Icon(
          Icons.add,
          size: 38,
          color: Colors.white,
        ),
      ),
    );
  }
}
