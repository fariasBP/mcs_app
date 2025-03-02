import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mcs_app/bloc/types_bloc/types_bloc.dart';
import 'package:mcs_app/models/response_model.dart';
import 'package:mcs_app/models/type_model.dart';
import 'package:mcs_app/services/types_service.dart';
import 'package:mcs_app/widgets/button_widget.dart';
import 'package:mcs_app/widgets/header_widget.dart';
import 'package:mcs_app/widgets/msgDialog_widget.dart';
import 'package:mcs_app/widgets/searchDsb_widget.dart';
import 'package:mcs_app/widgets/textFormField_widget.dart';
import 'package:mcs_app/widgets/tile_widget.dart';

class TypesScreen extends StatelessWidget {
  TypesScreen({super.key});

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TypesBloc, TypesState>(
      builder: (context, state) => Container(
        color: Colors.grey[100],
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Cabecera
              HeaderWidget(
                title: 'Tipos de Maquinas',
                actions: [
                  ButtonWidget(
                    label: 'Nuevo Tipo de Máquina',
                    style: ButtonWidget.NORMAL,
                    icon: Icons.add,
                    onPressed: () => _newTypeDialog(context),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              // Búsqueda y filtros
              SearchDsbWidget(
                hint: 'Buscar Protocolo...',
                onChanged: (query) => BlocProvider.of<TypesBloc>(context).add(
                  SearchTypesEvent(query: query),
                ),
              ),
              const SizedBox(height: 20),
              // Lista de marcas
              Expanded(
                child: Card(
                  child: _buildTypeMachines(
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

  Future<dynamic> _newTypeDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          scrollable: true,
          title: const Text('Crear Tipo de Máquina'),
          content: SizedBox(
            width: 300,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormFieldWidget(
                  controller: _nameController,
                  label: 'Nombre del tipo de máquina',
                  icon: Icons.format_size,
                ),
                const SizedBox(height: 20),
                TextFormFieldWidget(
                  controller: _descriptionController,
                  label: 'Descripción del tipo de máquina',
                  icon: Icons.description,
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
              onPressed: () => _handleNewType(context, token: 'asdf'),
              style: ButtonWidget.SUCCESS,
              label: 'Crear Tipo de Máquina',
            ),
          ],
        );
      },
    );
  }

  void _handleNewType(BuildContext context, {required String token}) {
    BlocProvider.of<TypesBloc>(context).add(StartLoadingCreateType());
    TypesService.create(
      token: token,
      name: _nameController.text,
      description: _descriptionController.text,
    ).then((msg) {
      BlocProvider.of<TypesBloc>(context).add(EndLoadingCreateType());
      BlocProvider.of<TypesBloc>(context).add(SearchTypesEvent(query: ''));
      Navigator.of(context).pop();
      showDialog(
        context: context,
        builder: (context) => const MsgDialogWidget(
          msg: 'Se creo el tipo de maquina con exito',
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
      BlocProvider.of<TypesBloc>(context).add(
        EndLoadingCreateType(),
      );
    });
  }

  Widget _buildTypeMachines({
    required String token,
    required search,
    required int page,
    required Function()? onEdit,
    required Function()? onDelete,
  }) {
    return FutureBuilder(
      future: TypesService.getTypes(
        search: search,
        token: 'asdfa',
        limit: 15,
        page: 1,
      ),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final data = snapshot.data as DataListModel<TypeModel>;
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
                    Icons.category,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
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
