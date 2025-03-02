import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mcs_app/bloc/navDsb_bloc/navDsb_bloc.dart';
import 'package:mcs_app/bloc/repairs_bloc/repairs_bloc.dart';
import 'package:mcs_app/screens/repairs/overviewAndNewRepair_build.dart';
import 'package:mcs_app/screens/repairs/repair_detail.dart';
import 'package:mcs_app/widgets/header_widget.dart';
import 'package:mcs_app/widgets/textFormField_widget.dart';
import 'package:mcs_app/widgets/title_widget.dart';

class RepairsScreen extends StatelessWidget {
  const RepairsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RepairsBloc, RepairsState>(
      builder: (contextB, state) => Column(
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
                          _buildSearchSection(contextB),
                          const SizedBox(height: 16),
                          _buildResultsSection(),
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

  Widget _buildSearchSection(BuildContext context) {
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
              onChanged: (value) => BlocProvider.of<RepairsBloc>(context)
                  .add(SearchRepairsEvent(query: value)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildResultsSection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const TitleWidget(title: 'Resultados'),
            const SizedBox(height: 8),
            // FutureBuilder(future: Services, builder: builder),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 8,
              itemBuilder: (context, index) {
                return _buildServiceCard(
                  'Maquina ${index == 1 ? 'Overlock' : 'Recta'} - Servicio #${124 + index}',
                  'Esteban Adolfo',
                  '2025-10-18',
                  index == 1 ? 'Entregado' : 'En Proceso',
                  onTap: () {
                    BlocProvider.of<NavDsbBloc>(context).add(
                      OpenDetailsNavDsb(
                        title:
                            'Maquina ${index == 1 ? 'Overlock' : 'Recta'} - Servicio #${124 + index}',
                        child: RepairDetail(),
                      ),
                    );
                  },
                );
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

  Widget _buildServiceCard(
    String title,
    String client,
    String date,
    String status, {
    required VoidCallback onTap,
  }) {
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
            Text('Recepción: $date', style: const TextStyle(fontSize: 13)),
          ],
        ),
        trailing: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          decoration: BoxDecoration(
            color: status == 'Entregado'
                ? Colors.green[50]
                : status == 'Cancelado'
                    ? Colors.red[50]
                    : Colors.orange[50],
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            status,
            style: TextStyle(
              color: status == 'Entregado'
                  ? Colors.green
                  : status == 'Cancelado'
                      ? Colors.red
                      : Colors.orange,
            ),
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
