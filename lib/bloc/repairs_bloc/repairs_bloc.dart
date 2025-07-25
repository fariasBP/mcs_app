import 'package:flutter_bloc/flutter_bloc.dart';

part 'repairs_state.dart';
part 'repairs_event.dart';

class RepairsBloc extends Bloc<RepairsEvent, RepairsState> {
  RepairsBloc()
      : super(RepairsState(
          isLoadingCreate: false,
          search: '',
          ascending: true,
          page: 1,
          idMachine: '',
          startedAt: '',
          endedAt: '',
        )) {
    on<StartLoadingCreateRepairsEvent>(
      (event, emit) => emit(RepairsState(
          isLoadingCreate: true,
          search: state.search,
          ascending: state.ascending,
          page: state.page,
          idMachine: state.idMachine,
          startedAt: state.startedAt,
          endedAt: state.endedAt)),
    );
    on<EndLoadingCreateRepairsEvent>(
      (event, emit) => emit(RepairsState(
          isLoadingCreate: false,
          search: state.search,
          ascending: state.ascending,
          page: state.page,
          idMachine: state.idMachine,
          startedAt: state.startedAt,
          endedAt: state.endedAt)),
    );
    on<SearchRepairsEvent>(
      (event, emit) => emit(RepairsState(
          isLoadingCreate: state.isLoadingCreate,
          search: event.query,
          ascending: state.ascending,
          page: state.page,
          idMachine: state.idMachine,
          startedAt: state.startedAt,
          endedAt: state.endedAt)),
    );
    on<SetIdMachineRepairsEvent>(
      (event, emit) => emit(RepairsState(
          isLoadingCreate: state.isLoadingCreate,
          search: state.search,
          ascending: state.ascending,
          page: state.page,
          idMachine: event.idMachine,
          startedAt: state.startedAt,
          endedAt: state.endedAt)),
    );
    on<SetIntervalDatetimeRepairsEvent>(
      (event, emit) {
        emit(RepairsState(
            isLoadingCreate: state.isLoadingCreate,
            search: state.search,
            ascending: state.ascending,
            page: state.page,
            idMachine: state.idMachine,
            startedAt: event.startedAt,
            endedAt: event.endedAt));
      },
    );
  }
}
