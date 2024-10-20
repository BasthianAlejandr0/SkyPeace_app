import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../../core/constants/api_key.dart';
import '../../core/models/flight_models.dart';
import '../../data/datasources/vuelosDataBase.dart';

class FormFlightPage extends StatefulWidget {
  const FormFlightPage({super.key});

  @override
  State<FormFlightPage> createState() => _FormFlightPageState();
}

class _FormFlightPageState extends State<FormFlightPage> {

  final VuelosDataBase vuelosDB = VuelosDataBase();
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _flightNumberController = TextEditingController();//Controlador del número de vuelo
  final TextEditingController _airlineController = TextEditingController(); //Controlador del código de aerolínea
  final TextEditingController _departureAirportController = TextEditingController();//Controlador del aeropuerto de salida
  final TextEditingController _aircraftTypeController = TextEditingController();//Controlador del tipo de aeronave
  final TextEditingController _airlineCodeController = TextEditingController();//Controlador del código de aerolínea
  final TextEditingController _airlineNameController = TextEditingController();//Controlador del nombre de la aerolínea
  final TextEditingController _arrivalAirportCodeController = TextEditingController();//Controlador del código del aeropuerto de llegada
  final TextEditingController _departureAirportCodeController = TextEditingController();//Controlador del código del aeropuerto de salida
  final TextEditingController _departureTimeController = TextEditingController();//Controlador de la hora de salida
  final TextEditingController _estimatedDurationController = TextEditingController();//Controlador de la duración estimada
  final TextEditingController _statusController = TextEditingController();//Controlador del estado del vuelo
  FlightNum? flight;
  bool isLoading = false;

  // Función para obtener datos del vuelo por número por aerolínea y número de vuelo	
 Future<void> getFlightByNumber(String airline, String flightNumber) async {
  const String endpoint = 'https://aviation-edge.com/v2/public/flights';

  setState(() {
    isLoading = true;
  });

  try {
    final response = await Dio().get(
      '$endpoint?airlineIata=$airline&flightNum=$flightNumber&key=$apiKey',
    );

    if (response.data != null && response.data.isNotEmpty) {
      final flightData = response.data[0];
      flight = FlightNum.fromJson(flightData);

    // Guardar en Firestore después de obtener el vuelo
    vuelosDB.saveFlightData(
      aircraftType: flight?.aircraft.iataCode ?? '', // Tipo de aeronave
      airlineCode: flight?.airline.iataCode ?? '',  // Código IATA de la aerolínea
      airlineName: flight?.airline.icaoCode ?? '',  // Código ICAO de la aerolínea
      arrivalAirportCode: flight?.arrival.iataCode ?? '', // Código IATA de llegada
      departureAirportCode: flight?.departure.iataCode ?? '', // Código IATA de salida
      departureTime: flight?.system.updated.toString() ?? '', // Hora de salida programada
      estimatedDuration: '', // Duración estimada (añádela si está disponible en otro campo)
      flightNumber: flight?.flight.number ?? '', // Número de vuelo
      status: flight?.status ?? '', // Estado del vuelo
    );



      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Datos del vuelo guardados en Firestore')),
      );
    } else {
      flight = null;
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Vuelo no encontrado')),
      );
    }

    setState(() {});
  } catch (e) {
    // ignore: avoid_print
    print('Error al obtener datos del vuelo: $e');
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Error al obtener datos del vuelo.')),
    );
    flight = null;
  } finally {
    setState(() {
      isLoading = false;
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
          key: _formKey,
          child: ListView(
            children: [
              Image.network(
                'https://static.vecteezy.com/system/resources/previews/016/469/204/original/airplane-logo-illustration-plane-silhouette-design-vector.jpg',
                height: 100,
              ),
              const SizedBox(height: 20),
              const Text(
                "Buscar por aerolínea y número de vuelo",
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 5),
              TextFormField(
                controller: _airlineController, // Controlador del código de aerolínea
                cursorColor: Colors.blue,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                  floatingLabelStyle: TextStyle(color: Colors.blue),
                  hintStyle: TextStyle(color: Colors.grey),
                  labelStyle: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                  labelText: 'Código de Aerolínea',
                  hintText: 'Ejemplo: LAN',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, ingresa el código de aerolínea';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _flightNumberController,
                cursorColor: Colors.blue,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  floatingLabelStyle: TextStyle(color: Colors.blue),
                  hintStyle: TextStyle(color: Colors.grey),
                  labelStyle: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                  labelText: 'N° de vuelo',
                  hintText: 'Ejemplo: 535',
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
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // Llama a la función de búsqueda con ambos parámetros
                    getFlightByNumber(
                      _airlineController.text.trim(), 
                      _flightNumberController.text.trim()
                      );
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Procesando búsqueda...')),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
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
              
              if (flight != null) ...[
                const SizedBox(height: 20),
                  const Text(
                    'Detalles del Vuelo:',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ],
                const SizedBox(height: 10),
                Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Número de vuelo:',
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.grey[700]),
                            ),
                            Text(
                              '${flight?.flight.number}',
                              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.blue),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Aerolínea:',
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.grey[700]),
                            ),
                            Text(
                              '${flight?.airline.iataCode}',
                              style: TextStyle(fontSize: 16, color: Colors.blue[700]),
                            ),
                          ],
                        ),
                        const Divider(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Salida:',
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.grey[700]),
                            ),
                            Text(
                              '${flight?.departure.iataCode}',
                              style: TextStyle(fontSize: 16, color: Colors.green[700]),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Llegada:',
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.grey[700]),
                            ),
                            Text(
                              '${flight?.arrival.iataCode}',
                              style: TextStyle(fontSize: 16, color: Colors.red[700]),
                            ),
                          ],
                        ),
                        const Divider(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Estado:',
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.grey[700]),
                            ),
                            Text(
                              '${flight?.status}',
                              style: TextStyle(
                                fontSize: 16,
                                color: flight?.status == 'active' ? Colors.green : Colors.red,
                                fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const Divider(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                        Text(
                          'Tipo de aeronave:',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.grey[700]),
                        ),
                        Text(
                          '${flight?.aircraft.iataCode}',
                          style: TextStyle(fontSize: 16, color: Colors.blue[700]),
                        ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                        Text(
                          'Código de aerolínea:',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.grey[700]),
                        ),
                        Text(
                          '${flight?.airline.iataCode}',
                          style: TextStyle(fontSize: 16, color: Colors.blue[700]),
                        ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                        Text(
                          'Nombre de aerolínea:',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.grey[700]),
                        ),
                        Text(
                          '${flight?.airline.icaoCode}',
                          style: TextStyle(fontSize: 16, color: Colors.blue[700]),
                        ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                        Text(
                          'Código del aeropuerto de llegada:',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.grey[700]),
                        ),
                        Text(
                          '${flight?.arrival.iataCode}',
                          style: TextStyle(fontSize: 16, color: Colors.red[700]),
                        ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                        Text(
                          'Código del aeropuerto de salida:',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.grey[700]),
                        ),
                        Text(
                          '${flight?.departure.iataCode}',
                          style: TextStyle(fontSize: 16, color: Colors.green[700]),
                        ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                        Text(
                          'Hora de salida:',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.grey[700]),
                        ),
                        Text(
                          '${flight?.system.updated}',
                          style: TextStyle(fontSize: 16, color: Colors.blue[700]),
                        ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),  
    );
  }
}