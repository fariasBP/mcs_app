part of 'machines_bloc.dart';

class MachinesState {
  final String search;
  final bool isLoadingCreate;
  final String idCompany;
  final String idType;
  final String idBrand;
  final int page;
  final String searchCompany;
  MachinesState({
    required this.search,
    required this.isLoadingCreate,
    required this.page,
    required this.idCompany,
    required this.idType,
    required this.idBrand,
    required this.searchCompany,
  });
}
