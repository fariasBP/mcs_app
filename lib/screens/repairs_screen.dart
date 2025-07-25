import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mcs_app/assets/scripts/prefs.dart';
import 'package:mcs_app/bloc/navDsb_bloc/navDsb_bloc.dart';
import 'package:mcs_app/bloc/repairs_bloc/repairs_bloc.dart';
import 'package:mcs_app/models/repair_model.dart';
import 'package:mcs_app/models/response_model.dart';
import 'package:mcs_app/screens/repairs/overviewAndNewRepair_build.dart';
import 'package:mcs_app/screens/repairs/repair_detail.dart';
import 'package:mcs_app/services/repairs_service.dart';
import 'package:mcs_app/widgets/button_widget.dart';
import 'package:mcs_app/widgets/header_widget.dart';
import 'package:mcs_app/widgets/textFormField_widget.dart';
import 'package:mcs_app/widgets/title_widget.dart';
import 'package:date_picker_plus/date_picker_plus.dart';
import 'package:intl/intl.dart';

class RepairsScreen extends StatelessWidget {
  const RepairsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RepairsBloc, RepairsState>(
      builder: (context, state) => Column(
        children: [
          const HeaderWidget(title: 'SERVICIOS'),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          const SizedBox(height: 16),
                          _buildSearchSection(context),
                          const SizedBox(height: 16),
                          _buildResultsSection(state),
                          const SizedBox(height: 16),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  SizedBox(
                    width: 350,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          const SizedBox(height: 16),
                          OverviewAndNewRepairBuild(),
                          const SizedBox(height: 16),
                          _buildLatestServices(),
                          const SizedBox(height: 16),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchSection(BuildContext contextC) {
    return Card(
      elevation: 0,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const TitleWidget(title: 'Buscar'),
            const SizedBox(height: 16),
            TextFormFieldWidget(
              icon: Icons.search,
              label: 'Buscar...',
              onChanged: (value) => BlocProvider.of<RepairsBloc>(contextC)
                  .add(SearchRepairsEvent(query: value)),
            ),
            const SizedBox(height: 16),
            BlocBuilder<RepairsBloc, RepairsState>(
              builder: (context, state) => ButtonWidget(
                label: 'Fecha',
                icon: Icons.date_range,
                onPressed: () {
                  showRangePickerDialog(
                    context: context,
                    minDate: DateTime(2000, 1, 1),
                    maxDate: DateTime.now(),
                  ).then((date) {
                    if (date != null) {
                      BlocProvider.of<RepairsBloc>(context).add(
                          SetIntervalDatetimeRepairsEvent(
                              startedAt: date.start.toUtc().toIso8601String(),
                              endedAt: date.end.toUtc().toIso8601String()));
                    }
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildResultsSection(RepairsState state) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const TitleWidget(title: 'Resultados'),
            const SizedBox(height: 8),
            FutureBuilder<DataListModel<RepairModel>>(
              future: RepairsService().getRepairs(
                token: Prefs.init!.getString(Prefs.token) ?? "",
                search: '',
                startedAt: state.startedAt,
                endedAt: state.endedAt,
                limit: 20,
                page: 1,
              ),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final data = snapshot.data as DataListModel<RepairModel>;
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: data.count,
                    itemBuilder: (context, index) {
                      return _buildServiceCard(
                        title: 'Servicio #${data.data[index].id}',
                        client: data.data[index].machine.companyName,
                        machine:
                            '${data.data[index].machine.typeName} - ${data.data[index].machine.serial}',
                        date: DateFormat.yMMMMd('es_ES')
                            .format(data.data[index].startedAt.toLocal()),
                        // date: data.data[index].startedAt.toLocal().toString(),
                        status: data.data[index].status,
                        onTap: () {
                          BlocProvider.of<NavDsbBloc>(context).add(
                            OpenDetailsNavDsb(
                              title: 'Servicio #${data.data[index].id}',
                              child: RepairDetail(
                                data.data[index],
                              ),
                            ),
                          );
                        },
                      );
                    },
                  );
                } else if (snapshot.hasError) {
                  return Text(snapshot.error.toString());
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              },
            ),
            Center(
              child: TextButton(
                onPressed: () {},
                child: const Text('Ver mas...'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildServiceCard({
    required String title,
    required String client,
    required String machine,
    required String date,
    required int status,
    required VoidCallback onTap,
  }) {
    int status2 = 0; // pendiente
    if (status == 2 || status == 3) {
      // en proceso
      status2 = 1;
    } else if (status == 4 || status == 5) {
      // finalizado
      status2 = 2;
    }
    return Card(
      elevation: 2,
      color: Colors.white,
      child: ListTile(
        onTap: onTap,
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: const Color(0xFF0A2472),
            borderRadius: BorderRadius.circular(1008),
          ),
          child: const Icon(
            Icons.build,
            color: Colors.white,
            size: 20,
          ),
        ),
        title: Text(title,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Cliente: $client', style: const TextStyle(fontSize: 13)),
            Text('Maquina: $machine', style: const TextStyle(fontSize: 13)),
            Text('Recepción: $date', style: const TextStyle(fontSize: 13)),
          ],
        ),
        trailing: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          decoration: BoxDecoration(
            color: status2 == 2
                ? Colors.green[50]
                : (status2 == 1 ? Colors.orange[50] : Colors.red[50]),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            status2 == 2
                ? 'Entregado'
                : (status2 == 1 ? 'En Proceso' : 'Pendiente'),
            style: TextStyle(
                color: status2 == 2
                    ? Colors.green
                    : (status2 == 1 ? Colors.orange : Colors.red)),
          ),
        ),
      ),
    );
  }

  Widget _buildLatestServices() {
    return Card(
      elevation: 0,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const TitleWidget(title: 'Servicios Recientes'),
            const SizedBox(height: 16),
            Row(
              children: [
                _buildTabButton('Pendientes', true),
                const SizedBox(width: 8),
                _buildTabButton('Entregados', false),
              ],
            ),
            const SizedBox(height: 16),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 5,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: const Color(0xFF0A2472),
                      borderRadius: BorderRadius.circular(1008),
                    ),
                    child: const Icon(
                      Icons.build,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                  title: Text('Maquina Recta - Ser#${124 + index}',
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 13)),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Cliente: Esteban Adolfo',
                          style: TextStyle(fontSize: 13)),
                      const Text('Recepción: 2025-10-18',
                          style: TextStyle(fontSize: 13)),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTabButton(String text, bool isSelected) {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        backgroundColor: isSelected ? const Color(0xFF0A2472) : Colors.white,
        foregroundColor: isSelected ? Colors.white : Colors.black,
        elevation: 0,
        side: BorderSide(
          color: isSelected ? const Color(0xFF0A2472) : Colors.grey[300]!,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: Text(text),
    );
  }
}
