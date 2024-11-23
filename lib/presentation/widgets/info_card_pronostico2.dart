import 'package:flutter/material.dart';
import '../../core/constants/api_key_weather.dart';
import '../../core/models/weather_models.dart';
import '../../data/datasources/weather_services.dart';

class FlightInfoCarousel extends StatefulWidget {
  const FlightInfoCarousel({super.key});

  @override
  State<FlightInfoCarousel> createState() => _FlightInfoCarouselState();
}

class _FlightInfoCarouselState extends State<FlightInfoCarousel> {
  final _weatherServices = WeatherServices(apiKeyWeather);
  Weather? _weather;
  Weather? _departureWeather;  // Clima en el lugar de despegue
  Weather? _arrivalWeather;    // Clima en el lugar de aterrizaje
  String? _errorMessage;

  Future<void> _fetchWeather() async {
    try {
      String cityName = await _weatherServices.getCurrentCity();
      
      if (cityName.isEmpty) {
        setState(() {
          _errorMessage = 'No se pudo obtener la ciudad actual.';
        });
        return;
      }

      final weather = await _weatherServices.getWeather(cityName);
      setState(() {
        _weather = weather;
        _errorMessage = null;
      });
    } catch (e) {
      setState(() {
        _errorMessage = 'Error al obtener el clima: $e';
      });
    }
  }

  // Paso 2: Definir funciones para obtener el clima en el lugar de despegue y aterrizaje
  Future<void> evaluarTurbulenciaDespegue(String _depaert) async {
    try {
      final weather = await _weatherServices.getWeatherForCity(_departureWeather as String);
      setState(() {
        _departureWeather = weather;
        _errorMessage = null;
      });
    } catch (e) {
      setState(() {
        _errorMessage = 'Error al obtener el clima de despegue: $e';
      });
    }
  }

  Future<void> evaluarTurbulenciaAterrizaje(String arrivalCity) async {
    try {
      final weather = await _weatherServices.getWeatherForCity(arrivalCity);
      setState(() {
        _arrivalWeather = weather;
        _errorMessage = null;
      });
    } catch (e) {
      setState(() {
        _errorMessage = 'Error al obtener el clima de aterrizaje: $e';
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchWeather();
  }

  String evaluarTurbulencia(double windSpeed, double windGust, int clouds, int weatherId) {
    if (windSpeed > 20 || windGust > 25 || (weatherId >= 200 && weatherId < 300)) {
      return '⚠️ Turbulencia severa: Se recomienda permanecer sentado con el cinturón abrochado';
    } else if (windSpeed > 10 || windGust > 15 || clouds > 50 || (weatherId >= 500 && weatherId < 600)) {
      return '😯 Turbulencia moderada: Movimientos Irregulares de la aeronave';
    } else if (windSpeed > 5 || clouds > 30) {
      return '😌 Turbulencia leve: Pequeños Movimientos por parte de la aeronave';
    } else {
      return '😊 Turbulencia mínima: No hay nada de qué preocuparse, disfruta el viaje';
    }
  }

  String estadoCielo(int cloudCoverage) {
    if (cloudCoverage > 50) {
      return '🌥️ Cielo nublado: Posibles Turbulencias';
    } else if (cloudCoverage > 20) {
      return '⛅ Cielo parcialmente nublado';
    } else {
      return '☀️ Cielo despejado';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: _errorMessage != null
          ? Center(child: Text(_errorMessage!, style: const TextStyle(color: Colors.redAccent)))
          : _weather == null
              ? const Center(child: CircularProgressIndicator())
              : PageView(
                  children: [
                    _buildTurbulenceCard(),
                    _buildWeatherCard(),
                    _buildWindCard(),
                  ],
                ),
    );
  }

  Widget _buildTurbulenceCard() {
    return _infoCard(
      title: 'Turbulencia',
      icon: Icons.airline_seat_flat_angled,
      content: evaluarTurbulencia(
        _weather!.windSpeed,
        _weather!.windGust,
        _weather!.cloudCoverage,
        _weather!.weatherId,
      ),
      color: const Color.fromARGB(255, 182, 234, 252),
    );
  }

  Widget _buildWeatherCard() {
    return _infoCard(
      title: 'Estado del Cielo',
      icon: Icons.cloud,
      content: estadoCielo(_weather!.cloudCoverage),
      color: Colors.blue[100]!,
    );
  }

  Widget _buildWindCard() {
    return _infoCard(
      title: 'Condiciones de Viento',
      icon: Icons.air,
      content: "Viento: ${_weather!.windSpeed} Km/h\nRáfagas: ${_weather!.windGust} Km/h",
      color: const Color.fromARGB(255, 177, 225, 255),
    );
  }

  Widget _infoCard({
    required String title,
    required IconData icon,
    required String content,
    required Color color,
  }) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        color: color,
        elevation: 8,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 50, color: Colors.blueGrey[800]),
              const SizedBox(height: 15),
              Text(
                title,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueGrey[700],
                ),
              ),
              const SizedBox(height: 10),
              Text(
                content,
                style: const TextStyle(
                  fontSize: 18,
                  color: Colors.black87,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
