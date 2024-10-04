import 'package:flutter/material.dart';

class FormFlightPage extends StatefulWidget {
  const FormFlightPage({super.key});

  @override
  State<FormFlightPage> createState() => _FormFlightPageState();
}

class _FormFlightPageState extends State<FormFlightPage> {
  final _formKey = GlobalKey<FormState>();

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
              const SizedBox(height: 50),
              const Text(
                "Buscar fecha de vuelo",
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 5),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Origen',
                  hintText: 'Ej: Santiago',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, ingresa el origen';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Destino',
                  hintText: 'Ej: Nueva York',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, ingresa el destino';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2020),
                    lastDate: DateTime(2025),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: const EdgeInsets.symmetric(
                      vertical: 15, horizontal: 20),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  'Seleccionar fecha',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
              ),
              const SizedBox(height: 100),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // Si el formulario es válido, procesa la búsqueda
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
                child: const Text(
                  'Buscar',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
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
