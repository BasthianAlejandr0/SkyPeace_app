import 'package:flutter/material.dart';

class MindfulnessBreathingPage extends StatefulWidget {
  const MindfulnessBreathingPage({super.key});

  @override
  State<MindfulnessBreathingPage> createState() => _MindfulnessBreathingPageState();
}

class _MindfulnessBreathingPageState extends State<MindfulnessBreathingPage> {
  double _size = 100; // Tamaño inicial de la esfera (punto final de exhalación)
  int _duration=0; // Duración de la animación
  bool _isBreathing = false; // Indica si el ciclo está activo
  bool _showCountdown = false; // Indica si se está mostrando la cuenta regresiva
  int _countdown = 3; // Cuenta regresiva inicial

  @override
  void dispose() {
    // Asegura detener el ciclo de respiración al destruir el widget
    _isBreathing = false;
    super.dispose();
  }

  void _startCountdown() async {
    setState(() {
      _showCountdown = true;
      _size = 100; // Aseguramos que empiece en el tamaño de exhalación
      _duration = 0; // Sin animación para el tamaño inicial
    });

    for (int i = _countdown; i > 0; i--) {
      if (!mounted) return; // Verifica si el widget sigue montado
      setState(() {
        _countdown = i;
      });
      await Future.delayed(const Duration(seconds: 1));
    }

    if (!mounted) return; // Verifica si el widget sigue montado
    setState(() {
      _showCountdown = false;
      _isBreathing = true;
    });

    _startBreathingCycle(); // Iniciar el ciclo de respiración después de la cuenta regresiva
  }

  void _startBreathingCycle() async {
    while (_isBreathing && mounted) {
      // Inhala
      if (!mounted) return; // Verifica si el widget sigue montado
      setState(() {
        _size = 200; // Tamaño de expansión
        _duration = 4000; // 4 segundos para inhalar
      });
      await Future.delayed(Duration(milliseconds: _duration));

      // Mantén
      if (!mounted) return; // Verifica si el widget sigue montado
      setState(() {
        _duration = 7000; // 7 segundos para mantener
      });
      await Future.delayed(Duration(milliseconds: _duration));

      // Exhala
      if (!mounted) return; // Verifica si el widget sigue montado
      setState(() {
        _size = 100; // Tamaño original al exhalar
        _duration = 8000; // 8 segundos para exhalar
      });
      await Future.delayed(Duration(milliseconds: _duration));
    }
  }

  void _stopBreathingCycle() {
    setState(() {
      _isBreathing = false;
      _size = 100; // Resetear el tamaño de la esfera
      _duration = 0; // Resetear la duración
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Respiración Mindfulness'),
        backgroundColor: const Color.fromARGB(255, 71, 175, 255),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Sigue la esfera para respirar:',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.blueAccent,
              ),
            ),
            const SizedBox(height: 20),
            if (_showCountdown)
              Text(
                '$_countdown',
                style: const TextStyle(fontSize: 50, fontWeight: FontWeight.bold, color: Colors.red),
              )
            else
              AnimatedContainer(
                duration: Duration(milliseconds: _duration), // Controla la duración de cada transición
                width: _size,
                height: _size,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 138, 202, 255),
                  shape: BoxShape.circle,
                ),
              ),
            const SizedBox(height: 40),
            const Text(
              'Inhala durante 4 segundos\nMantén durante 7 segundos\nExhala durante 8 segundos',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, color: Colors.black54),
            ),
            const SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: !_isBreathing && !_showCountdown ? _startCountdown : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 71, 175, 255),
                  ),
                  child: const Text(
                    'Comenzar',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                const SizedBox(width: 20),
                ElevatedButton(
                  onPressed: _isBreathing ? _stopBreathingCycle : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                  ),
                  child: const Text(
                    'Finalizar',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
