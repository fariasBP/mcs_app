part of 'machines_bloc.dart';

abstract class MachinesEvent {}

class SearchMachinesEvent extends MachinesEvent {
  final String query;
  SearchMachinesEvent({required this.query});
}

class StartLoadingCreateMachineEvent extends MachinesEvent {}

class EndLoadingCreateMachineEvent extends MachinesEvent {}

class SetIdCompanyEvent extends MachinesEvent {
  final String idCompany;
  SetIdCompanyEvent({required this.idCompany});
}

class SetIdTypeEvent extends MachinesEvent {
  final String idType;
  SetIdTypeEvent({required this.idType});
}

class SetIdBrandEvent extends MachinesEvent {
  final String idBrand;
  SetIdBrandEvent({required this.idBrand});
}

class SearchCompanyEvent extends MachinesEvent {
  final String searchCompany;
  SearchCompanyEvent({required this.searchCompany});
}
