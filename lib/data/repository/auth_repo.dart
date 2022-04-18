import 'package:indulge_kitchen/data/api/api_client.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthRepo {
  final ApiClient apiClient;
  final SharedPreferences preferences;

  AuthRepo({required this.apiClient, required this.preferences});
}
