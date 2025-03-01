part of 'navDsb_bloc.dart';

abstract class NavDsbEvent {}

class ChangeNavDsb extends NavDsbEvent {
  final int index;
  ChangeNavDsb({required this.index});
}

class OpenDetailsNavDsb extends NavDsbEvent {
  final String title;
  final Widget child;
  OpenDetailsNavDsb({required this.title, required this.child});
}

class CloseDetailsNavDsb extends NavDsbEvent {}
