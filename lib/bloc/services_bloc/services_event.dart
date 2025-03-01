part of 'services_bloc.dart';

abstract class ServicesEvent {}

class StartLoadingCreateServicesEvent extends ServicesEvent {}

class EndLoadingCreateServicesEvent extends ServicesEvent {}

class SearchServicesEvent extends ServicesEvent {
  final String query;
  SearchServicesEvent({required this.query});
}

class SetIdMachineServicesEvent extends ServicesEvent {
  final String idMachine;
  SetIdMachineServicesEvent({required this.idMachine});
}
