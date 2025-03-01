import 'package:mcs_app/models/response_model.dart';

class CompanyModel extends CommonModel {
  late String manager;
  late String location;
  late String description;
  late String contact;

  CompanyModel.mapToModel(dynamic data) {
    id = data['id'];
    name = data['name'];
    manager = data['manager'];
    location = data['location'];
    description = data['description'];
    contact = data['contact'];
  }

  static List<CompanyModel> fromList(List list) {
    List<CompanyModel> l = [];
    l = list.map((e) => CompanyModel.mapToModel(e)).toList();
    return l;
  }
}
