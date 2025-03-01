class CommonModel {
  late String id;
  late String name;
}

class ResponseModel {
  late final int code;
  late final String msg;
  late final String token;
  late final int count;
  ResponseModel(Map<String, dynamic> json) {
    // print(json);
    code = json['code'];
    msg = json['msg'];
    token = json['token'] ?? '';
    count = json['count'] ?? 0;
  }
}

class DataListModel<T> {
  late final List<T> data;
  late final int count;
  DataListModel({required this.data, required this.count});
}

class DataListCommonModel {
  late final List<CommonModel> data;
  late final int count;
  DataListCommonModel({required this.data, required this.count});
}
