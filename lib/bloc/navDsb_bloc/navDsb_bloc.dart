import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:mcs_app/screens/brands_screen.dart';
import 'package:mcs_app/screens/clients_screen.dart';
import 'package:mcs_app/screens/companies_screen.dart';

import 'package:mcs_app/screens/details_screen.dart';
import 'package:mcs_app/screens/inventory_screen.dart';
import 'package:mcs_app/screens/invoices_screen.dart';
import 'package:mcs_app/screens/machines_screen.dart';
import 'package:mcs_app/screens/overview_screen.dart';
import 'package:mcs_app/screens/protocols_screen.dart';
import 'package:mcs_app/screens/repairs_screen.dart';
import 'package:mcs_app/screens/types_screen.dart';

part 'navDsb_state.dart';
part 'navDsb_event.dart';

class NavDsbBloc extends Bloc<NavDsbEvent, NavDsbState> {
  NavDsbBloc()
      : super(NavDsbState(
            index: 0,
            widget: NavDsbState.widgets[0],
            details: false,
            detailsWidget: DetailsScreen(title: '', child: Container()))) {
    on<ChangeNavDsb>(
      (event, emit) => emit(NavDsbState(
          index: event.index,
          widget: NavDsbState.widgets[event.index],
          details: false,
          detailsWidget: state.detailsWidget)),
    );
    on<OpenDetailsNavDsb>(
      (event, emit) => emit(NavDsbState(
          index: state.index,
          widget: state.widget,
          details: true,
          detailsWidget:
              DetailsScreen(title: event.title, child: event.child))),
    );
    on<CloseDetailsNavDsb>(
      (event, emit) => emit(NavDsbState(
          index: state.index,
          widget: state.widget,
          details: false,
          detailsWidget: state.detailsWidget)),
    );
  }
}
