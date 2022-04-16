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
import 'package:indulge_kitchen/widgets/expandable_text.dart';

class RecommendedFoodDetail extends StatelessWidget {
  final int pageId;
  final String page;
  const RecommendedFoodDetail(
      {Key? key, required this.pageId, required this.page})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var product =
        Get.find<RecommendedProductController>().recommendedProductList[pageId];
    Get.find<PopularProductController>()
        .initProduct(product, Get.find<CartController>());
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            automaticallyImplyLeading: false,
            toolbarHeight: 75,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    (page == 'cartpage')
                        ? Get.toNamed(RouteHelper.getCartPage())
                        : Get.toNamed(RouteHelper.getInitial());
                  },
                  child: AppIcon(
                    icon: Icons.clear,
                  ),
                ),
                // AppIcon(icon: Icons.shopping_cart_outlined),
                GetBuilder<PopularProductController>(builder: (controller) {
                  var totalItems =
                      Get.find<PopularProductController>().totalItems;
                  return GestureDetector(
                    onTap: () {
                      if (totalItems > 0) {
                        Get.toNamed(RouteHelper.getCartPage());
                      }
                    },
                    child: Stack(
                      children: [
                        AppIcon(icon: CupertinoIcons.cart),
                        totalItems > 0
                            ? Positioned(
                                top: 0,
                                right: 0,
                                child: AppIcon(
                                  icon: Icons.circle,
                                  size: Dimensions.len20,
                                  iconColor: Colors.transparent,
                                  bgColor: AppColors.mainColor,
                                ),
                              )
                            : Container(),
                        totalItems > 0
                            ? Positioned(
                                top: 3,
                                right: 4,
                                child: BigText(
                                  text: totalItems.toString(),
                                  size: 12,
                                  color: Colors.white,
                                ))
                            : Container()
                      ],
                    ),
                  );
                }),
              ],
            ),
            bottom: PreferredSize(
                child: Container(
                  child: Center(
                    child: BigText(
                      text: product.name!,
                      size: Dimensions.len26,
                    ),
                  ),
                  width: double.maxFinite,
                  padding: EdgeInsets.only(
                      top: Dimensions.len5, bottom: Dimensions.len10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(Dimensions.len20),
                      topRight: Radius.circular(Dimensions.len20),
                    ),
                    color: Colors.white,
                  ),
                ),
                preferredSize: const Size.fromHeight(20.0)),
            pinned: true,
            backgroundColor: AppColors.yellowColor,
            expandedHeight: 300,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.network(
                AppConstants.BASE_URL + AppConstants.UPLOADS_URI + product.img!,
                width: double.maxFinite,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(
                      left: Dimensions.len20,
                      right: Dimensions.len20,
                      bottom: Dimensions.len20),
                  child: ExpandableTextWidget(text: product.description!),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar:
          GetBuilder<PopularProductController>(builder: (popularController) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: EdgeInsets.only(
                left: Dimensions.wit20 * 2.5,
                right: Dimensions.wit20 * 2.5,
                top: Dimensions.len10,
                bottom: Dimensions.len10,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      popularController.setQuantity(false);
                    },
                    child: AppIcon(
                      icon: Icons.remove,
                      bgColor: AppColors.mainColor,
                      iconColor: Colors.white,
                      iconSize: Dimensions.len24,
                    ),
                  ),
                  BigText(
                    text:
                        "\$${product.price!} X ${popularController.inCartItems}",
                    color: AppColors.mainBlackColor,
                    size: Dimensions.len26,
                  ),
                  GestureDetector(
                    onTap: () {
                      popularController.setQuantity(true);
                    },
                    child: AppIcon(
                      icon: Icons.add,
                      bgColor: AppColors.mainColor,
                      iconColor: Colors.white,
                      iconSize: Dimensions.len24,
                    ),
                  ),
                ],
              ),
            ),
            Container(
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
                    child: const Icon(
                      Icons.favorite,
                      color: AppColors.mainColor,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      popularController.addItem(product);
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
                          text: "\$${product.price!} | Add to Cart",
                          color: Colors.white,
                        )),
                  ),
                ],
              ),
            ),
          ],
        );
      }),
    );
  }
}
