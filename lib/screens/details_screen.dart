import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:mcs_app/bloc/navDsb_bloc/navDsb_bloc.dart';
import 'package:mcs_app/widgets/header_widget.dart';

class DetailsScreen extends StatelessWidget {
  final String title;
  final Widget child;
  const DetailsScreen({super.key, required this.title, required this.child});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        HeaderWidget(
          title: title,
          onBack: () =>
              BlocProvider.of<NavDsbBloc>(context).add(CloseDetailsNavDsb()),
        ),
        Expanded(
          child: child,
        ),
      ],
    );
  }
}
