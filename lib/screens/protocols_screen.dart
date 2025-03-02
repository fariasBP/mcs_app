import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mcs_app/bloc/protocols_bloc/protocols_bloc.dart';
import 'package:mcs_app/models/protocol_model.dart';
import 'package:mcs_app/models/response_model.dart';
import 'package:mcs_app/services/protocols_service.dart';
import 'package:mcs_app/widgets/button_widget.dart';
import 'package:mcs_app/widgets/header_widget.dart';
import 'package:mcs_app/widgets/msgDialog_widget.dart';
import 'package:mcs_app/widgets/searchDsb_widget.dart';
import 'package:mcs_app/widgets/textFormField_widget.dart';
import 'package:mcs_app/widgets/tile_widget.dart';

class ProtocolsScreen extends StatelessWidget {
  ProtocolsScreen({super.key});

  final TextEditingController _acronymController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProtocolsBloc, ProtocolsState>(
      builder: (context, state) => Container(
        color: Colors.grey[100],
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Cabecera
              HeaderWidget(
                title: 'Protocolos',
                actions: [
                  ButtonWidget(
                    label: 'Nuevo Protocolo',
                    style: ButtonWidget.NORMAL,
                    icon: Icons.add,
                    onPressed: () => _newProtocolDialog(context),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              // Búsqueda y filtros
              SearchDsbWidget(
                hint: 'Buscar Protocolo...',
                onChanged: (query) =>
                    BlocProvider.of<ProtocolsBloc>(context).add(
                  SearchProtocolsEvent(query: query),
                ),
              ),
              const SizedBox(height: 20),
              // Lista de protocolos
              Expanded(
                child: Card(
                  child: _buildProtocols(
                    token: 'asdfa',
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

  Future<dynamic> _newProtocolDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          scrollable: true,
          title: const Text('Crear Protocolo'),
          content: SizedBox(
            width: 300,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormFieldWidget(
                  controller: _acronymController,
                  label: 'Acrónimo del Protocolo',
                  icon: Icons.local_parking,
                ),
                const SizedBox(height: 20),
                TextFormFieldWidget(
                  controller: _nameController,
                  label: 'Componentes del Protocolo',
                  icon: Icons.format_size,
                ),
                const SizedBox(height: 20),
                TextFormFieldWidget(
                  controller: _descriptionController,
                  label: 'Descripción del Protocolo',
                  icon: Icons.description,
                  textArea: true,
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
              onPressed: () => _handleNewProtocol(context, token: ''),
              style: ButtonWidget.SUCCESS,
              label: 'Crear Marca',
            ),
          ],
        );
      },
    );
  }

  void _handleNewProtocol(BuildContext context, {required String token}) {
    BlocProvider.of<ProtocolsBloc>(context).add(StartLoadingCreateProtocol());
    ProtocolsService.create(
      token: token,
      name: _nameController.text,
      description: _descriptionController.text,
      acronym: _acronymController.text,
    ).then((msg) {
      BlocProvider.of<ProtocolsBloc>(context).add(EndLoadingCreateProtocol());
      BlocProvider.of<ProtocolsBloc>(context)
          .add(SearchProtocolsEvent(query: ''));
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
      BlocProvider.of<ProtocolsBloc>(context).add(
        EndLoadingCreateProtocol(),
      );
    });
  }

  Widget _buildProtocols({
    required String token,
    required search,
    required int page,
    required Function()? onEdit,
    required Function()? onDelete,
  }) {
    return FutureBuilder(
      future: ProtocolsService.getProtocols(
        search: search,
        token: 'asdfa',
        limit: 15,
        page: 1,
      ),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final data = snapshot.data as DataListModel<ProtocolModel>;
          return ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: data.data.length,
            separatorBuilder: (context, index) => const Divider(),
            itemBuilder: (context, index) {
              return TileWidget(
                index: index,
                title: 'Protocolo ${data.data[index].acronym}',
                leading: CircleAvatar(
                  backgroundColor:
                      Theme.of(context).primaryColor.withOpacity(0.1),
                  child: Text(
                    data.data[index].acronym,
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                subtitles: [
                  Text(data.data[index].name),
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
