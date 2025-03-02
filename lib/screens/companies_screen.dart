import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:mcs_app/bloc/companies_bloc/companies_bloc.dart';
import 'package:mcs_app/models/company_model.dart';
import 'package:mcs_app/models/response_model.dart';
import 'package:mcs_app/services/companies_service.dart';
import 'package:mcs_app/widgets/button_widget.dart';
import 'package:mcs_app/widgets/header_widget.dart';
import 'package:mcs_app/widgets/msgDialog_widget.dart';
import 'package:mcs_app/widgets/searchDsb_widget.dart';
import 'package:mcs_app/widgets/textFormField_widget.dart';
import 'package:mcs_app/widgets/tile_widget.dart';

class CompaniesScreen extends StatelessWidget {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _managerController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  CompaniesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CompaniesBloc, CompaniesState>(
      builder: (context, state) => Container(
        color: Colors.grey[100],
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Cabecera
              HeaderWidget(
                title: 'Empresas - Talleres',
                actions: [
                  ButtonWidget(
                    label: 'Nueva Empresa / Taller',
                    style: ButtonWidget.NORMAL,
                    icon: Icons.add_home_work,
                    onPressed: () => _newCompanyDialog(context),
                  )
                ],
              ),
              const SizedBox(height: 20),
              // Búsqueda y filtros
              SearchDsbWidget(
                hint: 'Buscar Compania...',
                onChanged: (query) => BlocProvider.of<CompaniesBloc>(context)
                    .add(SearchCompaniesEvent(query: query)),
              ),
              const SizedBox(height: 20),
              // Lista de empresas-talleres
              Expanded(
                child: Card(
                  child: _buildCompanies(
                    token: 'sadf',
                    search: state.search,
                    limit: 15,
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

  Future<dynamic> _newCompanyDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          scrollable: true,
          title: const Text('Crear Empresa - Taller'),
          content: SizedBox(
            width: 300,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormFieldWidget(
                  controller: _nameController,
                  label: 'Nombre de la Empresa o Taller',
                  icon: Icons.apartment,
                ),
                const SizedBox(height: 20),
                TextFormFieldWidget(
                  controller: _managerController,
                  label: 'Nombre del Encargado/a',
                  icon: Icons.person_2,
                ),
                const SizedBox(height: 20),
                TextFormFieldWidget(
                  controller: _phoneController,
                  label: 'Telefono',
                  icon: Icons.phone,
                  keyboardType: TextInputType.phone,
                ),
                const SizedBox(height: 20),
                TextFormFieldWidget(
                  controller: _locationController,
                  label: 'Direccion GoogleMaps',
                  icon: Icons.location_on,
                  keyboardType: TextInputType.streetAddress,
                ),
                const SizedBox(height: 20),
                TextFormFieldWidget(
                  controller: _descriptionController,
                  label: 'Descripción',
                  icon: Icons.description,
                  textArea: true,
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancelar'),
            ),
            BlocBuilder<CompaniesBloc, CompaniesState>(
              builder: (context, state) {
                return ButtonWidget(
                  label: 'Crear Empresa',
                  isLoading: state.isLoadingCreate,
                  style: ButtonWidget.SUCCESS,
                  onPressed: () => _handleNewCompany(context, token: 'asdf'),
                );
              },
            ),
          ],
        );
      },
    );
  }

  Widget _buildCompanies({
    required String token,
    required search,
    required int limit,
    required int page,
    required Function()? onEdit,
    required Function()? onDelete,
  }) {
    return FutureBuilder(
      future: CompaniesService.getCompanies(
          search: search, token: token, limit: limit, page: page),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final data = snapshot.data as DataListModel<CompanyModel>;
          return ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: data.data.length,
            separatorBuilder: (context, index) => const Divider(),
            itemBuilder: (context, index) {
              return TileWidget(
                index: index,
                title: data.data[index].name,
                leading: CircleAvatar(
                  backgroundColor:
                      Theme.of(context).primaryColor.withOpacity(0.1),
                  child: Icon(
                    Icons.home_work,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                subtitles: [
                  Text('Encargado: ${data.data[index].manager}'),
                  Text('Teléfono: ${data.data[index].contact}'),
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

  void _handleNewCompany(
    BuildContext context, {
    required String token,
  }) {
    BlocProvider.of<CompaniesBloc>(context).add(StartLoadingCreateCompany());
    CompaniesService.create(
            token: token,
            name: _nameController.text,
            manager: _managerController.text,
            location: _locationController.text,
            phone: _phoneController.text,
            description: _descriptionController.text)
        .then((msg) {
      BlocProvider.of<CompaniesBloc>(context).add(EndLoadingCreateCompany());
      BlocProvider.of<CompaniesBloc>(context)
          .add(SearchCompaniesEvent(query: ''));
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
      BlocProvider.of<CompaniesBloc>(context).add(
        EndLoadingCreateCompany(),
      );
    });
  }
}
