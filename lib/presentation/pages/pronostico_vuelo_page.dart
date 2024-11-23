import 'package:app_skypeace_flight/presentation/components/buttoms/Mindfulness_buttom.dart';
import 'package:flutter/material.dart';
import 'package:app_skypeace_flight/presentation/widgets/info_card_pronostico2.dart';
import '../widgets/info_card_pronostico.dart';
import '../widgets/list_menu.dart';

class PronosticoVueloPage extends StatefulWidget {
  const PronosticoVueloPage({super.key});

  @override
  State<PronosticoVueloPage> createState() => _PronosticoVueloPage();
}

class _PronosticoVueloPage extends State<PronosticoVueloPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomLeft,
            end: Alignment.bottomRight,
            colors: [
              Color.fromARGB(255, 14, 117, 201),
              Color.fromARGB(255, 109, 194, 239),
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Mi Vuelo",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 28,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFF1A92F4),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      padding: const EdgeInsets.all(5),
                      child: IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.notifications,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(width: 20),
                    Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFF1A92F4),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      padding: const EdgeInsets.all(5),
                      child: const ListMenu(),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.9,
                          height: MediaQuery.of(context).size.height * 0.28,
                          child: const InfoPronostico(),
                        ),
                        const SizedBox(height: 10),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.9,
                          height: MediaQuery.of(context).size.height * 0.40,
                          child: const FlightInfoCarousel(),
                        ),
                        const SizedBox(height: 10),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, 'Clima');
                },
                icon: const Icon(Icons.cloud, color: Colors.blue),
                tooltip: "Clima",
              ),
              IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, 'Info');
                },
                icon: const Icon(Icons.info, color: Colors.blue),
                tooltip: "Información",
              ),
              IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, 'Otro');
                },
                icon: const Icon(Icons.more_horiz, color: Colors.blue),
                tooltip: "Otro",
              ),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: const Buttom_modal(),
    );
  }
}

// ignore: camel_case_types
class Buttom_modal extends StatelessWidget {
  const Buttom_modal({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const MindfulnessBreathingPage(),
              ),
            );
          },
      child: const Icon(Icons.cast_for_education_rounded, color: Colors.white),
      backgroundColor: const Color.fromARGB(255, 71, 175, 255),
    );
  }
}
