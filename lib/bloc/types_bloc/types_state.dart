part of 'types_bloc.dart';

class TypesState {
  final String search;
  final bool isLoadingCreate;
  final int page;
  TypesState({
    required this.search,
    required this.isLoadingCreate,
    required this.page,
  });
}
