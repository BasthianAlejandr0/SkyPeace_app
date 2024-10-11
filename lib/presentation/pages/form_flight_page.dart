import 'package:app_skypeace_flight/core/models/flightNum.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../../core/constants/api_key.dart';

class FormFlightPage extends StatefulWidget {
  const FormFlightPage({super.key});

  @override
  State<FormFlightPage> createState() => _FormFlightPageState();
}

class _FormFlightPageState extends State<FormFlightPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _flightNumberController = TextEditingController();
  FlightNum? flight; // Variable para almacenar los datos del vuelo
  bool isLoading = false; // Estado de carga

  Future<void> getFlightByNumber(String flightNumber) async {
    const String endpoint = 'https://aviation-edge.com/v2/public/flights';

    setState(() {
      isLoading = true; // Inicia la carga
    });

    try {
      final response = await Dio().get(
        '$endpoint?flightNum=$flightNumber&key=$apiKey',
      );

      if (response.data != null && response.data.isNotEmpty) {
        final flightData = response.data[0]; // Obtiene el primer vuelo de la respuesta
        flight = FlightNum.fromJson(flightData); // Convierte el JSON a un objeto FlightNum
      } else {
        flight = null; // Si no hay datos, establece flight a null
      }

      setState(() {}); // Actualiza la UI
    } catch (e) {
      print('Error al obtener datos del vuelo: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error al obtener datos del vuelo.')),
      );
      flight = null; // Si hay un error, establece flight a null
    } finally {
      setState(() {
        isLoading = false; // Finaliza la carga
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Formulario de vuelo',
          style: TextStyle(
            color: Colors.white,
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Form(
          key: _formKey, // Clave del formulario
          child: ListView(
            children: [
              Image.network(
                'https://static.vecteezy.com/system/resources/previews/016/469/204/original/airplane-logo-illustration-plane-silhouette-design-vector.jpg',
                height: 100,
              ),
              const SizedBox(height: 20),
              const Text(
                "Buscar por número de vuelo",
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 5),
              TextFormField(
                controller: _flightNumberController,
                cursorColor: Colors.blue,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  floatingLabelStyle: TextStyle(color: Colors.blue),
                  hintStyle: TextStyle(color: Colors.grey),
                  labelStyle: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                  labelText: 'N° de vuelo',
                  hintText: 'Ejemplo: 1234',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, ingresa el número de vuelo';
                  } else if (!RegExp(r'^[0-9]{1,4}$').hasMatch(value)) {
                    return 'El número debe ser entre 1 y 4 dígitos';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 100),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    getFlightByNumber(_flightNumberController.text);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Procesando búsqueda...')),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: const EdgeInsets.symmetric(
                      vertical: 15, horizontal: 20),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: isLoading
                    ? const CircularProgressIndicator(
                        color: Colors.white,
                      )
                    : const Text(
                        'Buscar',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
              ),
              // Muestra los detalles del vuelo aquí
              if (flight != null) ...[
                const SizedBox(height: 20),
                Text(
                  'Detalles del Vuelo:',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Text('Número de vuelo: ${flight?.flight.number}'),
                Text('Aerolínea: ${flight?.airline.iataCode}'),
                Text('Llegada: ${flight?.arrival.iataCode}'),
                Text('Salida: ${flight?.departure.iataCode}'),
                Text('Estado: ${flight?.status}'),
                // Agrega más detalles según la estructura de tu modelo FlightNum
              ],
            ],
          ),
        ),
      ),
    );
  }
}
