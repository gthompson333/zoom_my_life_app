abstract class AuthService {
  Future signInWithEmailPassword(String email, password);
  Future signUpWithEmailPassword(String email, password);
  Future signOut();
}