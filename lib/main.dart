import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:zoom_my_life_app/authentication/firebase_auth_gate.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const ZoomMyLifeApp());
}

class ZoomMyLifeApp extends StatelessWidget {
  const ZoomMyLifeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: FirebaseAuthGate(),
    );
  }
}
