import 'package:zoom_my_life_app/shared/exports.dart';
import 'package:equatable/equatable.dart';

part 'auth_event.dart';

part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthService _authService;

  AuthBloc(this._authService) : super(IsNotAuthenticatedAuthState()) {
    _authService.authStateChanged().listen((isAuthenticated) {
      add(AuthStatusChangedAuthEvent(isAuthenticated));
    });

    on<LoggedInAuthEvent>((event, emit) async {
      emit(AuthenticationInProgressAuthState());
      try {
        await _authService.signIn(event.email, event.password);
        emit(IsAuthenticatedAuthState());
      } catch (e) {
        emit(IsNotAuthenticatedAuthState());
      }
    });

    on<UserCreatedAuthEvent>((event, emit) async {
      emit(AuthenticationInProgressAuthState());
      try {
        await _authService.createUser(event.email, event.password);
        emit(IsAuthenticatedAuthState());
      } catch (e) {
        emit(IsNotAuthenticatedAuthState());
      }
    });

    on<LoggedOutAuthEvent>((event, emit) async {
      await _authService.signOut();
      emit(IsNotAuthenticatedAuthState());
    });

    on<AuthStatusChangedAuthEvent>((event, emit) async {
      if (event.isAuthenticated) {
        emit(IsAuthenticatedAuthState());
      } else {
        emit(IsNotAuthenticatedAuthState());
      }
    });
  }
}
