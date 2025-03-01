import 'package:mcs_app/models/response_model.dart';

class TypeModel extends CommonModel {
  late String description;

  TypeModel.mapToModel(dynamic data) {
    id = data['id'];
    name = data['name'];
    description = data['description'];
  }

  static List<TypeModel> fromList(List list) {
    List<TypeModel> l = [];
    l = list.map((e) => TypeModel.mapToModel(e)).toList();
    return l;
  }
}
