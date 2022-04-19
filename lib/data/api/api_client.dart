import 'package:get/get.dart';
import 'package:indulge_kitchen/utils/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiClient extends GetConnect implements GetxService {
  late String token;
  final String appBaseUrl;
  late Map<String, String> _mainHeaders;
  late SharedPreferences preferences;

  ApiClient({required this.appBaseUrl, required this.preferences}) {
    baseUrl = appBaseUrl;
    timeout = const Duration(seconds: 30);
    token = preferences.getString(AppConstants.TOKEN) ?? '';
    _mainHeaders = {
      'Content-type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token',
    };
  }

  void updateHeader(String token) {
    _mainHeaders = {
      'Content-type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token',
    };
  }

  Future<Response> getData(String uri, {Map<String, String>? headers}) async {
    try {
      return await get(uri, headers: headers ?? _mainHeaders);
    } catch (e) {
      return Response(statusCode: 1, statusText: e.toString());
    }
  }

  Future<Response> postData(String uri, dynamic body) async {
    try {
      return await post(uri, body, headers: _mainHeaders);
    } catch (e) {
      return Response(statusCode: 1, statusText: e.toString());
    }
  }
}
