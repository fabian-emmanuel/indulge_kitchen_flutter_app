import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:indulge_kitchen/data/controllers/cart_controller.dart';
import 'package:indulge_kitchen/data/controllers/popular_product_controller.dart';
import 'package:indulge_kitchen/data/controllers/recommended_product_controller.dart';
import 'package:indulge_kitchen/routes/routes_helper.dart';
import 'package:indulge_kitchen/utils/app_constants.dart';
import 'package:indulge_kitchen/utils/colors.dart';
import 'package:indulge_kitchen/utils/dimensions.dart';
import 'package:indulge_kitchen/widgets/app_icon.dart';
import 'package:indulge_kitchen/widgets/big_text.dart';
import 'package:indulge_kitchen/widgets/small_text.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);
  final String _cartPage = AppConstants.CART_PAGE;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: Dimensions.len30 * 2,
            left: Dimensions.wit20,
            right: Dimensions.wit20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppIcon(
                  icon: Icons.arrow_back_ios,
                  iconSize: Dimensions.len24,
                  iconColor: Colors.white,
                  bgColor: AppColors.mainColor,
                ),
                SizedBox(
                  width: Dimensions.wit20 * 5,
                ),
                GestureDetector(
                  onTap: () {
                    Get.toNamed(RouteHelper.getInitial());
                  },
                  child: AppIcon(
                    icon: Icons.home_outlined,
                    iconSize: Dimensions.len24,
                    iconColor: Colors.white,
                    bgColor: AppColors.mainColor,
                  ),
                ),
                AppIcon(
                  icon: CupertinoIcons.cart,
                  iconSize: Dimensions.len24,
                  iconColor: Colors.white,
                  bgColor: AppColors.mainColor,
                ),
              ],
            ),
          ),
          Positioned(
            top: Dimensions.len20 * 5,
            left: Dimensions.wit20,
            right: Dimensions.wit20,
            bottom: 0,
            child: Container(
              margin: EdgeInsets.only(top: Dimensions.len15),
              child: MediaQuery.removePadding(
                context: context,
                removeTop: true,
                child: GetBuilder<CartController>(builder: (controller) {
                  var _itemsList = controller.getItems;
                  return ListView.builder(
                      itemCount: _itemsList.length,
                      itemBuilder: (_, index) {
                        return Container(
                          height: Dimensions.len20 * 5,
                          width: double.maxFinite,
                          margin: EdgeInsets.only(bottom: Dimensions.len10),
                          child: Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  var popularIndex =
                                      Get.find<PopularProductController>()
                                          .popularProductList
                                          .indexOf(_itemsList[index].product!);
                                  var recommendedIndex =
                                      Get.find<RecommendedProductController>()
                                          .recommendedProductList
                                          .indexOf(_itemsList[index].product);

                                  (popularIndex >= 0)
                                      ? {
                                          Get.toNamed(
                                              RouteHelper.getPopularFood(
                                                  popularIndex, _cartPage))
                                        }
                                      : (recommendedIndex < 0)
                                          ? {
                                              Get.snackbar(
                                                "History Product",
                                                "Product review not available for history items!",
                                                backgroundColor:
                                                    AppColors.mainColor,
                                                colorText: Colors.white,
                                              )
                                            }
                                          : {
                                              Get.toNamed(RouteHelper
                                                  .getRecommendedFood(
                                                      recommendedIndex,
                                                      _cartPage))
                                            };
                                },
                                child: Container(
                                  height: Dimensions.len20 * 5,
                                  width: Dimensions.len20 * 5,
                                  // margin: EdgeInsets.only(bottom: Dimensions.len10),
                                  decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.circular(Dimensions.len20),
                                    image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: NetworkImage(
                                          AppConstants.BASE_URL +
                                              AppConstants.UPLOADS_URI +
                                              _itemsList[index].img!),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: Dimensions.wit10),
                              Expanded(
                                child: SizedBox(
                                  height: Dimensions.len20 * 5,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      BigText(
                                          text: _itemsList[index].name!,
                                          color: Colors.black54),
                                      SmallText(text: 'Spicy'),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          BigText(
                                            text:
                                                "\$${_itemsList[index].price!}",
                                            color: Colors.redAccent,
                                          ),
                                          Row(
                                            children: [
                                              Container(
                                                padding: EdgeInsets.only(
                                                  left: Dimensions.wit10,
                                                  top: Dimensions.len10,
                                                  right: Dimensions.wit10,
                                                  bottom: Dimensions.len10,
                                                ),
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          Dimensions.len10),
                                                  color: Colors.white,
                                                ),
                                                child: Row(
                                                  children: [
                                                    GestureDetector(
                                                      onTap: () {
                                                        controller.addItem(
                                                            _itemsList[index]
                                                                .product!,
                                                            -1);
                                                      },
                                                      child: const Icon(
                                                          Icons.remove,
                                                          color: AppColors
                                                              .signColor),
                                                    ),
                                                    SizedBox(
                                                        width: Dimensions.wit5),
                                                    BigText(
                                                        text:
                                                            "${_itemsList[index].quantity}"),
                                                    SizedBox(
                                                        width: Dimensions.wit5),
                                                    GestureDetector(
                                                      onTap: () {
                                                        controller.addItem(
                                                            _itemsList[index]
                                                                .product!,
                                                            1);
                                                      },
                                                      child: const Icon(
                                                          Icons.add,
                                                          color: AppColors
                                                              .signColor),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      });
                }),
              ),
            ),
          )
        ],
      ),
      bottomNavigationBar: GetBuilder<CartController>(builder: (controller) {
        return Container(
          height: Dimensions.bottomHeightBar,
          padding: EdgeInsets.only(
            top: Dimensions.len30,
            bottom: Dimensions.len30,
            left: Dimensions.len20,
            right: Dimensions.len20,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(Dimensions.len20 * 2),
              topRight: Radius.circular(Dimensions.len20 * 2),
            ),
            color: AppColors.buttonBgColor,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.only(
                  left: Dimensions.wit20,
                  top: Dimensions.len20,
                  right: Dimensions.wit20,
                  bottom: Dimensions.len20,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimensions.len20),
                  color: Colors.white,
                ),
                child: Row(
                  children: [
                    SizedBox(width: Dimensions.wit5),
                    BigText(text: '\$${controller.totalAmount}'),
                    SizedBox(width: Dimensions.wit5),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  controller.addToHistory();
                },
                child: Container(
                    padding: EdgeInsets.only(
                      left: Dimensions.wit20,
                      top: Dimensions.len20,
                      right: Dimensions.wit20,
                      bottom: Dimensions.len20,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Dimensions.len20),
                      color: AppColors.mainColor,
                    ),
                    child: BigText(
                      text: "Checkout",
                      color: Colors.white,
                    )),
              ),
            ],
          ),
        );
      }),
    );
  }
}
