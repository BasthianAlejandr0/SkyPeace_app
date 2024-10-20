import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';



class VuelosDataBase {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Método para guardar datos de un vuelo
  Future<void> saveFlightData({
    required String aircraftType,
    required String airlineCode,
    required String airlineName,
    required String arrivalAirportCode,
    required String departureAirportCode,
    required String departureTime,
    required String estimatedDuration,
    required String flightNumber,
    required String status,
  }) async {
    try {
      await _db.collection('vuelos').add({
        'aircraftType': aircraftType,
        'airlineCode': airlineCode,
        'airlineName': airlineName,
        'arrivalAirportCode': arrivalAirportCode,
        'departureAirportCode': departureAirportCode,
        'departureTime': departureTime,
        'estimatedDuration': estimatedDuration,
        'flightNumber': flightNumber,
        'status': status,
        'usuarioId': _auth.currentUser!.uid,
        'createdAt': FieldValue.serverTimestamp(),
      });
      // ignore: avoid_print
      print('Datos del vuelo guardados exitosamente.');
    } catch (e) {
      // ignore: avoid_print
      print('Error al guardar los datos del vuelo: $e');
    }
  }

  // Método para obtener los vuelos del usuario autenticado
  Future<void> getFlightCollection() async {
    try {
      final result = await _db.collection('vuelos')
        .where('usuarioId', isEqualTo: _auth.currentUser!.uid)
        .get();

      for (var doc in result.docs) {
        // ignore: avoid_print
        print(doc.data());
      }
    } catch (e) {
      // ignore: avoid_print
      print('Error al obtener los datos de los vuelos: $e');
    }
  }
}
