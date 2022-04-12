import 'package:get/get.dart';
import 'package:indulge_kitchen/data/api/api_client.dart';
import 'package:indulge_kitchen/data/controllers/popular_product_controller.dart';
import 'package:indulge_kitchen/data/controllers/recommended_product_controller.dart';
import 'package:indulge_kitchen/data/repository/popular_product_repo.dart';
import 'package:indulge_kitchen/data/repository/recommended_product_repo.dart';
import 'package:indulge_kitchen/utils/app_constants.dart';

Future<void> init() async {
  //clients
  Get.lazyPut(() => ApiClient(appBaseUrl: AppConstants.BASE_URL));

  //repositories
  Get.lazyPut(() => PopularProductRepo(apiClient: Get.find()));
  Get.lazyPut(() => RecommendedProductRepo(apiClient: Get.find()));

  //controllers
  Get.lazyPut(() => PopularProductController(popularProductRepo: Get.find()));
  Get.lazyPut(
      () => RecommendedProductController(recommendedProductRepo: Get.find()));
}
