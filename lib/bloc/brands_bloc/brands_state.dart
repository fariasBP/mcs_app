part of 'brands_bloc.dart';

class BrandsState {
  final String search;
  final bool isLoadingCreate;
  final int page;
  BrandsState({
    required this.search,
    required this.isLoadingCreate,
    required this.page,
  });
}
