import 'package:get/get.dart';
import 'package:indulge_kitchen/data/api/api_client.dart';
import 'package:indulge_kitchen/data/models/sign_up_model.dart';
import 'package:indulge_kitchen/utils/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthRepo {
  final ApiClient apiClient;
  final SharedPreferences preferences;

  AuthRepo({required this.apiClient, required this.preferences});

  Future<Response> registration(SignUpModel model) async {
    print('got to auth repo');
    return await apiClient.postData(
        AppConstants.REGISTRATION_URI, model.toJson());
  }

  Future<Response> login(String email, String password) async {
    print('got to auth repo');
    return await apiClient.postData(
        AppConstants.LOGIN_URI, {'email': email, 'password': password});
  }

  Future<bool> saveUserToken(String token) async {
    apiClient.token = token;
    apiClient.updateHeader(token);
    return await preferences.setString(AppConstants.TOKEN, token);
  }

  Future<void> saveUserEmailAndPassword(String email, String password) async {
    try {
      await preferences.setString(AppConstants.EMAIL, email);
      await preferences.setString(AppConstants.PASSWORD, password);
    } catch (e) {
      rethrow;
    }
  }

  Future<String> getUserToken() async {
    return await preferences.getString(AppConstants.TOKEN) ?? "None";
  }

  bool isUserLoggedIn() {
    return preferences.containsKey(AppConstants.TOKEN);
  }

  bool clearSharedData() {
    preferences.remove(AppConstants.TOKEN);
    preferences.remove(AppConstants.PASSWORD);
    preferences.remove(AppConstants.EMAIL);
    apiClient.token = '';
    apiClient.updateHeader('');
    return true;
  }
}
