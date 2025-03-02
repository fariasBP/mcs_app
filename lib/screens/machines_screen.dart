import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mcs_app/bloc/machines_bloc/machines_bloc.dart';
import 'package:mcs_app/models/brand_model.dart';
import 'package:mcs_app/models/company_model.dart';
import 'package:mcs_app/models/machine_model.dart';
import 'package:mcs_app/models/response_model.dart';
import 'package:mcs_app/models/type_model.dart';
import 'package:mcs_app/services/brands_service.dart';
import 'package:mcs_app/services/companies_service.dart';
import 'package:mcs_app/services/machines_service.dart';
import 'package:mcs_app/services/types_service.dart';
import 'package:mcs_app/widgets/button_widget.dart';
import 'package:mcs_app/widgets/header_widget.dart';
import 'package:mcs_app/widgets/msgDialog_widget.dart';
import 'package:mcs_app/widgets/searchDsb_widget.dart';
import 'package:mcs_app/widgets/selectedFuture_widget.dart';
import 'package:mcs_app/widgets/textFormField_widget.dart';
import 'package:mcs_app/widgets/tile_widget.dart';

class MachinesScreen extends StatelessWidget {
  final TextEditingController _labelCompanyController = TextEditingController();
  final TextEditingController _labelBrandController = TextEditingController();
  final TextEditingController _labelTypeController = TextEditingController();
  final TextEditingController _serialController = TextEditingController();
  final TextEditingController _modelController = TextEditingController();
  MachinesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MachinesBloc, MachinesState>(
      builder: (context, state) => Container(
        color: Colors.grey[100],
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Cabecera
              HeaderWidget(
                title: 'Máquinas',
                actions: [
                  ButtonWidget(
                    label: 'Nueva Máquina',
                    style: ButtonWidget.NORMAL,
                    icon: Icons.add,
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext contextB) {
                          return BlocBuilder<MachinesBloc, MachinesState>(
                            builder: (contextB, stateB) => AlertDialog(
                              scrollable: true,
                              title: const Text('Nueva Máquina'),
                              content: SizedBox(
                                width: 300,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    SelectedFutureWidget<CompanyModel>(
                                      controller: _labelCompanyController,
                                      label: 'Empresa o Taller',
                                      service: CompaniesService(),
                                      icon: Icons.apartment,
                                      builder: (contextC, value) => ListTile(
                                        title: Text(value.name),
                                        onTap: () {
                                          BlocProvider.of<MachinesBloc>(
                                                  contextB)
                                              .add(SetIdCompanyEvent(
                                                  idCompany: value.id));
                                          _labelCompanyController.text =
                                              value.name;
                                          Navigator.of(contextC).pop();
                                        },
                                      ),
                                    ),
                                    const SizedBox(height: 20),
                                    SelectedFutureWidget<TypeModel>(
                                        controller: _labelTypeController,
                                        label: 'Tipo de Máquina',
                                        service: TypesService(),
                                        icon: Icons.format_size,
                                        builder: (contextC, value) => ListTile(
                                              title: Text(value.name),
                                              onTap: () {
                                                BlocProvider.of<MachinesBloc>(
                                                        contextB)
                                                    .add(SetIdTypeEvent(
                                                        idType: value.id));
                                                _labelTypeController.text =
                                                    value.name;
                                                Navigator.of(contextC).pop();
                                              },
                                            )),
                                    const SizedBox(height: 20),
                                    SelectedFutureWidget<BrandModel>(
                                      controller: _labelBrandController,
                                      label: 'Marca de la maquina',
                                      service: BrandsService(),
                                      icon: Icons.branding_watermark,
                                      builder: (contextC, value) => ListTile(
                                        title: Text(value.name),
                                        onTap: () {
                                          BlocProvider.of<MachinesBloc>(
                                                  contextB)
                                              .add(SetIdBrandEvent(
                                                  idBrand: value.id));
                                          _labelBrandController.text =
                                              value.name;
                                          Navigator.of(contextC).pop();
                                        },
                                      ),
                                    ),
                                    const SizedBox(height: 20),
                                    TextFormFieldWidget(
                                      controller: _serialController,
                                      label: 'Serial de la Máquina',
                                      icon: Icons.fingerprint,
                                    ),
                                    const SizedBox(height: 20),
                                    TextFormFieldWidget(
                                      controller: _modelController,
                                      label: 'Modelo de la Máquina',
                                      icon: Icons.format_color_fill,
                                    ),
                                  ],
                                ),
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text('Cancelar'),
                                ),
                                ButtonWidget(
                                  isLoading: stateB.isLoadingCreate,
                                  onPressed: () {
                                    BlocProvider.of<MachinesBloc>(contextB)
                                        .add(StartLoadingCreateMachineEvent());
                                    MachinesService.create(
                                      companyId: stateB.idCompany,
                                      typeId: stateB.idType,
                                      brandId: stateB.idBrand,
                                      model: _modelController.text,
                                      serial: _serialController.text,
                                      token: '',
                                    ).then((value) {
                                      BlocProvider.of<MachinesBloc>(contextB)
                                          .add(EndLoadingCreateMachineEvent());
                                      Navigator.of(context).pop();
                                      showDialog(
                                        context: contextB,
                                        builder: (contextB) =>
                                            const MsgDialogWidget(
                                          msg: 'Se creo la maquina con exito',
                                          typeMsg: MsgDialogWidget.SUCCESS,
                                        ),
                                      );
                                    }).catchError((err) {
                                      BlocProvider.of<MachinesBloc>(contextB)
                                          .add(EndLoadingCreateMachineEvent());
                                      showDialog(
                                        context: contextB,
                                        builder: (contextB) => MsgDialogWidget(
                                          msg: err.toString(),
                                          typeMsg: MsgDialogWidget.DANGER,
                                        ),
                                      );
                                    });
                                  },
                                  style: ButtonWidget.SUCCESS,
                                  label: 'Crear Máquina',
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
              const SizedBox(height: 20),
              // Búsqueda y filtros
              SearchDsbWidget(
                hint: 'Buscar Máquina...',
                onChanged: (query) =>
                    BlocProvider.of<MachinesBloc>(context).add(
                  SearchMachinesEvent(query: query),
                ),
              ),
              const SizedBox(height: 20),
              // Lista de marcas
              Expanded(
                child: Card(
                  child: _buildMachines(
                    token: 'asdf',
                    search: state.search,
                    page: state.page,
                    onEdit: () {},
                    onDelete: () {},
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _getStateE(BuildContext context) {
    String str = '';
    BlocBuilder<MachinesBloc, MachinesState>(
      builder: (context, state) {
        str = state.searchCompany;
        return Container();
      },
    );
    return str;
  }

  void _handleNewMachine(BuildContext context,
      {required String token,
      required String companyId,
      required String typeId,
      required String brandId,
      required String model,
      required String serial}) {
    BlocProvider.of<MachinesBloc>(context)
        .add(StartLoadingCreateMachineEvent());
    MachinesService.create(
      companyId: companyId,
      typeId: typeId,
      brandId: brandId,
      model: model,
      serial: serial,
      token: token,
    ).then((msg) {
      BlocProvider.of<MachinesBloc>(context)
          .add(EndLoadingCreateMachineEvent());
      BlocProvider.of<MachinesBloc>(context)
          .add(SearchMachinesEvent(query: ''));
      Navigator.of(context).pop();
      showDialog(
        context: context,
        builder: (context) => const MsgDialogWidget(
          msg: 'Se creo la empresa-taller con exito',
          typeMsg: MsgDialogWidget.SUCCESS,
        ),
      );
    }).catchError((err) {
      showDialog(
        context: context,
        builder: (context) => MsgDialogWidget(
          msg: err.toString(),
          typeMsg: MsgDialogWidget.DANGER,
        ),
      );
      BlocProvider.of<MachinesBloc>(context).add(
        EndLoadingCreateMachineEvent(),
      );
    });
  }

  Widget _buildMachines({
    required String token,
    required search,
    required int page,
    required Function()? onEdit,
    required Function()? onDelete,
  }) {
    return FutureBuilder(
      future: MachinesService.getMachinesBasic(
          search: search, token: 'asdfa', limit: 15, page: 1),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final data = snapshot.data as DataListModel<MachineBasicModel>;
          return ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: data.data.length,
            separatorBuilder: (context, index) => const Divider(),
            itemBuilder: (context, index) {
              return TileWidget(
                index: index,
                title: data.data[index].serial,
                leading: CircleAvatar(
                  backgroundColor:
                      Theme.of(context).primaryColor.withOpacity(0.1),
                  child: Icon(
                    Icons.fax,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                subtitles: [
                  Text('Tipo de Máquina: ${data.data[index].typeName}'),
                  Text('Modelo: ${data.data[index].model}'),
                ],
                actions: [
                  IconButton(
                    icon: const Icon(Icons.edit),
                    onPressed: onEdit,
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: onDelete,
                  ),
                ],
              );
            },
          );
        } else if (snapshot.hasError) {
          print(snapshot.error);
          return const Center(
            child: Text('Sin datos'),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
