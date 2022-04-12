import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:indulge_kitchen/data/controllers/popular_product_controller.dart';
import 'package:indulge_kitchen/screens/home/main_food_page.dart';
import 'package:indulge_kitchen/utils/app_constants.dart';
import 'package:indulge_kitchen/utils/colors.dart';
import 'package:indulge_kitchen/utils/dimensions.dart';
import 'package:indulge_kitchen/widgets/app_column.dart';
import 'package:indulge_kitchen/widgets/app_icon.dart';
import 'package:indulge_kitchen/widgets/big_text.dart';
import 'package:indulge_kitchen/widgets/expandable_text.dart';

class PopularFoodDetail extends StatelessWidget {
  final int pageId;
  const PopularFoodDetail({Key? key, required this.pageId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var product =
        Get.find<PopularProductController>().popularProductList[pageId];
    // print("page id is " + pageId.toString());
    // print("product name id is " + product.name.toString());
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Background image
          Positioned(
            left: 0,
            right: 0,
            child: Container(
              width: double.maxFinite,
              height: Dimensions.popularFoodImgSize,
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(AppConstants.BASE_URL +
                      AppConstants.UPLOADS_URI +
                      product.img!),
                ),
              ),
            ),
          ),
          // Icons widget
          Positioned(
            top: Dimensions.len45,
            left: Dimensions.wit20,
            right: Dimensions.wit20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                    onTap: () {
                      Get.to(() => const MainFoodPage());
                    },
                    child: AppIcon(icon: Icons.arrow_back_ios)),
                AppIcon(icon: Icons.shopping_cart_outlined),
              ],
            ),
          ),
          //Introduction of food
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            top: Dimensions.popularFoodImgSize - 20,
            child: Container(
              padding: EdgeInsets.only(
                left: Dimensions.len20,
                right: Dimensions.len20,
                top: Dimensions.len20,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(Dimensions.len20),
                  topRight: Radius.circular(
                    Dimensions.len20,
                  ),
                ),
                color: Colors.white,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppColumn(text: product.name!),
                  SizedBox(height: Dimensions.len20),
                  BigText(text: "Introduce"),
                  SizedBox(height: Dimensions.len20),
                  //Expandable text widget
                  Expanded(
                    child: SingleChildScrollView(
                      child: ExpandableTextWidget(text: product.description!),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
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
                  const Icon(Icons.remove, color: AppColors.signColor),
                  SizedBox(width: Dimensions.wit5),
                  BigText(text: "0"),
                  SizedBox(width: Dimensions.wit5),
                  const Icon(Icons.add, color: AppColors.signColor),
                ],
              ),
            ),
            Container(
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
          ],
        ),
      ),
    );
  }
}
