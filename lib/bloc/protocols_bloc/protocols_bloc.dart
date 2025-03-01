import 'package:flutter_bloc/flutter_bloc.dart';

part 'protocols_state.dart';
part 'protocols_event.dart';

class ProtocolsBloc extends Bloc<ProtocolsEvent, ProtocolsState> {
  ProtocolsBloc()
      : super(ProtocolsState(search: '', isLoadingCreate: false, page: 1)) {
    on<SearchProtocolsEvent>((event, emit) {
      emit(ProtocolsState(
          search: event.query,
          isLoadingCreate: state.isLoadingCreate,
          page: state.page));
    });
    on<StartLoadingCreateProtocol>(
      (event, emit) => emit(ProtocolsState(
          isLoadingCreate: true, search: state.search, page: state.page)),
    );
    on<EndLoadingCreateProtocol>(
      (event, emit) => emit(ProtocolsState(
          isLoadingCreate: false, search: state.search, page: state.page)),
    );
  }
}
