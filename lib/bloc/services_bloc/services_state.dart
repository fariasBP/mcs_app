part of 'services_bloc.dart';

class ServicesState {
  final bool isLoadingCreate;
  final int page;
  final String search;
  final String idMachine;
  ServicesState(
      {required this.isLoadingCreate,
      required this.page,
      required this.search,
      required this.idMachine});
}
