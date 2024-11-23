import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class VuelosDataBase {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Método para guardar datos de un vuelo evitando duplicados
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
    required String speed,
    required String geography,
  }) async {
    try {
      final result = await _db.collection('vuelos')
          .where('flightNumber', isEqualTo: flightNumber)
          .where('departureTime', isEqualTo: departureTime)
          .where('departureAirportCode', isEqualTo: departureAirportCode)
          .where('usuarioId', isEqualTo: _auth.currentUser!.uid)
          .get();

      if (result.docs.isEmpty) {
        await _db.collection('vuelos').add({
          'aircraftType': aircraftType,
          'airlineCode': airlineCode,
          'airlineName': airlineName,
          'arrivalAirportCode': arrivalAirportCode,
          'departureAirportCode': departureAirportCode,
          'departureTime': departureTime,
          'estimatedDuration': estimatedDuration,
          'flightNumber': flightNumber,
          'geography': geography,
          'status': status,
          'speed': speed,
          'usuarioId': _auth.currentUser!.uid,
          'createdAt': FieldValue.serverTimestamp(),
        });
        print('Datos del vuelo guardados exitosamente.');
      } else {
        print('El vuelo ya existe en la base de datos, no se guardará de nuevo.');
      }
    } catch (e) {
      print('Error al guardar los datos del vuelo: $e');
    }
  }

  // Método para escuchar en tiempo real los vuelos del usuario autenticado
  void listenToFlightCollection() {
    _db.collection('vuelos')
      .where('usuarioId', isEqualTo: _auth.currentUser!.uid)
      .snapshots()
      .listen((snapshot) {
        for (var doc in snapshot.docs) {
          print(doc.data()); // Aquí puedes actualizar la interfaz o manejar los datos en tiempo real.
        }
      }, onError: (e) {
        print('Error al escuchar los datos de los vuelos: $e');
      });
  }
}
