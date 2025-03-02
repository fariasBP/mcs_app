import 'package:flutter/material.dart';
import 'package:mcs_app/models/response_model.dart';
import 'package:mcs_app/widgets/textFormField_widget.dart';

class SelectFutureCommonWidget extends StatelessWidget {
  final String label;
  final TextEditingController labelController;
  final String search;
  final Function(String value) onSearchChange;
  final Function(String value) onChange;
  final Future<DataListModel<CommonModel>> future;
  const SelectFutureCommonWidget(
      {super.key,
      required this.label,
      required this.labelController,
      required this.onChange,
      required this.search,
      required this.onSearchChange,
      required this.future});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormFieldWidget(
          icon: Icons.search,
          label: label,
          onChanged: onSearchChange,
        ),
        const SizedBox(height: 10),
        Container(
          constraints: const BoxConstraints(maxHeight: 300),
          child: FutureBuilder(
              future: future,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final data = snapshot.data;
                  return ListView.separated(
                    itemCount: data!.data.length,
                    separatorBuilder: (context, index) => const Divider(),
                    itemBuilder: (context, index) => ListTile(
                      title: Text(data.data[index].name),
                      onTap: () {
                        labelController.text = data.data[index].name;
                        onChange(data.data[index].id);
                        Navigator.of(context).pop();
                      },
                    ),
                  );
                } else if (snapshot.hasError) {
                  return Text(snapshot.error.toString());
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              }),
        ),
      ],
    );
  }
}
