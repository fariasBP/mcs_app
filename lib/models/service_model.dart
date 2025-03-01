class ProblemDataModel {
  late String problem;
  late String solution;
  ProblemDataModel.mapToModel(dynamic data) {
    problem = data['problem'];
    solution = data['solution'];
  }

  static List<ProblemDataModel> fromList(List list) {
    List<ProblemDataModel> l = [];
    l = list.map((e) => ProblemDataModel.mapToModel(e)).toList();
    return l;
  }
}

class ProtocolDataModel {
  late String protocol;
  late int status;
  late String note;
  late List<ProblemDataModel> problems;
  ProtocolDataModel.mapToModel(dynamic data) {
    protocol = data['protocol'];
    status = data['status'];
    note = data['note'];
    problems = ProblemDataModel.fromList(data['problems']);
  }

  static List<ProtocolDataModel> fromList(List list) {
    List<ProtocolDataModel> l = [];
    l = list.map((e) => ProtocolDataModel.mapToModel(e)).toList();
    return l;
  }
}

class MaterialDataModel {
  late String name;
  late double price;
  late int number;
  MaterialDataModel.mapToModel(dynamic data) {
    name = data['name'];
    price = data['price'];
    number = data['number'];
  }
  static List<MaterialDataModel> fromList(List list) {
    List<MaterialDataModel> l = [];
    l = list.map((e) => MaterialDataModel.mapToModel(e)).toList();
    return l;
  }
}

class ServiceModel {
  late String id;
  late int status;
  late String comments;
  late List<MaterialDataModel> materials;
  late List<ProtocolDataModel> protocols;

  ServiceModel.mapToModel(dynamic data) {
    id = data['id'];
    status = data['status'];
    comments = data['comments'];
    materials = MaterialDataModel.fromList(data['materials']);
  }

  static List<ServiceModel> fromList(List list) {
    List<ServiceModel> l = [];
    l = list.map((e) => ServiceModel.mapToModel(e)).toList();
    return l;
  }
}
