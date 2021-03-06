import 'package:get/get.dart';
import 'package:indulge_kitchen/data/api/api_client.dart';
import 'package:indulge_kitchen/data/controllers/auth_controller.dart';
import 'package:indulge_kitchen/data/controllers/cart_controller.dart';
import 'package:indulge_kitchen/data/controllers/popular_product_controller.dart';
import 'package:indulge_kitchen/data/controllers/recommended_product_controller.dart';
import 'package:indulge_kitchen/data/controllers/user_controller.dart';
import 'package:indulge_kitchen/data/repository/auth_repo.dart';
import 'package:indulge_kitchen/data/repository/cart_repo.dart';
import 'package:indulge_kitchen/data/repository/popular_product_repo.dart';
import 'package:indulge_kitchen/data/repository/recommended_product_repo.dart';
import 'package:indulge_kitchen/data/repository/user_repo.dart';
import 'package:indulge_kitchen/utils/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> init() async {
  final preferences = await SharedPreferences.getInstance();

  Get.lazyPut(() => preferences);
  //clients
  Get.lazyPut(() => ApiClient(appBaseUrl: AppConstants.BASE_URL, preferences:preferences));

  //repositories
  Get.lazyPut(() => PopularProductRepo(apiClient: Get.find()));
  Get.lazyPut(() => RecommendedProductRepo(apiClient: Get.find()));
  Get.lazyPut(() => CartRepo(preferences: Get.find()));
  Get.lazyPut(() => AuthRepo(preferences: Get.find(), apiClient: Get.find()));
  Get.lazyPut(() => UserRepo(apiClient: Get.find()));

  //controllers
  Get.lazyPut(() => PopularProductController(popularProductRepo: Get.find()));
  Get.lazyPut(
      () => RecommendedProductController(recommendedProductRepo: Get.find()));
  Get.lazyPut(() => CartController(cartRepo: Get.find()));
  Get.lazyPut(() => AuthController(authRepo: Get.find()));
  Get.lazyPut(() => UserController(userRepo: Get.find()));
}
