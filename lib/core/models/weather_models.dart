class Weather {
  final String cityName;
  final double temperatureCelsius;
  final String mainDescription;
  final double windSpeed;
  final double windGust;
  final int cloudCoverage;
  final int humidity;
  final int weatherId;

  Weather({
    required this.cityName,
    required this.temperatureCelsius,
    required this.mainDescription,
    required this.windSpeed,
    required this.windGust,
    required this.cloudCoverage,
    required this.humidity,
    required this.weatherId,
  });

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      cityName: json['name'],
      temperatureCelsius: json['main']['temp'].toDouble(),
      mainDescription: json['weather'][0]['main'],
      windSpeed: json['wind']['speed'].toDouble(),
      windGust: json['wind']['gust'] != null ? json['wind']['gust'].toDouble() : 0.0, // Algunos registros pueden no incluir ráfagas de viento
      cloudCoverage: json['clouds']['all'], // Porcentaje de cobertura de nubes
      humidity: json['main']['humidity'], // Humedad relativa en porcentaje
      weatherId: json['weather'][0]['id'], // Código de ID del clima (para identificar condiciones como tormentas)
    );
  }
}
