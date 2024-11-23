import 'package:flutter/material.dart';

class InfoPronostico extends StatelessWidget {
  final double nivelTurbulencia; // Nivel de turbulencia (0.0 - 1.0)
  final double porcentajeProgreso; // Progreso del vuelo (0.0 - 1.0)

  const InfoPronostico({
    required this.nivelTurbulencia,
    required this.porcentajeProgreso,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // Definimos los colores según la turbulencia
    Color getTurbulenceColor(double nivel) {
      if (nivel < 0.25) return Colors.green;
      if (nivel < 0.5) return Colors.yellow;
      if (nivel < 0.75) return Colors.orange;
      return Colors.red;
    }

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Pronóstico de vuelo",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),

            // Información de Velocidad, Altitud y Aeronave
            const Row(
              children: [
                Text(
                  "Velocidad",
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                SizedBox(width: 8),
                Icon(
                  Icons.speed,
                  color: Colors.blue,
                )
              ],
            ),
            const SizedBox(height: 10),
            const Row(
              children: [
                Text(
                  "Altitud",
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                SizedBox(width: 8),
                Icon(
                  Icons.height,
                  color: Colors.blue,
                )
              ],
            ),
            const SizedBox(height: 10),
            const Row(
              children: [
                Text(
                  "Aeronave",
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                SizedBox(width: 8),
                Icon(
                  Icons.airplanemode_active,
                  color: Colors.blue,
                )
              ],
            ),
            const SizedBox(height: 20),

            // Indicador de turbulencia con gradiente
            Container(
              height: 50,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                gradient: const LinearGradient(
                  colors: [
                    Colors.green,  // Sin turbulencia
                    Colors.yellow, // Turbulencia leve
                    Colors.orange, // Turbulencia moderada
                    Colors.red,    // Turbulencia severa
                  ],
                  stops: [0.25, 0.5, 0.75, 1.0],
                ),
              ),
              child: Center(
                child: Text(
                  nivelTurbulencia < 0.25
                      ? "Sin turbulencia"
                      : nivelTurbulencia < 0.5
                          ? "Turbulencia leve"
                          : nivelTurbulencia < 0.75
                              ? "Turbulencia moderada"
                              : "Turbulencia severa",
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),

            // Leyenda para los colores
            const Text(
              "Leyenda:",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 5),
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "🟩 Sin Turbulencia",
                  style: TextStyle(fontSize: 14),
                ),
                Text(
                  "🟨 Turbulencia Leve",
                  style: TextStyle(fontSize: 14),
                ),
                Text(
                  "🟧 Turbulencia Moderada",
                  style: TextStyle(fontSize: 14),
                ),
                Text(
                  "🟥 Turbulencia Severa",
                  style: TextStyle(fontSize: 14),
                ),
              ],
            ),
            const SizedBox(height: 30),

            // Barra de progreso del vuelo
            const Text(
              "Progreso del Vuelo",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            LinearProgressIndicator(
              value: porcentajeProgreso, // Progreso del vuelo (0.0 - 1.0)
              minHeight: 8.0, // Grosor de la barra
              backgroundColor: Colors.grey[300], // Color de fondo
              valueColor: const AlwaysStoppedAnimation<Color>(Colors.blue), // Color de progreso
            ),
            const SizedBox(height: 10),
            Text(
              "${(porcentajeProgreso * 100).toStringAsFixed(1)}% completado",
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}