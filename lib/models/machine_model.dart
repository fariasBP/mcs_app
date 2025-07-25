class MachineModel {
  late String id;
  late DateTime createdAt;
  late DateTime? updatedAt;
  late String companyId;
  late String companyName;
  late String companyManager;
  late String companyContact;
  late String typeId;
  late String typeName;
  late String brandId;
  late String brandName;
  late String serial;
  late String model;

  MachineModel.mapToModel(dynamic data) {
    id = data['id'];
    createdAt = DateTime.parse(data['created_at']);
    updatedAt =
        data['updated_at'] == null ? null : DateTime.parse(data['updated_at']);
    companyId = data['company_id'];
    companyName = data['company_name'];
    companyManager = data['company_manager'];
    companyContact = data['company_contact'];
    typeId = data['machine_type_id'];
    typeName = data['machine_type_name'];
    brandId = data['brand_id'];
    brandName = data['brand_name'];
    serial = data['serial'];
    model = data['model'];
  }

  static List<MachineModel> fromList(List list) {
    List<MachineModel> l = [];
    l = list.map((e) => MachineModel.mapToModel(e)).toList();
    return l;
  }
}
