import 'package:zoom_my_life_app/shared/exports.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'auth_event.dart';

part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthService _authService;

  AuthBloc(this._authService) : super(IsNotAuthenticatedAuthState()) {
    on<LoginAuthEvent>((event, emit) async {
      emit(AuthenticationInProgressAuthState());
      try {
        await _authService.signIn(event.email, event.password);
        emit(IsAuthenticatedAuthState());
      } catch (e) {
        emit(IsNotAuthenticatedAuthState());
      }
    });

    on<LogoutAuthEvent>((event, emit) async {
      await _authService.signOut();
      emit(IsNotAuthenticatedAuthState());
    });
  }
}
