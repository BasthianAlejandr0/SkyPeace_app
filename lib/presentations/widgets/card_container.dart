import 'package:flutter/material.dart';

class CardContainer extends StatelessWidget {
  const CardContainer({
    super.key,
    required this.child
    });
    //Para mandarlo a llamar
    final Widget child;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        decoration: decoracionCard(),
        child: child,
      ),
    );
  }

  BoxDecoration decoracionCard() =>  BoxDecoration(
    color: const Color.fromARGB(240, 66, 150, 254),
    borderRadius: BorderRadius.circular(20),
    boxShadow:  const [
      BoxShadow(
        color: Colors.black,
        blurRadius: 15,
        offset: Offset(0,8)
      )      
    ]
  );
}