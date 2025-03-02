import 'package:mcs_app/models/company_model.dart';
import 'package:mcs_app/models/response_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Prefs {
  static SharedPreferences? init;
  static const token = 'token';
  static const superuser = 'superuser';
  static const remember = 'remember';
}

interface class Service<T> {
  Future<DataListModel<T>> getSearch({
    required String token,
    required String search,
    required int limit,
    required int page,
  }) {
    throw UnimplementedError();
  }
}
