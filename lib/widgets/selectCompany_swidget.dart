import 'package:flutter/material.dart';
import 'package:mcs_app/services/companies_service.dart';
import 'package:mcs_app/widgets/textFormField_widget.dart';

class SelectCompanySwidget extends StatefulWidget {
  final TextEditingController labelCompanyController;
  final Function(String value) onChange;
  const SelectCompanySwidget(
      {super.key,
      required this.labelCompanyController,
      required this.onChange});

  @override
  State<SelectCompanySwidget> createState() => _SelectCompanySwidgetState();
}

class _SelectCompanySwidgetState extends State<SelectCompanySwidget> {
  String search = '';

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormFieldWidget(
          icon: Icons.search,
          label: 'Buscar Taller',
          onChanged: (value) {
            search = value;
            setState(() {});
          },
        ),
        const SizedBox(height: 10),
        Container(
          constraints: const BoxConstraints(maxHeight: 300),
          child: FutureBuilder(
              future: CompaniesService.getCompaniesCommon(
                  token: '', search: search, limit: 5, page: 1),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final data = snapshot.data;
                  return ListView.separated(
                    itemCount: data!.data.length,
                    separatorBuilder: (context, index) => const Divider(),
                    itemBuilder: (context, index) => ListTile(
                      title: Text(data.data[index].name),
                      onTap: () {
                        widget.labelCompanyController.text =
                            data.data[index].name;
                        widget.onChange(data.data[index].id);
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
