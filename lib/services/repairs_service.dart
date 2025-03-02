import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mcs_app/assets/scripts/prefs.dart';

import 'package:mcs_app/models/response_model.dart';
import 'package:mcs_app/models/repair_model.dart';

class RepairsService implements Service<RepairModel> {
  static final mainUrl = dotenv.get('API_URL', fallback: 'API_URL not found');
  static Future<String> newService({
    required String token,
    required String idMachine,
  }) {
    final headers = {
      'Access-Token': token,
      'Content-Type': 'application/json',
    };
    final body = jsonEncode({
      'machine_id': idMachine,
    });
    return http
        .post(
      Uri.parse('$mainUrl/service/new'),
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

  static Future<DataListModel<RepairModel>> getServices({
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
          '$mainUrl/service/services?machine_id=$search&limit=$limit&page=$page'),
      headers: headers,
    )
        .then((res) {
      Map<String, dynamic> data = json.decode(res.body);
      ResponseModel r = ResponseModel(data);

      if (r.code != 200) throw r.msg;
      return DataListModel<RepairModel>(
        count: data['count'],
        data: RepairModel.fromList(data['data']),
      );
    }).catchError((err) => throw err);
  }

  @override
  Future<DataListModel<RepairModel>> getSearch(
      {required String token,
      required String search,
      required int limit,
      required int page}) {
    final headers = {
      'Access-Token': token,
    };
    return http
        .get(
      Uri.parse(
          '$mainUrl/service/services?machine_id=$search&limit=$limit&page=$page'),
      headers: headers,
    )
        .then((res) {
      Map<String, dynamic> data = json.decode(res.body);
      ResponseModel r = ResponseModel(data);

      if (r.code != 200) throw r.msg;
      return DataListModel<RepairModel>(
        count: data['count'],
        data: RepairModel.fromList(data['data']),
      );
    }).catchError((err) => throw err);
  }
}
