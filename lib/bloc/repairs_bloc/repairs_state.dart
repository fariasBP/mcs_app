part of 'repairs_bloc.dart';

class RepairsState {
  final bool isLoadingCreate;
  final String search;
  final bool ascending;
  final int page;
  final String idMachine;
  final String startedAt;
  final String endedAt;
  RepairsState(
      {required this.isLoadingCreate,
      required this.search,
      required this.ascending,
      required this.page,
      required this.idMachine,
      required this.startedAt,
      required this.endedAt});
}
