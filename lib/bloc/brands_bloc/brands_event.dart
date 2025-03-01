part of 'brands_bloc.dart';

abstract class BrandsEvent {}

class SearchBrandsEvent extends BrandsEvent {
  final String query;
  SearchBrandsEvent({required this.query});
}

class StartLoadingCreateBrand extends BrandsEvent {}

class EndLoadingCreateBrand extends BrandsEvent {}
