import 'package:get/get.dart';
import 'package:indulge_kitchen/screens/auth/sign_in_page.dart';
import 'package:indulge_kitchen/screens/auth/sign_up_page.dart';
import 'package:indulge_kitchen/screens/cart/cart_page.dart';
import 'package:indulge_kitchen/screens/food/popular_food_detail.dart';
import 'package:indulge_kitchen/screens/food/recommended_food_detail.dart';
import 'package:indulge_kitchen/screens/home/home_page.dart';
import 'package:indulge_kitchen/screens/splash/splash_screen.dart';

class RouteHelper {
  static const String splashScreen = "/splash-screen";
  static const String initial = "/";
  static const String popularFood = "/popular-food";
  static const String recommendedFood = "/recommended-food";
  static const String cartPage = "/cart-page";
  static const String signUpPage = "/sign-up";
  static const String signInPage = "/sign-in";

  static String getSplashScreen() => '$splashScreen';
  static String getInitial() => '$initial';
  static String getPopularFood(int pageId, String page) =>
      '$popularFood?pageId=$pageId&page=$page';
  static String getRecommendedFood(int pageId, String page) =>
      '$recommendedFood?pageId=$pageId&page=$page';
  static String getCartPage() => '$cartPage';
  static String getSingUpPage() => '$signUpPage';
  static String getSignInPage() => '$signInPage';

  static List<GetPage> routes = [
    GetPage(
      name: splashScreen,
      page: () => const SplashScreen(),
    ),
    GetPage(
      name: initial,
      page: () => const HomePage(),
    ),
    GetPage(
      name: popularFood,
      page: () {
        var pageId = Get.parameters['pageId'];
        var page = Get.parameters['page'];
        return PopularFoodDetail(pageId: int.parse(pageId!), page: page!);
      },
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: recommendedFood,
      page: () {
        var pageId = Get.parameters['pageId'];
        var page = Get.parameters['page'];
        return RecommendedFoodDetail(pageId: int.parse(pageId!), page: page!);
      },
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: cartPage,
      page: () => const CartPage(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: signUpPage,
      page: () => const SignUpPage(),
    ),
    GetPage(
      name: signInPage,
      page: () => const SignInPage(),
    ),
  ];
}
