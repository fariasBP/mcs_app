import 'package:flutter_bloc/flutter_bloc.dart';

part 'services_state.dart';
part 'services_event.dart';

class ServicesBloc extends Bloc<ServicesEvent, ServicesState> {
  ServicesBloc()
      : super(ServicesState(
            isLoadingCreate: false, page: 1, search: '', idMachine: '')) {
    on<StartLoadingCreateServicesEvent>(
      (event, emit) => emit(ServicesState(
          isLoadingCreate: true,
          page: state.page,
          search: state.search,
          idMachine: state.idMachine)),
    );
    on<EndLoadingCreateServicesEvent>(
      (event, emit) => emit(ServicesState(
          isLoadingCreate: false,
          page: state.page,
          search: state.search,
          idMachine: state.idMachine)),
    );
    on<SearchServicesEvent>(
      (event, emit) => emit(ServicesState(
          isLoadingCreate: state.isLoadingCreate,
          page: state.page,
          search: event.query,
          idMachine: state.idMachine)),
    );
    on<SetIdMachineServicesEvent>(
      (event, emit) => emit(ServicesState(
          isLoadingCreate: state.isLoadingCreate,
          page: state.page,
          search: state.search,
          idMachine: event.idMachine)),
    );
  }
}
