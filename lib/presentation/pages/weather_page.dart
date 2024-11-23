import 'package:app_skypeace_flight/data/datasources/weather_services.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../core/constants/api_key_weather.dart';
import '../../core/models/weather_models.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPage();
}

class _WeatherPage extends State<WeatherPage> {
  final  _weatherServices = WeatherServices(apiKeyWeather);
  Weather? _weather;
  String? _errorMessage;

 _fetchWeather() async {
  String cityName = await _weatherServices.getCurrentCity();
  
  if (cityName == null || cityName.isEmpty) {
    setState(() {
      _errorMessage = 'No se pudo obtener la ciudad actual.';
    });
    return;
  }

  try {
    final weather = await _weatherServices.getWeather(cityName);
    setState(() {
      _weather = weather;
    });
  } catch (e) {
    print(e);
    };
  }
  String evaluarTurbulencia(double windSpeed, double windGust, int clouds, int weatherId) {
  if (windSpeed > 20 || windGust > 25 || (weatherId >= 200 && weatherId < 300)) {
    return 'Turbulencia severa: se esperan condiciones climáticas adversas, como tormentas.';
  } else if (windSpeed > 10 || windGust > 15 || clouds > 50 || (weatherId >= 500 && weatherId < 600)) {
    return 'Turbulencia moderada: hay vientos fuertes y nubes densas en la ruta.';
  } else if (windSpeed > 5 || clouds > 30) {
    return 'Turbulencia leve: vientos y nubes dispersas.';
  } else {
    return 'Turbulencia mínima: condiciones de vuelo en calma.';
  }
}


  @override
  void initState() {
    super.initState();
    _fetchWeather();
}


    // Función para seleccionar animación basada en el clima
  Widget _getWeatherAnimation(String mainDescription) {
    switch (mainDescription.toLowerCase()) {
      case 'clear':
        return Lottie.asset('assets/Sun.json', width: 150, height: 150);
      case 'clouds':
        return Lottie.asset('assets/Clouds.json', width: 150, height: 150);
      case 'few clouds':
      case 'scattered clouds':
        return Lottie.asset('assets/SemiCloud.json', width: 150, height: 150);
      case 'rain':
        return Lottie.asset('assets/Rain.json', width: 150, height: 150);
      default:
        return Lottie.asset('assets/DefaultWeather.json', width: 150, height: 150);
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF076DF2),  // Color azul oscuro del cielo
              Color(0xFF99C8F2),  // Color claro del cielo y las nubes
            ],
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (_errorMessage != null)
                  Text(
                    _errorMessage!,
                    style: const TextStyle(
                      fontSize: 18,
                      color: Colors.redAccent,
                      fontWeight: FontWeight.w600,
                    ),
                  )
                else if (_weather != null)
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(16.0),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              blurRadius: 10,
                              offset: const Offset(0, 5),
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            Text(
                              _weather?.cityName?? 'Cargando...',
                              style: const TextStyle(
                                fontSize: 32,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              '${_weather?.temperatureCelsius.toString()}°C',
                              style: const TextStyle(
                                fontSize: 72,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 20),
                            // Animación de clima basada en el tipo de clima
                            _getWeatherAnimation(_weather!.mainDescription),
                            const SizedBox(height: 20),
                            Text(
                              _weather?.mainDescription ?? 'Cargando...',
                              style: const TextStyle(
                                fontSize: 24,
                                color: Colors.white70,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              'Viento: ${_weather?.windSpeed} m/s',
                              style: const TextStyle(
                                fontSize: 18,
                                color: Colors.white70,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              'Humedad: ${_weather?.humidity}%',
                              style: const TextStyle(
                                fontSize: 18,
                                color: Colors.white70,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              'Nubosidad: ${_weather?.cloudCoverage}%',
                              style: const TextStyle(
                                fontSize: 18,
                                color: Colors.white70,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              'ID del clima: ${_weather?.weatherId}',
                              style: const TextStyle(
                                fontSize: 18,
                                color: Colors.white70,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(height: 20),
                            Text(
                              evaluarTurbulencia(
                                _weather!.windSpeed,
                                _weather!.windGust,
                                _weather!.cloudCoverage,
                                _weather!.weatherId,
                              ),
                              style: const TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
  else if (_weather == null && _errorMessage == null)
    const CircularProgressIndicator(color: Colors.white),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
