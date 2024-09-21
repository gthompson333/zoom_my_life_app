import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zoom_my_life_app/features/login_register/service/auth_gate.dart';
import 'app_bloc_observer.dart';
import 'features/login_register/bloc/auth_bloc.dart';
import 'features/login_register/service/firebase_auth_service.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  Bloc.observer = AppBlocObserver();
  runApp(const ZoomMyLifeApp());
}

class ZoomMyLifeApp extends StatelessWidget {
  const ZoomMyLifeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BlocProvider(
        create: (context) => AuthBloc(FirebaseAuthService()),
        child: const AuthGate(),
      ),
    );
  }
}
