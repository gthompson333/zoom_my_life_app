import 'package:zoom_my_life_app/shared/exports.dart';
import 'package:zoom_my_life_app/features/login_register/ui/register_screen.dart';
import 'login_screen.dart';

class LoginOrRegister extends StatefulWidget {
  const LoginOrRegister({super.key});

  @override
  State<LoginOrRegister> createState() => _LoginOrRegisterState();
}

class _LoginOrRegisterState extends State<LoginOrRegister> {
  bool _showLoginPage = true;

  void _togglePages() {
    setState(() {
      _showLoginPage = !_showLoginPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_showLoginPage) {
      return LoginScreen(
        onTap: _togglePages,
      );
    } else {
      return RegisterScreen(
        onTap: _togglePages,
      );
    }
  }
}
