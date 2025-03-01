import 'package:flutter/material.dart';
import 'package:mcs_app/widgets/header_widget.dart';

class OverviewSwidget extends StatelessWidget {
  const OverviewSwidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[100],
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            HeaderWidget(title: 'Vista General', actions: [
              IconButton(
                icon: Icon(Icons.notifications),
                onPressed: () {},
              ),
            ]),
            const SizedBox(height: 20),
            // Stats Cards
            Row(
              children: [
                _buildStatCard(
                  context,
                  'Reparaciones Activas',
                  '12',
                  Icons.build,
                  Colors.blue,
                ),
                const SizedBox(width: 20),
                _buildStatCard(
                  context,
                  'Clientes Totales',
                  '145',
                  Icons.people,
                  Colors.green,
                ),
                const SizedBox(width: 20),
                _buildStatCard(
                  context,
                  'Ingresos del Mes',
                  '\$15,750',
                  Icons.attach_money,
                  Colors.orange,
                ),
              ],
            ),
            const SizedBox(height: 20),
            // Recent Repairs and Pending Tasks
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Recent Repairs
                  Expanded(
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Reparaciones Recientes',
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                            const SizedBox(height: 20),
                            Expanded(
                              child: ListView.builder(
                                itemCount: 5,
                                itemBuilder: (context, index) {
                                  return ListTile(
                                    leading: CircleAvatar(
                                      backgroundColor: Theme.of(context)
                                          .primaryColor
                                          .withOpacity(0.1),
                                      child: Icon(Icons.settings,
                                          color:
                                              Theme.of(context).primaryColor),
                                    ),
                                    title:
                                        Text('Máquina Singer #${1000 + index}'),
                                    subtitle: Text('Cliente: Juan Pérez'),
                                    trailing: Chip(
                                      label: Text('En Proceso'),
                                      backgroundColor: Colors.orange[100],
                                      labelStyle:
                                          TextStyle(color: Colors.orange[900]),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),
                  // Pending Tasks
                  Expanded(
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Tareas Pendientes',
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                            const SizedBox(height: 20),
                            Expanded(
                              child: ListView.builder(
                                itemCount: 5,
                                itemBuilder: (context, index) {
                                  return CheckboxListTile(
                                    value: false,
                                    onChanged: (value) {},
                                    title: Text('Revisar máquina de ${[
                                      'María',
                                      'Pedro',
                                      'Ana',
                                      'Luis',
                                      'Carmen'
                                    ][index]}'),
                                    subtitle: Text(
                                        'Fecha límite: ${DateTime.now().add(Duration(days: index + 1)).toString().substring(0, 10)}'),
                                    secondary: Icon(Icons.pending_actions),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(BuildContext context, String title, String value,
      IconData icon, Color color) {
    return Expanded(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(icon, color: color, size: 30),
              ),
              const SizedBox(width: 15),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 5),
                  Text(
                    value,
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
