import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:mcs_app/models/machine_model.dart';
import 'package:mcs_app/models/response_model.dart';

class MachinesService {
  static final mainUrl = dotenv.get('API_URL', fallback: 'API_URL not found');
  static Future<String> create({
    required String companyId,
    required String typeId,
    required String brandId,
    required String model,
    required String serial,
    required String token,
  }) {
    final headers = {
      'Access-Token': token,
      'Content-Type': 'application/json',
    };
    final body = jsonEncode({
      'company_id': companyId,
      'machine_type_id': typeId,
      'brand_id': brandId,
      'model': model,
      'serial': serial
    });
    return http
        .post(
      Uri.parse('$mainUrl/machine/create'),
      headers: headers,
      body: body,
    )
        .then((res) {
      Map<String, dynamic> data = json.decode(res.body);
      ResponseModel r = ResponseModel(data);
      if (r.code != 200) throw r.msg;
      return r.msg;
    }).catchError((err) => throw err);
  }

  static Future<DataListModel<MachineBasicModel>> getMachinesBasic({
    required String token,
    String search = '',
    required int limit,
    required int page,
  }) {
    final headers = {
      'Access-Token': token,
    };
    return http
        .get(
      Uri.parse(
          '$mainUrl/machine/machines-rebuild-basic-byserial?serial=$search&limit=$limit&page=$page'),
      headers: headers,
    )
        .then((res) {
      Map<String, dynamic> data = json.decode(res.body);
      ResponseModel r = ResponseModel(data);

      if (r.code != 200) throw r.msg;
      return DataListModel<MachineBasicModel>(
        count: data['count'],
        data: MachineBasicModel.fromList(data['data']),
      );
    }).catchError((err) => throw err);
  }
}
