import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../core/models/weather_models.dart'; // Para decodificar la respuesta JSON

class WeatherServices {
  static const BASE_URL = 'https://api.openweathermap.org/data/2.5/weather';
  final String apiKey;

  WeatherServices(this.apiKey);

Future<Weather> getWeather(String cityName) async {
  final url = Uri.parse('$BASE_URL?q=$cityName&appid=$apiKey&units=metric');
  final response = await http.get(url);
  
  if (response.statusCode == 200) {
    final data = json.decode(response.body);
    return Weather.fromJson(data);  // Asegúrate de que la clase Weather esté correctamente configurada
  } else {
    throw Exception('Failed to load weather data');
  }
}

 // Método para obtener el clima de una ciudad por su nombre
  Future<Weather> getWeatherForCity(String city) async {
    return await getWeather(city);
  }


  Future<String> getCurrentCity() async {
  // Verificar si la aplicación tiene permiso para acceder a la ubicación
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    // Obtener la ubicación actual
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high
      );
    // Obtener el nombre de la ciudad a partir de la ubicación
    List<Placemark> placemarks = await placemarkFromCoordinates(
      position.latitude, position.longitude
    );
    // Devolver el nombre de la ciudad
    String? cityName = placemarks[0].locality;
    return cityName ?? '';
  }
}
