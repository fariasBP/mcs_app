part of 'protocols_bloc.dart';

class ProtocolsState {
  final String search;
  final bool isLoadingCreate;
  final int page;
  ProtocolsState({
    required this.search,
    required this.isLoadingCreate,
    required this.page,
  });
}
