import 'package:bloc/bloc.dart';

part 'auth_state.dart';
part 'auth_event.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc()
      : super(AuthState(isLoading: false, login: true, rememberMe: false)) {
    on<StartLoadingAuthEvent>((event, emit) => emit(AuthState(
        isLoading: true, login: state.login, rememberMe: state.rememberMe)));
    on<EndLoadingAuthEvent>((event, emit) => emit(AuthState(
        isLoading: false, login: state.login, rememberMe: state.rememberMe)));

    on<GoToLoginEvent>((event, emit) => emit(AuthState(
        isLoading: state.isLoading,
        login: true,
        rememberMe: state.rememberMe)));

    on<GoToSignupEvent>((event, emit) => emit(AuthState(
        isLoading: state.isLoading,
        login: false,
        rememberMe: state.rememberMe)));

    on<ToggleRememberAuthEvent>((event, emit) => emit(AuthState(
        isLoading: state.isLoading,
        login: state.login,
        rememberMe: event.value)));
  }
}
