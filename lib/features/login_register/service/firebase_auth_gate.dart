import 'package:zoom_my_life_app/shared/exports.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../documents/ui/documents_list_screen.dart';
import '../ui/login_or_register.dart';

// Listens to the Firebase auth service for any changes to the user
// auth state.
// If the state changes, the appropriate screen widget is returned.
// LoginOrRegister if the auth state is unauthorized.
// DocumentsListScreen if the auth state is authorized.
class FirebaseAuthGate extends StatelessWidget {
  const FirebaseAuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          // User is logged in.
          if (snapshot.hasData) {
            return const DocumentsListScreen();
          }
          // User is not logged in.
          else {
            return const LoginOrRegister();
          }
        },
      ),
    );
  }
}
