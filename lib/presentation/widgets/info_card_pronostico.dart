import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart'; // Importamos FirebaseAuth para obtener el uid
import '../../core/models/flight_models.dart';

class InfoPronostico extends StatefulWidget {
  const InfoPronostico({super.key});

  @override
  State<InfoPronostico> createState() => _InfoPronosticoState();
}

class _InfoPronosticoState extends State<InfoPronostico> {
  final TextEditingController _flightNumberController = TextEditingController();
  final TextEditingController _speedController = TextEditingController();
  final TextEditingController _aircraftController = TextEditingController();

  FlightNum? flight;
  bool isLoading = false;
  Map<String, dynamic>? flightData;

  // Método para obtener la información desde Firestore basado en el UID del usuario
 Future<void> getFlightData() async {
  setState(() {
    isLoading = true;
  });

  final String? uid = FirebaseAuth.instance.currentUser?.uid;

  if (uid != null) {
    try {
      // Realiza una consulta a la colección 'vuelos' para obtener todos los vuelos del usuario
      final QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('vuelos')
          .where('usuarioId', isEqualTo: uid)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        // Obtén el primer vuelo de la lista (o itera sobre los documentos si deseas mostrar varios)
        final flightData = querySnapshot.docs.first.data() as Map<String, dynamic>;

        setState(() {
          _flightNumberController.text = flightData['flightNumber'] ?? '';
          _speedController.text = flightData['speed'] ?? '';
          _aircraftController.text = flightData['aircraftType'] ?? '';
        });
      } else {
        print("No se encontró información de vuelo para este usuario.");
      }
    } catch (e) {
      print('Error al obtener la información del vuelo: $e');
    }
  } else {
    print("Usuario no autenticado.");
  }

  setState(() {
    isLoading = false;
  });
}

  @override
  void initState() {
    super.initState();
    getFlightData();
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Center(child: CircularProgressIndicator())
        : Padding(
          padding: const EdgeInsets.all(10),
          child: Card(
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
                      "Información de vuelo:",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        const Icon(Icons.speed, color: Colors.blue),
                        const SizedBox(
                          width: 10,
                        ),
                        const Text(
                          "Número de vuelo:",
                          style: TextStyle(fontSize: 16),
                        ),
                        const SizedBox(width: 10),
                        const SizedBox(width: 10),
                        Text(
                          _flightNumberController.text,// Muestra el número de vuelo
                          style: const TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        const Icon(Icons.speed, color: Colors.blue),
                        const SizedBox(
                          width: 10,
                        ),
                        const Text(
                          "Velocidad Horizontal:",
                          style: TextStyle(fontSize: 16),
                        ),
                        const SizedBox(width: 10),
                        const SizedBox(width: 10),
                        Text(
                          _speedController.text,// Muestra la velocidad horizontal
                          style: const TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        const Icon(Icons.airplanemode_active, color: Colors.blue),
                        const SizedBox(
                          width: 10,
                        ),
                        const Text(
                          "Aeronave:",
                          style: TextStyle(fontSize: 16),
                        ),
                        const SizedBox(width: 10),
          
                        const SizedBox(width: 10),
                        Text(
                          _aircraftController.text,// Muestra el tipo de aeronave
                          style: const TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
        );
  }
}
