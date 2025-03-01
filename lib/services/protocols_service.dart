import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:mcs_app/models/protocol_model.dart';
import 'package:mcs_app/models/response_model.dart';

class ProtocolsService {
  static final mainUrl = dotenv.get('API_URL', fallback: 'API_URL not found');
  static Future<String> create({
    required String token,
    required String name,
    required String acronym,
    required String description,
  }) {
    final headers = {
      'Access-Token': token,
      'Content-Type': 'application/json',
    };
    final body = jsonEncode({
      'acronym': acronym,
      'name': name,
      'description': description,
    });
    return http
        .post(
      Uri.parse('$mainUrl/protocol/create'),
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

  static Future<DataListModel<ProtocolModel>> getProtocols({
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
          '$mainUrl/protocol/protocols?name=$search&limit=$limit&page=$page'),
      headers: headers,
    )
        .then((res) {
      Map<String, dynamic> data = json.decode(res.body);
      ResponseModel r = ResponseModel(data);

      if (r.code != 200) throw r.msg;
      return DataListModel<ProtocolModel>(
        count: data['count'],
        data: ProtocolModel.fromList(data['data']),
      );
    }).catchError((err) => throw err);
  }
}
