import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mcs_app/assets/scripts/prefs.dart';

import 'package:mcs_app/models/company_model.dart';
import 'package:mcs_app/models/response_model.dart';

class CompaniesService implements Service<CompanyModel> {
  static final mainUrl = dotenv.get('API_URL', fallback: 'API_URL not found');
  static Future<String> create({
    required String token,
    required String name,
    required String manager,
    required String location,
    required String phone,
    required String description,
  }) {
    final headers = {
      'Access-Token': token,
      'Content-Type': 'application/json',
    };
    final body = jsonEncode({
      'name': name,
      'manager': manager,
      'location': location,
      'contact': phone,
      'description': description
    });
    return http
        .post(
      Uri.parse('$mainUrl/company/create'),
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

  static Future<DataListModel<CompanyModel>> getCompanies(
      {String search = '',
      required String token,
      required int limit,
      required int page}) {
    final headers = {
      'Access-Token': token,
    };
    return http
        .get(
      Uri.parse(
          '$mainUrl/company/companies?name=$search&limit=$limit&page=$page'),
      headers: headers,
    )
        .then((res) {
      Map<String, dynamic> data = json.decode(res.body);
      ResponseModel r = ResponseModel(data);

      if (r.code != 200) throw r.msg;
      return DataListModel<CompanyModel>(
        count: data['count'],
        data: CompanyModel.fromList(data['data']),
      );
    }).catchError((err) => throw err);
  }

  @override
  Future<DataListModel<CompanyModel>> getSearch(
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
          '$mainUrl/company/companies?name=$search&limit=$limit&page=$page'),
      headers: headers,
    )
        .then((res) {
      Map<String, dynamic> data = json.decode(res.body);
      ResponseModel r = ResponseModel(data);

      if (r.code != 200) throw r.msg;
      return DataListModel<CompanyModel>(
        count: data['count'],
        data: CompanyModel.fromList(data['data']),
      );
    }).catchError((err) => throw err);
  }
}
