import 'package:flutter_bloc/flutter_bloc.dart';

part 'companies_state.dart';
part 'companies_event.dart';

class CompaniesBloc extends Bloc<CompaniesEvent, CompaniesState> {
  CompaniesBloc()
      : super(CompaniesState(search: '', isLoadingCreate: false, page: 1)) {
    on<SearchCompaniesEvent>((event, emit) {
      emit(CompaniesState(
          search: event.query,
          isLoadingCreate: state.isLoadingCreate,
          page: state.page));
    });
    on<StartLoadingCreateCompany>(
      (event, emit) => emit(CompaniesState(
          isLoadingCreate: true, search: state.search, page: state.page)),
    );
    on<EndLoadingCreateCompany>(
      (event, emit) => emit(CompaniesState(
          isLoadingCreate: false, search: state.search, page: state.page)),
    );
  }
}
