part of 'companies_bloc.dart';

abstract class CompaniesEvent {}

class SearchCompaniesEvent extends CompaniesEvent {
  final String query;
  SearchCompaniesEvent({required this.query});
}

class StartLoadingCreateCompany extends CompaniesEvent {}

class EndLoadingCreateCompany extends CompaniesEvent {}
