abstract class AuthService {
  Future signIn(String email, password);

  Future createUser(String email, password);

  Future signOut();

  Stream<bool> authStateChanged();
}
