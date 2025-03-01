import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mcs_app/bloc/navDsb_bloc/navDsb_bloc.dart';
import 'package:mcs_app/widgets/navPanel_widget.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          // Left Panel - Navigation
          const NavPanelWidget(),
          // Right Panel - Content
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomLeft,
                  end: Alignment.topRight,
                  colors: [
                    Theme.of(context).primaryColor.withOpacity(0.3),
                    Theme.of(context).primaryColor.withOpacity(0.2),
                    Theme.of(context).primaryColor.withOpacity(0.1),
                    Theme.of(context).primaryColor.withOpacity(0.07),
                    Theme.of(context).primaryColor.withOpacity(0.07),
                    Theme.of(context).primaryColor.withOpacity(0.1),
                    Theme.of(context).primaryColor.withOpacity(0.2),
                  ],
                ),
              ),
              child: BlocBuilder<NavDsbBloc, NavDsbState>(
                builder: (context, state) {
                  return state.details ? state.detailsWidget : state.widget;
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
