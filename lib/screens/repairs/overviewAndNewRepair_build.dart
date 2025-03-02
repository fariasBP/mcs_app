import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mcs_app/assets/scripts/prefs.dart';
import 'package:mcs_app/bloc/repairs_bloc/repairs_bloc.dart';
import 'package:mcs_app/screens/repairs/stateRepair_Build.dart';
import 'package:mcs_app/services/repairs_service.dart';
import 'package:mcs_app/widgets/button_widget.dart';
import 'package:mcs_app/widgets/msgDialog_widget.dart';
import 'package:mcs_app/widgets/title_widget.dart';

class OverviewAndNewRepairBuild extends StatelessWidget {
  OverviewAndNewRepairBuild({super.key});

  final _labelMachineController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RepairsBloc, RepairsState>(
      builder: (context, state) => Card(
        elevation: 0,
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const TitleWidget(title: 'Servicios'),
              const SizedBox(height: 16),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  StateRepairBuild(
                    icon: Icons.description_outlined,
                    label: 'Servicios\ntotales',
                    value: '765',
                  ),
                  StateRepairBuild(
                    icon: Icons.pending_actions_outlined,
                    label: 'Servicios en\nproceso',
                    value: '765',
                  ),
                  StateRepairBuild(
                    icon: Icons.local_shipping_outlined,
                    label: 'Servicios\nentregados',
                    value: '765',
                  ),
                ],
              ),
              const SizedBox(height: 16),
              ButtonWidget(
                label: 'Crear Servicio',
                style: ButtonWidget.NORMAL,
                onPressed: () => showDialog(
                  context: context,
                  builder: (BuildContext contextD) {
                    return BlocBuilder<RepairsBloc, RepairsState>(
                      builder: (contextE, stateE) => AlertDialog(
                        scrollable: true,
                        title: const Text('Nuevo Servicio'),
                        content: SizedBox(
                          width: 300,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text('aqui'),
                            ],
                          ),
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text('Cancelar'),
                          ),
                          ButtonWidget(
                            onPressed: () {
                              BlocProvider.of<RepairsBloc>(contextE)
                                  .add(StartLoadingCreateRepairsEvent());
                              RepairsService.newService(
                                      token:
                                          Prefs.init?.getString(Prefs.token) ??
                                              '',
                                      idMachine: stateE.idMachine)
                                  .then((msg) {
                                print('aquiiiii');
                                BlocProvider.of<RepairsBloc>(contextE)
                                    .add(EndLoadingCreateRepairsEvent());
                                Navigator.of(context).pop();
                                showDialog(
                                  context: context,
                                  builder: (context) => const MsgDialogWidget(
                                    msg: 'Se creo el servicio con exito',
                                    typeMsg: MsgDialogWidget.SUCCESS,
                                  ),
                                );
                              }).catchError((err) {
                                BlocProvider.of<RepairsBloc>(contextE)
                                    .add(EndLoadingCreateRepairsEvent());
                                showDialog(
                                  context: context,
                                  builder: (context) => MsgDialogWidget(
                                    msg: err.toString(),
                                    typeMsg: MsgDialogWidget.DANGER,
                                  ),
                                );
                              });
                            },
                            style: ButtonWidget.SUCCESS,
                            label: 'Crear Servicio',
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
