part of 'repairs_bloc.dart';

class RepairsState {
  final bool isLoadingCreate;
  final int page;
  final String search;
  final String idMachine;
  RepairsState(
      {required this.isLoadingCreate,
      required this.page,
      required this.search,
      required this.idMachine});
}
