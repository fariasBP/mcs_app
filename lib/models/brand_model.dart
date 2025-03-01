import 'package:mcs_app/models/response_model.dart';

class BrandModel extends CommonModel {
  BrandModel.mapToModel(dynamic data) {
    id = data['id'];
    name = data['name'];
  }

  static List<BrandModel> fromList(List list) {
    List<BrandModel> l = [];
    l = list.map((e) => BrandModel.mapToModel(e)).toList();
    return l;
  }
}
