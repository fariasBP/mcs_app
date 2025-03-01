part of 'auth_bloc.dart';

class AuthState {
  final bool isLoading;
  final bool login;
  final bool rememberMe;
  AuthState({
    required this.isLoading,
    required this.login,
    required this.rememberMe,
  });
}
