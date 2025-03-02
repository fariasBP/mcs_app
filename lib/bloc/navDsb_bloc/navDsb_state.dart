part of 'navDsb_bloc.dart';

class NavDsbState {
  final int index;
  final Widget widget;
  static final List<Widget> widgets = [
    const OverviewScreen(),
    CompaniesScreen(),
    BrandsScreen(),
    ProtocolsScreen(),
    TypesScreen(),
    MachinesScreen(),
    RepairsScreen(),
    ClientsScreen(),
    InventoryScreen(),
    InvoicesScreen(),
  ];
  final Widget detailsWidget;
  final bool details;
  NavDsbState(
      {required this.index,
      required this.widget,
      required this.details,
      required this.detailsWidget});
}
