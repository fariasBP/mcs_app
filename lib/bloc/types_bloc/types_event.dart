part of 'types_bloc.dart';

abstract class TypesEvent {}

class SearchTypesEvent extends TypesEvent {
  final String query;
  SearchTypesEvent({required this.query});
}

class StartLoadingCreateType extends TypesEvent {}

class EndLoadingCreateType extends TypesEvent {}
