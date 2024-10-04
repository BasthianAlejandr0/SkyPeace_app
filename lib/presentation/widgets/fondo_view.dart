import 'package:flutter/material.dart';

class FondoScreens extends StatelessWidget {

    final Widget child;

  const FondoScreens({
    super.key,
    required this.child
    });
  
  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromARGB(255, 255, 255, 255),//Color blaco principal de nuestras pantallas
      width: double.infinity,
      height: double.infinity,
      child:  Stack(
        children: [
          const AzulBox(),
          SafeArea(
            child: Container(
              width: double.infinity,
              margin: const EdgeInsets.only(top: 200),
              child:const Icon(
                Icons.flight,
                color: Color.fromARGB(255, 62, 55, 55),
                size: 100,
              ),
            ),
          ),
          child,
          
        ],
      ),
    );
  }
}



//Creando clase de color con gradiente Azul
class AzulBox extends StatelessWidget {
  const AzulBox({super.key});
  @override
  Widget build(BuildContext context) {
    final size= MediaQuery.of(context).size;//obtiene las dimensiones del area disponible de la pantalla

    return  Container(
      width: double.infinity,
      height: size.height * 0.4,//ocuparemos el 40% de la pantalla
      decoration: decoracionFondoAzul(),
      child:  const Stack(
        children: [
          Positioned(top: 100, right:200, child: Nubes()),
          Positioned(top: 10, left:10, child: Nubes()),
          Positioned(top: 10, right:30, child: Nubes(),),
          Positioned(bottom: 180, left:30, child: Nubes()),
          Positioned(bottom: 180, right:30, child: Nubes())
        ],
      ),
    );
  }
//Decoracion gradiente del Azul box
  BoxDecoration decoracionFondoAzul() {
    return const BoxDecoration( //Es para darle un estilo al container o cuadro
      gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Color(0xFF076DF2),
          Color.fromARGB(255, 255, 255, 255)
        ]
      ) 
    );
  }
}

//Clase para la creacion de las nubes
class Nubes extends StatelessWidget {
  const Nubes({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size; // Obtener el tamaño de la pantalla
    return Container(
      width: size.width * 0.25,  // Ancho basado en un porcentaje de la pantalla
      height: size.height * 0.1, // Alto basado en un porcentaje de la pantalla
      child: CustomPaint(
        painter: NubesPainter(),
      ),
    );
  }
}

class NubesPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    // Dibujar tres círculos para formar una nube simple
    canvas.drawCircle(Offset(size.width * 0.3, size.height * 0.5), size.width * 0.2, paint); // Círculo izquierdo
    canvas.drawCircle(Offset(size.width * 0.5, size.height * 0.4), size.width * 0.25, paint); // Círculo central
    canvas.drawCircle(Offset(size.width * 0.7, size.height * 0.5), size.width * 0.2, paint); // Círculo derecho
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}