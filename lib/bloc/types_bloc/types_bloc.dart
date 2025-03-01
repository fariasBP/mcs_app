import 'package:flutter_bloc/flutter_bloc.dart';

part 'types_state.dart';
part 'types_event.dart';

class TypesBloc extends Bloc<TypesEvent, TypesState> {
  TypesBloc() : super(TypesState(search: '', isLoadingCreate: false, page: 1)) {
    on<SearchTypesEvent>((event, emit) {
      emit(TypesState(
          search: event.query,
          isLoadingCreate: state.isLoadingCreate,
          page: state.page));
    });
    on<StartLoadingCreateType>(
      (event, emit) => emit(TypesState(
          isLoadingCreate: true, search: state.search, page: state.page)),
    );
    on<EndLoadingCreateType>(
      (event, emit) => emit(TypesState(
          isLoadingCreate: false, search: state.search, page: state.page)),
    );
  }
}
