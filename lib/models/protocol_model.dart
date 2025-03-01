class ProtocolModel {
  late String acronym;
  late String name;
  late String description;

  ProtocolModel.mapToModel(dynamic data) {
    acronym = data['acronym'];
    name = data['name'];
    description = data['description'];
  }

  static List<ProtocolModel> fromList(List list) {
    List<ProtocolModel> l = [];
    l = list.map((e) => ProtocolModel.mapToModel(e)).toList();
    return l;
  }
}
