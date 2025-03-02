import 'package:flutter/material.dart';
import 'package:mcs_app/assets/scripts/prefs.dart';
import 'package:mcs_app/widgets/textFormField_widget.dart';

class SelectedFutureWidget extends StatelessWidget {
  final TextEditingController controller = TextEditingController();
  final String label;
  final IconData icon;
  final IconData iconSufix;
  final EdgeInsetsGeometry padding;
  final String labelSearch;
  final Service service;
  final Function(String) onChange;
  SelectedFutureWidget({
    super.key,
    required this.label,
    required this.icon,
    this.iconSufix = Icons.arrow_drop_down,
    this.padding = const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
    this.labelSearch = 'Buscar',
    required this.service,
    required this.onChange,
  });

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
        GestureDetector(
          child: Container(
            color: Colors.transparent,
            width: double.infinity,
            height: 55,
          ),
          onTap: () {
            showDialog(
              context: context,
              builder: (contextD) {
                return _SelectedBuild(
                  service: service,
                  controller: controller,
                  label: labelSearch,
                  onChange: onChange,
                );
              },
            );
          },
        ),
      ],
    );
  }
}

class _SelectedBuild extends StatefulWidget {
  final TextEditingController controller;
  final Service service;
  final String label;
  final Function(String) onChange;

  const _SelectedBuild(
      {super.key,
      required this.service,
      required this.controller,
      required this.label,
      required this.onChange});

  @override
  State<_SelectedBuild> createState() => _SelectedBuildState();
}

class _SelectedBuildState extends State<_SelectedBuild> {
  String search = '';

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: TextFormFieldWidget(
        controller: widget.controller,
        icon: Icons.search,
        label: widget.label,
        onChanged: (value) {
          search = value;
          setState(() {});
        },
      ),
      content: SizedBox(
        width: 300,
        child: FutureBuilder(
          future: widget.service.getSearch(
            token: Prefs.token,
            search: search,
            limit: 10,
            page: 1,
          ),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final data = snapshot.data;
              return ListView.separated(
                itemCount: data!.data.length,
                separatorBuilder: (context, index) => const Divider(),
                itemBuilder: (context, index) => ListTile(
                  title: Text(data.data[index].name),
                  onTap: () => widget.onChange(data.data[index].id),
                ),
              );
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }
}
