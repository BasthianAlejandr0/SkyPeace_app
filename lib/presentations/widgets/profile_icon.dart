import 'package:flutter/material.dart';

class ProfileIcon extends StatelessWidget {
  const ProfileIcon({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        Navigator.pushNamed(context, 'Perfil');
      },
      icon: const Icon(
        Icons.person,
        size: 30,
        color: Color.fromARGB(255, 255, 255, 255),
      ),
    );
  }
}
