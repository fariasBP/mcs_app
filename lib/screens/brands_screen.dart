import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mcs_app/bloc/brands_bloc/brands_bloc.dart';
import 'package:mcs_app/models/brand_model.dart';
import 'package:mcs_app/models/response_model.dart';
import 'package:mcs_app/services/brands_service.dart';
import 'package:mcs_app/widgets/button_widget.dart';
import 'package:mcs_app/widgets/header_widget.dart';
import 'package:mcs_app/widgets/msgDialog_widget.dart';
import 'package:mcs_app/widgets/searchDsb_widget.dart';
import 'package:mcs_app/widgets/textFormField_widget.dart';
import 'package:mcs_app/widgets/tile_widget.dart';

class BrandsScreen extends StatelessWidget {
  BrandsScreen({super.key});

  final TextEditingController _nameController = TextEditingController();

  Future<dynamic> _newBrandsDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          scrollable: true,
          title: const Text('Crear Marca'),
          content: SizedBox(
            width: 300,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormFieldWidget(
                  controller: _nameController,
                  label: 'Nombre de la Marca',
                  icon: Icons.format_size,
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
              style: ButtonWidget.SUCCESS,
              label: 'Crear Marca',
              onPressed: () => _handleNewBrand(context, token: 'asdfa'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BrandsBloc, BrandsState>(
      builder: (context, state) => Container(
        color: Colors.grey[100],
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Cabecera
              HeaderWidget(
                title: 'Marcas',
                actions: [
                  ButtonWidget(
                    label: 'Nueva Marca',
                    style: ButtonWidget.NORMAL,
                    icon: Icons.add,
                    onPressed: () => _newBrandsDialog(context),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              // Búsqueda y filtros
              SearchDsbWidget(
                hint: 'Buscar marca...',
                onChanged: (query) => BlocProvider.of<BrandsBloc>(context).add(
                  SearchBrandsEvent(query: query),
                ),
              ),
              const SizedBox(height: 20),
              // Lista de marcas
              Expanded(
                child: Card(
                  child: _buildBrands(
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

  void _handleNewBrand(BuildContext context, {required String token}) {
    BlocProvider.of<BrandsBloc>(context).add(StartLoadingCreateBrand());
    BrandsService.create(
      token: token,
      name: _nameController.text,
    ).then((msg) {
      BlocProvider.of<BrandsBloc>(context).add(EndLoadingCreateBrand());
      BlocProvider.of<BrandsBloc>(context).add(SearchBrandsEvent(query: ''));
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
      BlocProvider.of<BrandsBloc>(context).add(
        EndLoadingCreateBrand(),
      );
    });
  }

  static Widget _buildBrands({
    required String token,
    required search,
    required int page,
    required Function()? onEdit,
    required Function()? onDelete,
  }) {
    return FutureBuilder(
      future: BrandsService.getBrands(
          search: search, token: 'asdfa', limit: 15, page: 1),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final data = snapshot.data as DataListModel<BrandModel>;
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
                    Icons.branding_watermark,
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
