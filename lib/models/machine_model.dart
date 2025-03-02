import 'package:mcs_app/models/repair_model.dart';

class MachineModel {
  late String companyName;
  late String typeName;
  late String brandName;
  late String serial;
  late String model;
  late List<RepairModel> repairs;

  MachineModel.mapToModel(dynamic data) {
    companyName = data['company'];
    typeName = data['machine_type'];
    brandName = data['brand'];
    serial = data['serial'];
    model = data['model'];
    repairs = RepairModel.fromList(data['services']);
  }

  static List<MachineModel> fromList(List list) {
    List<MachineModel> l = [];
    l = list.map((e) => MachineModel.mapToModel(e)).toList();
    return l;
  }
}

class MachineBasicModel {
  late String id;
  late String companyName;
  late String typeName;
  late String brandName;
  late String serial;
  late String model;
  MachineBasicModel.mapToModel(dynamic data) {
    id = data['id'];
    companyName = data['company'];
    typeName = data['machine_type'];
    brandName = data['brand'];
    serial = data['serial'];
    model = data['model'];
  }

  static List<MachineBasicModel> fromList(List list) {
    List<MachineBasicModel> l = [];
    l = list.map((e) => MachineBasicModel.mapToModel(e)).toList();
    return l;
  }
}
