import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mcs_app/assets/scripts/prefs.dart';

import 'package:mcs_app/models/brand_model.dart';
import 'package:mcs_app/models/response_model.dart';

class BrandsService implements Service<BrandModel> {
  static final mainUrl = dotenv.get('API_URL', fallback: 'API_URL not found');
  static Future<String> create({
    required String token,
    required String name,
  }) {
    final headers = {
      'Access-Token': token,
      'Content-Type': 'application/json',
    };
    final body = jsonEncode({
      'name': name,
    });
    return http
        .post(
      Uri.parse('$mainUrl/brand/create'),
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

  static Future<DataListModel<BrandModel>> getBrands({
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
      Uri.parse('$mainUrl/brand/brands?name=$search&limit=$limit&page=$page'),
      headers: headers,
    )
        .then((res) {
      Map<String, dynamic> data = json.decode(res.body);
      ResponseModel r = ResponseModel(data);

      if (r.code != 200) throw r.msg;
      return DataListModel<BrandModel>(
        count: data['count'],
        data: BrandModel.fromList(data['data']),
      );
    }).catchError((err) => throw err);
  }

  @override
  Future<DataListModel<BrandModel>> getSearch(
      {required String token,
      required String search,
      required int limit,
      required int page}) {
    final headers = {
      'Access-Token': token,
    };
    return http
        .get(
      Uri.parse('$mainUrl/brand/brands?name=$search&limit=$limit&page=$page'),
      headers: headers,
    )
        .then((res) {
      Map<String, dynamic> data = json.decode(res.body);
      ResponseModel r = ResponseModel(data);

      if (r.code != 200) throw r.msg;
      return DataListModel<BrandModel>(
        count: data['count'],
        data: BrandModel.fromList(data['data']),
      );
    }).catchError((err) => throw err);
  }
}
