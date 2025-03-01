part of 'auth_bloc.dart';

abstract class AuthEvent {}

class StartLoadingAuthEvent extends AuthEvent {}

class EndLoadingAuthEvent extends AuthEvent {}

class GoToLoginEvent extends AuthEvent {}

class GoToSignupEvent extends AuthEvent {}

class ToggleRememberAuthEvent extends AuthEvent {
  final bool value;

  ToggleRememberAuthEvent({required this.value});
}
