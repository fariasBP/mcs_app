part of 'companies_bloc.dart';

class CompaniesState {
  final String search;
  final bool isLoadingCreate;
  final int page;
  CompaniesState({
    required this.search,
    required this.isLoadingCreate,
    required this.page,
  });
}
