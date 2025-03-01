import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mcs_app/assets/scripts/prefs.dart';
import 'package:mcs_app/bloc/navDsb_bloc/navDsb_bloc.dart';
import 'package:mcs_app/widgets/button_widget.dart';

class NavPanelWidget extends StatelessWidget {
  const NavPanelWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavDsbBloc, NavDsbState>(
      builder: (context, state) => Container(
        width: 250,
        color: Colors.white,
        child: Column(
          children: [
            // Logo and Title
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Image.asset(
                    'lib/assets/img/logo2x.png',
                    width: 90,
                    height: 90,
                  ),
                  const Text(
                    'MITEX',
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      height: 0.8,
                    ),
                  ),
                  const Text(
                    'SERVICIO TÉCNICO',
                    style: TextStyle(
                      fontSize: 10,
                      letterSpacing: 2,
                    ),
                  ),
                ],
              ),
            ),
            const Divider(color: Colors.white24),
            // Navigation Items
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    _buildNavItemPanel(0, Icons.dashboard_outlined,
                        'Vista General', context, state),
                    _buildNavItemPanel(1, Icons.house_outlined,
                        'Empresas - Talleres', context, state),
                    _buildNavItemPanel(2, Icons.mark_chat_read_outlined,
                        'Marcas', context, state),
                    _buildNavItemPanel(3, Icons.format_list_numbered_rtl,
                        'Protocolos', context, state),
                    _buildNavItemPanel(4, Icons.all_inbox_outlined,
                        'Tipos de Máquinas', context, state),
                    _buildNavItemPanel(5, Icons.developer_board_outlined,
                        'Máquinas', context, state),
                    _buildNavItemPanel(6, Icons.engineering_outlined,
                        'Reparaciones', context, state),
                    _buildNavItemPanel(
                        7, Icons.people_outline, 'Clientes', context, state),
                    _buildNavItemPanel(8, Icons.inventory_outlined,
                        'Inventario', context, state),
                    _buildNavItemPanel(9, Icons.receipt_long_outlined,
                        'Facturas', context, state),
                  ],
                ),
              ),
            ),
            // User Profile Section
            Container(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  const Icon(Icons.person_outline_sharp, size: 30),
                  const SizedBox(width: 10),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Admin User',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'Administrador',
                          style: TextStyle(),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.logout_outlined),
                    onPressed: () => _confirmLogout(context),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<dynamic> _confirmLogout(BuildContext context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          scrollable: true,
          title: const Text('¿Desea cerrar la sesión?'),
          content: SizedBox(
            width: 300,
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancelar'),
            ),
            ButtonWidget(
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/');
                Prefs.init?.setString(Prefs.token, '');
                Prefs.init?.setBool(Prefs.remember, false);
              },
              style: ButtonWidget.WARNING,
              label: 'Cerrar Sesión',
            ),
          ],
        );
      },
    );
  }

  Widget _buildNavItemPanel(int index, IconData icon, String title,
      BuildContext context, NavDsbState state) {
    bool isSelected = state.index == index;
    return InkWell(
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 6),
        child: Row(
          children: [
            const SizedBox(width: 24),
            Icon(
              icon,
              size: 22,
              color: isSelected ? Theme.of(context).primaryColor : Colors.black,
            ),
            const SizedBox(width: 16),
            Text(
              title,
              style: TextStyle(
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                color:
                    isSelected ? Theme.of(context).primaryColor : Colors.black,
                fontSize: 13,
              ),
            )
          ],
        ),
      ),
      onTap: () => BlocProvider.of<NavDsbBloc>(context).add(
        ChangeNavDsb(index: index),
      ),
    );
  }
}
