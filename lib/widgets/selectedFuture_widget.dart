import 'package:flutter/material.dart';
import 'package:mcs_app/assets/scripts/prefs.dart';
import 'package:mcs_app/models/response_model.dart';
import 'package:mcs_app/widgets/textFormField_widget.dart';
import 'package:wolt_modal_sheet/wolt_modal_sheet.dart';

class SelectedFutureWidget<TModel> extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final IconData icon;
  final IconData iconSufix;
  final EdgeInsetsGeometry padding;
  final String labelSearch;
  final Service<TModel> service;
  final ListTile Function(BuildContext, TModel) builder;
  const SelectedFutureWidget(
      {super.key,
      required this.controller,
      required this.label,
      required this.icon,
      this.iconSufix = Icons.arrow_drop_down,
      this.padding = const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      this.labelSearch = 'Buscar',
      required this.service,
      required this.builder});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        TextFormFieldWidget(
          controller: controller,
          icon: icon,
          label: label,
          iconSufix: iconSufix,
        ),
        InkWell(
          child: Container(
            color: Colors.transparent,
            width: double.infinity,
            height: 55,
          ),
          onTap: () {
            WoltModalSheet.show(
              context: context,
              pageListBuilder: (context) => [
                WoltModalSheetPage(
                  hasTopBarLayer: false,
                  child: _SelectedBuild<TModel>(
                    service: service,
                    controller: controller,
                    label: labelSearch,
                    builder: builder,
                    padding: padding,
                  ),
                ),
              ],
            );
          },
        ),
      ],
    );
  }
}

class _SelectedBuild<T> extends StatefulWidget {
  final TextEditingController controller;
  final Service<T> service;
  final String label;
  final ListTile Function(BuildContext, T) builder;
  final EdgeInsetsGeometry padding;

  const _SelectedBuild(
      {super.key,
      required this.service,
      required this.controller,
      required this.label,
      required this.builder,
      required this.padding});

  @override
  State<_SelectedBuild<T>> createState() => _SelectedBuildState<T>();
}

class _SelectedBuildState<T> extends State<_SelectedBuild<T>> {
  String search = '';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.padding,
      child: Column(
        children: [
          TextFormFieldWidget(
            controller: widget.controller,
            icon: Icons.search,
            label: widget.label,
            onChanged: (value) {
              search = value;
              setState(() {});
            },
          ),
          const SizedBox(height: 15),
          SingleChildScrollView(
            child: SizedBox(
              height: 300,
              child: FutureBuilder<DataListModel<T>>(
                future: widget.service.getSearch(
                  token: Prefs.token,
                  search: search,
                  limit: 10,
                  page: 1,
                ),
                builder: (context, AsyncSnapshot<DataListModel<T>> snapshot) {
                  if (snapshot.hasData) {
                    final DataListModel<T> data =
                        snapshot.data as DataListModel<T>;
                    return ListView.separated(
                      itemCount: data.data.length,
                      separatorBuilder: (context, index) => const Divider(),
                      itemBuilder: (context, index) =>
                          widget.builder(context, data.data[index]),
                    );
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
