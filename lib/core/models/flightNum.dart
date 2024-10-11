class FlightNum {
  final Aircraft aircraft;
  final Airline airline;
  final Airline arrival;
  final Airline departure;
  final Flight flight;
  final Geography geography;
  final Speed speed;
  final String status;
  final System system;

  FlightNum({
    required this.aircraft,
    required this.airline,
    required this.arrival,
    required this.departure,
    required this.flight,
    required this.geography,
    required this.speed,
    required this.status,
    required this.system,
  });

  factory FlightNum.fromJson(Map<String, dynamic> json) {
    return FlightNum(
      aircraft: Aircraft.fromJson(json['aircraft']),
      airline: Airline.fromJson(json['airline']),
      arrival: Airline.fromJson(json['arrival']),
      departure: Airline.fromJson(json['departure']),
      flight: Flight.fromJson(json['flight']),
      geography: Geography.fromJson(json['geography']),
      speed: Speed.fromJson(json['speed']),
      status: json['status'],
      system: System.fromJson(json['system']),
    );
  }

  @override
  String toString() {
    return 'Vuelo: ${flight.number} (${airline.iataCode})\n'
           'Origen: ${departure.icaoCode}\n'
           'Destino: ${arrival.icaoCode}\n'
           'Estado: $status\n'
           'Altitud: ${geography.altitude} m\n'
           'Latitud: ${geography.latitude}\n'
           'Longitud: ${geography.longitude}\n'
           'Velocidad Horizontal: ${speed.horizontal} km/h\n';
  }
}

class Aircraft {
  final String iataCode;
  final String icao24;
  final String icaoCode;
  final String regNumber;

  Aircraft({
    required this.iataCode,
    required this.icao24,
    required this.icaoCode,
    required this.regNumber,
  });

  factory Aircraft.fromJson(Map<String, dynamic> json) {
    return Aircraft(
      iataCode: json['iataCode'] ?? 'N/A',
      icao24: json['icao24'] ?? 'N/A',
      icaoCode: json['icaoCode'] ?? 'N/A',
      regNumber: json['regNumber'] ?? 'N/A',
    );
  }

  @override
  String toString() {
    return 'Aircraft: $regNumber ($icaoCode)';
  }
}

class Airline {
  final String iataCode;
  final String icaoCode;

  Airline({
    required this.iataCode,
    required this.icaoCode,
  });

  factory Airline.fromJson(Map<String, dynamic> json) {
    return Airline(
      iataCode: json['iataCode'] ?? 'N/A',
      icaoCode: json['icaoCode'] ?? 'N/A',
    );
  }

  @override
  String toString() {
    return 'Aerolínea: $iataCode';
  }
}

class Flight {
  final String iataNumber;
  final String icaoNumber;
  final String number;

  Flight({
    required this.iataNumber,
    required this.icaoNumber,
    required this.number,
  });

  factory Flight.fromJson(Map<String, dynamic> json) {
    return Flight(
      iataNumber: json['iataNumber'] ?? 'N/A',
      icaoNumber: json['icaoNumber'] ?? 'N/A',
      number: json['number'] ?? 'N/A',
    );
  }

  @override
  String toString() {
    return 'Vuelo: $number';
  }
}

class Geography {
  final double altitude;
  final int direction;
  final double latitude;
  final double longitude;

  Geography({
    required this.altitude,
    required this.direction,
    required this.latitude,
    required this.longitude,
  });

  factory Geography.fromJson(Map<String, dynamic> json) {
    return Geography(
      altitude: json['altitude']?.toDouble() ?? 0.0,
      direction: json['direction'] ?? 0,
      latitude: json['latitude']?.toDouble() ?? 0.0,
      longitude: json['longitude']?.toDouble() ?? 0.0,
    );
  }

  @override
  String toString() {
    return 'Geografía: Altitud $altitude m, Latitud $latitude, Longitud $longitude';
  }
}

class Speed {
  final double horizontal;
  final int isGround;
  final int vspeed;

  Speed({
    required this.horizontal,
    required this.isGround,
    required this.vspeed,
  });

  factory Speed.fromJson(Map<String, dynamic> json) {
    return Speed(
      horizontal: json['horizontal']?.toDouble() ?? 0.0,
      isGround: json['isGround'] ?? 0,
      vspeed: json['vspeed'] ?? 0,
    );
  }

  @override
  String toString() {
    return 'Velocidad: Horizontal $horizontal km/h, Vertical $vspeed m/s';
  }
}

class System {
  final dynamic squawk; // Puede ser String o int, así que mantén dynamic
  final int updated;

  System({
    required this.squawk,
    required this.updated,
  });

  factory System.fromJson(Map<String, dynamic> json) {
    return System(
      squawk: json['squawk'],
      updated: json['updated'] ?? 0,
    );
  }

  @override
  String toString() {
    return 'Sistema: Squawk $squawk, Actualizado: $updated';
  }
}
