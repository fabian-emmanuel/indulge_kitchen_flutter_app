import 'package:flutter/material.dart';
import 'package:indulge_kitchen/utils/colors.dart';
import 'package:indulge_kitchen/utils/dimensions.dart';
import 'package:indulge_kitchen/widgets/app_column.dart';
import 'package:indulge_kitchen/widgets/app_icon.dart';
import 'package:indulge_kitchen/widgets/big_text.dart';
import 'package:indulge_kitchen/widgets/expandable_text.dart';

class PopularFoodDetail extends StatelessWidget {
  const PopularFoodDetail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
              decoration: const BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage("assets/image/food0.png"),
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
                AppIcon(icon: Icons.arrow_back_ios),
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
                  const AppColumn(text: "Biryani"),
                  SizedBox(height: Dimensions.len20),
                  BigText(text: "Introduce"),
                  SizedBox(height: Dimensions.len20),
                  //Expandable text widget
                  const Expanded(
                    child: SingleChildScrollView(
                      child: ExpandableTextWidget(
                          text:
                              "Lorem ipsum dolor sit amet, consectetur adipiscing elit, "
                              "sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. "
                              "Erat nam at lectus urna duis convallis convallis tellus. "
                              "Varius duis at consectetur lorem donec. Quam elementum pulvinar "
                              "etiam non quam lacus suspendisse faucibus interdum. Non blandit "
                              "massa enim nec dui. Vitae et leo duis ut diam quam nulla porttitor massa."
                              " Enim praesent elementum facilisis leo vel fringilla est. Lectus mauris "
                              "ultrices eros in. Gravida quis blandit turpis cursus in hac "
                              "habitasse platea dictumst. Elementum eu facilisis sed odio morbi quis "
                              "commodo odio.Lorem ipsum dolor sit amet, consectetur adipiscing elit, "
                              "sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. "
                              "Erat nam at lectus urna duis convallis convallis tellus. Varius duis "
                              "at consectetur lorem donec. Quam elementum pulvinar etiam non quam lacus "
                              "suspendisse faucibus interdum. Non blandit massa enim nec dui. "
                              "Vitae et leo duis ut diam quam nulla porttitor massa. Enim praesent "
                              "elementum facilisis leo vel fringilla est. Lectus mauris ultrices eros in. "
                              "Gravida quis blandit turpis cursus in hac habitasse platea dictumst. "
                              "Elementum eu facilisis sed odio morbi quis commodo odio."),
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
                  text: "\$10 | Add to Cart",
                  color: Colors.white,
                )),
          ],
        ),
      ),
    );
  }
}
