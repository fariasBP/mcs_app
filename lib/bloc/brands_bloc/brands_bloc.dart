import 'package:flutter_bloc/flutter_bloc.dart';

part 'brands_state.dart';
part 'brands_event.dart';

class BrandsBloc extends Bloc<BrandsEvent, BrandsState> {
  BrandsBloc()
      : super(BrandsState(search: '', isLoadingCreate: false, page: 1)) {
    on<SearchBrandsEvent>((event, emit) {
      emit(BrandsState(
          search: event.query,
          isLoadingCreate: state.isLoadingCreate,
          page: state.page));
    });
    on<StartLoadingCreateBrand>(
      (event, emit) => emit(BrandsState(
          isLoadingCreate: true, search: state.search, page: state.page)),
    );
    on<EndLoadingCreateBrand>(
      (event, emit) => emit(BrandsState(
          isLoadingCreate: false, search: state.search, page: state.page)),
    );
  }
}
