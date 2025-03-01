import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:mcs_app/models/response_model.dart';

class AuthService {
  static final mainUrl = dotenv.get('API_URL', fallback: 'API_URL not found');
  static Future<String> login(String user, String pwd) {
    final headers = {'Content-Type': 'application/json'};
    final body = jsonEncode({'user': user, 'pwd': pwd});
    return http
        .post(
      Uri.parse('$mainUrl/auth/login'),
      headers: headers,
      body: body,
    )
        .then((res) {
      Map<String, dynamic> data = json.decode(res.body);
      ResponseModel r = ResponseModel(data);
      if (r.code != 200) throw r.msg;
      return r.token;
    }).catchError((err) => throw err);
  }

  static Future<String> checkToken(String token) {
    final headers = {'Content-Type': 'application/json', 'Access-Token': token};
    return http
        .get(
      Uri.parse('$mainUrl/auth/check-token'),
      headers: headers,
    )
        .then((res) {
      Map<String, dynamic> data = json.decode(res.body);
      ResponseModel r = ResponseModel(data);
      if (r.code != 200) throw r.msg;
      return r.token;
    }).catchError((err) => throw err);
  }
}
