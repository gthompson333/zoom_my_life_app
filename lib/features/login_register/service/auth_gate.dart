import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zoom_my_life_app/features/login_register/bloc/auth_bloc.dart';
import 'package:zoom_my_life_app/shared/exports.dart';
import '../../documents/ui/documents_list_screen.dart';
import '../ui/login_or_register.dart';

// This a wrapper widget around the login / register screens and the documents
// screen.
// This widget responds to bloc state changes from the auth bloc.
class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<AuthBloc, AuthState>(builder: (context, state) {
        switch (state) {
          case IsAuthenticatedAuthState():
            return const DocumentsListScreen();
          case AuthenticationInProgressAuthState():
            return const Center(child: CircularProgressIndicator());
          case AuthenticationFailedAuthState():
            return const Text("Login failed.");
          case IsNotAuthenticatedAuthState():
            return const LoginOrRegister();
        }
      }),
    );
  }
}