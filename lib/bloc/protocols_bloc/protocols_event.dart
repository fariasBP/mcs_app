part of 'protocols_bloc.dart';

abstract class ProtocolsEvent {}

class SearchProtocolsEvent extends ProtocolsEvent {
  final String query;
  SearchProtocolsEvent({required this.query});
}

class StartLoadingCreateProtocol extends ProtocolsEvent {}

class EndLoadingCreateProtocol extends ProtocolsEvent {}
