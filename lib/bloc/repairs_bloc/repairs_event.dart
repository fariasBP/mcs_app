part of 'repairs_bloc.dart';

abstract class RepairsEvent {}

class StartLoadingCreateRepairsEvent extends RepairsEvent {}

class EndLoadingCreateRepairsEvent extends RepairsEvent {}

class SearchRepairsEvent extends RepairsEvent {
  final String query;
  SearchRepairsEvent({required this.query});
}

class SetIdMachineRepairsEvent extends RepairsEvent {
  final String idMachine;
  SetIdMachineRepairsEvent({required this.idMachine});
}
