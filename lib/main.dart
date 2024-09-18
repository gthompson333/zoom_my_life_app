import 'package:flutter/material.dart';
import 'package:zoom_my_life_app/screens/login_screen.dart';

void main() async {
  runApp(const ZoomMyLifeApp());
}

class ZoomMyLifeApp extends StatelessWidget {
  const ZoomMyLifeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: LoginScreen(),
    );
  }
}
