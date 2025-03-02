import 'package:flutter_bloc/flutter_bloc.dart';

part 'machines_state.dart';
part 'machines_event.dart';

class MachinesBloc extends Bloc<MachinesEvent, MachinesState> {
  MachinesBloc()
      : super(MachinesState(
            search: '',
            isLoadingCreate: false,
            page: 1,
            idCompany: '',
            idType: '',
            idBrand: '',
            searchCompany: '')) {
    on<SearchMachinesEvent>((event, emit) {
      emit(MachinesState(
          search: event.query,
          isLoadingCreate: state.isLoadingCreate,
          page: state.page,
          idCompany: state.idCompany,
          idType: state.idType,
          idBrand: state.idBrand,
          searchCompany: state.searchCompany));
    });
    on<StartLoadingCreateMachineEvent>(
      (event, emit) => emit(MachinesState(
          isLoadingCreate: true,
          search: state.search,
          page: state.page,
          idCompany: state.idCompany,
          idType: state.idType,
          idBrand: state.idBrand,
          searchCompany: state.searchCompany)),
    );
    on<EndLoadingCreateMachineEvent>(
      (event, emit) => emit(MachinesState(
          isLoadingCreate: false,
          search: state.search,
          page: state.page,
          idCompany: state.idCompany,
          idType: state.idType,
          idBrand: state.idBrand,
          searchCompany: state.searchCompany)),
    );
    on<SetIdCompanyEvent>(
      (event, emit) => emit(MachinesState(
          isLoadingCreate: state.isLoadingCreate,
          search: state.search,
          page: state.page,
          idCompany: event.idCompany,
          idType: state.idType,
          idBrand: state.idBrand,
          searchCompany: state.searchCompany)),
    );
    on<SetIdTypeEvent>(
      (event, emit) => emit(MachinesState(
          isLoadingCreate: state.isLoadingCreate,
          search: state.search,
          page: state.page,
          idCompany: state.idCompany,
          idType: event.idType,
          idBrand: state.idBrand,
          searchCompany: state.searchCompany)),
    );
    on<SetIdBrandEvent>(
      (event, emit) => emit(MachinesState(
          isLoadingCreate: state.isLoadingCreate,
          search: state.search,
          page: state.page,
          idCompany: state.idCompany,
          idType: state.idType,
          idBrand: event.idBrand,
          searchCompany: state.searchCompany)),
    );
    on<SearchCompanyEvent>((event, emit) {
      // print(event.searchCompany);
      emit(MachinesState(
          isLoadingCreate: state.isLoadingCreate,
          search: state.search,
          page: state.page,
          idCompany: state.idCompany,
          idType: state.idType,
          idBrand: state.idBrand,
          searchCompany: event.searchCompany));
    });
  }
}
