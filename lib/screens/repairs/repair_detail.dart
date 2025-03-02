import 'package:flutter/material.dart';
import 'package:mcs_app/widgets/button_widget.dart';
import 'package:mcs_app/widgets/timeline_widget.dart';
import 'package:mcs_app/widgets/title_widget.dart';

class RepairDetail extends StatelessWidget {
  const RepairDetail({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const SizedBox(width: 16),
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 16),
                _buildServiceStatus(context),
                const SizedBox(height: 16),
                _buildQuickActions(),
                const SizedBox(height: 16),
                _buildProblemsAndMaterials(),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
        const SizedBox(width: 16),
        Container(
          width: 350,
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 16),
                _buildClientInfo(),
                const SizedBox(height: 16),
                _buildMachineInfo(),
                const SizedBox(height: 16),
                _buildReportedProblems(),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
        const SizedBox(width: 16),
      ],
    );
  }

  Widget _buildServiceStatus(BuildContext context) {
    int status = 3;
    List<Map<String, dynamic>> listJson = [
      {
        'icon': Icons.description_outlined,
        'label': 'Recepcion',
      },
      {
        'icon': Icons.search,
        'label': 'Inspeccion y\ndiagnostico',
      },
      {
        'icon': Icons.build,
        'label': 'Ejecución',
      },
      {
        'icon': Icons.checklist,
        'label': 'Pruebas y\nverificacion',
      },
      {
        'icon': Icons.local_shipping,
        'label': 'Evaluacion y\nentrega',
      },
    ];
    List<TimelineModel> list = TimelineModel.fromListJson(listJson);
    return Card(
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const TitleWidget(title: 'Estado del Servicio'),
            TimelineWidget(list: list, status: status),
            const SizedBox(height: 24),
            Row(
              children: [
                ButtonWidget(
                    label: 'Retroceder',
                    style: ButtonWidget.WARNING,
                    onPressed: () {}),
                Spacer(),
                ButtonWidget(
                    label: 'Avanzar',
                    style: ButtonWidget.NORMAL,
                    onPressed: () {}),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickActions() {
    return Card(
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const TitleWidget(title: 'Acciones Rápidas'),
            const SizedBox(height: 16),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                ButtonWidget(
                    label: 'Agregar Material',
                    style: ButtonWidget.NORMAL,
                    onPressed: () {}),
                ButtonWidget(
                    label: 'Agregar problemas encontrados',
                    style: ButtonWidget.NORMAL,
                    onPressed: () {}),
                ButtonWidget(
                    label: 'Añadir Personal',
                    style: ButtonWidget.NORMAL,
                    onPressed: () {}),
                ButtonWidget(
                    label: 'Agregar Problemas reportados',
                    style: ButtonWidget.NORMAL,
                    onPressed: () {}),
                ButtonWidget(
                    label: 'Finalizar servicio',
                    style: ButtonWidget.NORMAL,
                    onPressed: () {}),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProblemsAndMaterials() {
    return Card(
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const TitleWidget(title: 'Problemas y Materiales'),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ButtonWidget(
                    label: 'Problemas',
                    style: ButtonWidget.NORMAL,
                    onPressed: () {}),
                const SizedBox(width: 8),
                ButtonWidget(
                    label: 'Materiales',
                    style: ButtonWidget.DEFAULT,
                    onPressed: () {}),
              ],
            ),
            const SizedBox(height: 16),
            _buildProtocolSection(
              'Protocolo 1 - Cableado e interruptores',
              [
                problemSolutionItemWidget(
                  'Lorem ipsum dolor sit amet consectetur. Elit lacus faucibus et vel dolor fermentum nascetur libero lorem.',
                  'Lorem ipsum dolor sit amet consectetur. Aliquet vivamus suspendisse fermentum risus at proin.',
                ),
                problemSolutionItemWidget(
                  'Lorem ipsum dolor sit amet consectetur. Elit lacus faucibus et vel dolor fermentum nascetur libero lorem.',
                  null,
                ),
              ],
            ),
            const SizedBox(height: 16),
            _buildProtocolSection(
              'Protocolo 2 - Mecanismo de puntada',
              [
                problemSolutionItemWidget(
                  'Lorem ipsum dolor sit amet consectetur. Elit lacus faucibus et vel dolor fermentum nascetur libero lorem.',
                  'Lorem ipsum dolor sit amet consectetur. Aliquet vivamus suspendisse fermentum risus at proin.',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProtocolSection(String title, List<Widget> problems) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TitleWidget(title: title, question: false),
        const SizedBox(height: 16),
        ...problems,
      ],
    );
  }

  Widget problemSolutionItemWidget(String problem, String? solution) {
    return Card(
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Problema',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(problem),
                    ],
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () {},
                ),
              ],
            ),
            solution != null
                ? const Divider(height: 32)
                : const SizedBox(height: 16),
            solution != null
                ? Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Solución',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(problem),
                          ],
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () {},
                      ),
                    ],
                  )
                : ButtonWidget(
                    label: 'Solucionar',
                    style: ButtonWidget.SUCCESS,
                    onPressed: () {}),
          ],
        ),
      ),
    );
  }

  Widget _buildClientInfo() {
    return Card(
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Text(
                  'Cliente',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(width: 8),
                Icon(Icons.info_outline, color: Colors.grey[600], size: 20),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child:
                      const Icon(Icons.image_not_supported, color: Colors.grey),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Compañía/Taller:',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Text('Miktex'),
                      const SizedBox(height: 8),
                      const Text(
                        'Encargado:',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Text('David Montalvo'),
                      const SizedBox(height: 8),
                      const Text(
                        'Contacto:',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Text('69804765'),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Center(
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF0A2472),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'Ver cliente',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMachineInfo() {
    return Card(
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Text(
                  'Máquina',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(width: 8),
                Icon(Icons.info_outline, color: Colors.grey[600], size: 20),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child:
                      const Icon(Icons.image_not_supported, color: Colors.grey),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Serie:',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Text('35656347666'),
                      const SizedBox(height: 8),
                      const Text(
                        'Modelo:',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Text('Jdk-234'),
                      const SizedBox(height: 8),
                      const Text(
                        'Tipo de máquina:',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Text('Recta'),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Center(
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF0A2472),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'Ver máquina',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildReportedProblems() {
    return Card(
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Text(
                  'Problemas reportados',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(width: 8),
                Icon(Icons.info_outline, color: Colors.grey[600], size: 20),
              ],
            ),
            const SizedBox(height: 16),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 3,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Text(
                    'La maquina presenta ruidos anormales durante la costura',
                    style: TextStyle(color: Colors.grey[700]),
                  ),
                );
              },
            ),
            const SizedBox(height: 16),
            Center(
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF0A2472),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'Agregar un problema reportado',
                  style: TextStyle(color: Colors.white),
                ),
              ),
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
