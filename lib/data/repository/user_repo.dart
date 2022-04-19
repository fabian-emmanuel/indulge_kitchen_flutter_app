import 'package:get/get_connect/http/src/response/response.dart';
import 'package:indulge_kitchen/data/api/api_client.dart';
import 'package:indulge_kitchen/utils/app_constants.dart';

class UserRepo {
  final ApiClient apiClient;

  UserRepo({required this.apiClient});

  Future<Response> getUserInfo() async {
    return await apiClient.getData(AppConstants.USER_INFO_URI);
  }
}
