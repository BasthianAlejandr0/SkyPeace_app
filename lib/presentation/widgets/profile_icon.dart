import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../pages/profile_page.dart';
import '../providers/obtener_usuario.dart';


class ProfileIcon extends StatelessWidget {
  const ProfileIcon({
    super.key,
  });

 @override
  Widget build(BuildContext context) {
    return IconButton(        
      onPressed: () {
        Navigator.push(context,
          MaterialPageRoute(
            builder: (_) => ChangeNotifierProvider(
              create: (_) => UserProvider(),
              child: const ProfilePage(),
            ),
          ),
        );
      },
    
      icon: const Icon(
        Icons.person,
        size: 30,
        color: Color.fromARGB(255, 255, 255, 255),
      ),
    );
  }
}