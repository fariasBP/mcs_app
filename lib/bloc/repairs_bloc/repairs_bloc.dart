import 'package:flutter_bloc/flutter_bloc.dart';

part 'repairs_state.dart';
part 'repairs_event.dart';

class RepairsBloc extends Bloc<RepairsEvent, RepairsState> {
  RepairsBloc()
      : super(RepairsState(
            isLoadingCreate: false, page: 1, search: '', idMachine: '')) {
    on<StartLoadingCreateRepairsEvent>(
      (event, emit) => emit(RepairsState(
          isLoadingCreate: true,
          page: state.page,
          search: state.search,
          idMachine: state.idMachine)),
    );
    on<EndLoadingCreateRepairsEvent>(
      (event, emit) => emit(RepairsState(
          isLoadingCreate: false,
          page: state.page,
          search: state.search,
          idMachine: state.idMachine)),
    );
    on<SearchRepairsEvent>(
      (event, emit) => emit(RepairsState(
          isLoadingCreate: state.isLoadingCreate,
          page: state.page,
          search: event.query,
          idMachine: state.idMachine)),
    );
    on<SetIdMachineRepairsEvent>(
      (event, emit) => emit(RepairsState(
          isLoadingCreate: state.isLoadingCreate,
          page: state.page,
          search: state.search,
          idMachine: event.idMachine)),
    );
  }
}
