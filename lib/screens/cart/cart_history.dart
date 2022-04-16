import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:indulge_kitchen/data/controllers/cart_controller.dart';
import 'package:indulge_kitchen/data/models/cart_model.dart';
import 'package:indulge_kitchen/routes/routes_helper.dart';
import 'package:indulge_kitchen/utils/app_constants.dart';
import 'package:indulge_kitchen/utils/colors.dart';
import 'package:indulge_kitchen/utils/dimensions.dart';
import 'package:indulge_kitchen/widgets/app_icon.dart';
import 'package:indulge_kitchen/widgets/big_text.dart';
import 'package:indulge_kitchen/widgets/small_text.dart';
import 'package:intl/intl.dart';

class CartHistory extends StatelessWidget {
  const CartHistory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var getCartHistoryList =
        Get.find<CartController>().getCartHistoryList().reversed.toList();
    Map<String, int> cartItemsPerOrder = {};

    for (int i = 0; i < getCartHistoryList.length; i++) {
      if (cartItemsPerOrder.containsKey(getCartHistoryList[i].time)) {
        cartItemsPerOrder.update(
            getCartHistoryList[i].time!, (value) => ++value);
      } else {
        cartItemsPerOrder.putIfAbsent(getCartHistoryList[i].time!, () => 1);
      }
    }

    List<int> cartItemsPerOrderToList() {
      return cartItemsPerOrder.entries.map((e) => e.value).toList();
    }

    List<String> cartOrderTimeToList() {
      return cartItemsPerOrder.entries.map((e) => e.key).toList();
    }

    List<int> itemsPerOrder = cartItemsPerOrderToList();

    var listCounter = 0;

    return Scaffold(
      body: Column(
        children: [
          Container(
            height: Dimensions.len20 * 5,
            color: AppColors.mainColor,
            width: double.maxFinite,
            padding: EdgeInsets.only(
                top: Dimensions.len45,
                left: Dimensions.wit20,
                right: Dimensions.wit20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                BigText(text: 'Cart History', color: Colors.white),
                AppIcon(
                    icon: CupertinoIcons.cart, iconColor: AppColors.mainColor)
              ],
            ),
          ),
          Expanded(
            child: Container(
              margin: EdgeInsets.only(
                top: Dimensions.len20,
                left: Dimensions.wit20,
                right: Dimensions.wit20,
              ),
              child: MediaQuery.removePadding(
                removeTop: true,
                context: context,
                child: ListView(
                  children: [
                    for (int i = 0; i < itemsPerOrder.length; i++)
                      Container(
                        height: Dimensions.len30 * 4,
                        margin: EdgeInsets.only(bottom: Dimensions.len16 / 2),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            (() {
                              DateTime parsedDate =
                                  DateFormat('yyyy-MM-dd HH:mm:ss').parse(
                                      getCartHistoryList[listCounter].time!);
                              var outputFormat =
                                  DateFormat('MM/dd/yyyy hh:mm a');
                              var outputDate = outputFormat.format(parsedDate);
                              return BigText(
                                  text: outputDate, size: Dimensions.len15);
                            }()),
                            SizedBox(height: Dimensions.len10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Wrap(
                                  direction: Axis.horizontal,
                                  children: List.generate(
                                    itemsPerOrder[i],
                                    (index) {
                                      if (listCounter <
                                          getCartHistoryList.length) {
                                        listCounter++;
                                      }
                                      return (index < 3)
                                          ? Container(
                                              height: 80,
                                              width: 80,
                                              margin: EdgeInsets.only(
                                                  right: Dimensions.len5),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        Dimensions.len16 / 2),
                                                image: DecorationImage(
                                                  fit: BoxFit.cover,
                                                  image: NetworkImage(
                                                      AppConstants.BASE_URL +
                                                          AppConstants
                                                              .UPLOADS_URI +
                                                          getCartHistoryList[
                                                                  listCounter -
                                                                      1]
                                                              .img!),
                                                ),
                                              ),
                                            )
                                          : Container();
                                    },
                                  ),
                                ),
                                SizedBox(
                                  height: Dimensions.len30 * 2,
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      SmallText(
                                          text: 'Total',
                                          color: AppColors.titleColor),
                                      BigText(
                                          text: itemsPerOrder[i] > 1
                                              ? '${itemsPerOrder[i]} Items'
                                              : '${itemsPerOrder[i]} Item',
                                          color: AppColors.titleColor,
                                          size: Dimensions.len16),
                                      GestureDetector(
                                        onTap: () {
                                          var orderTime = cartOrderTimeToList();
                                          Map<int, CartModel> addMore = {};
                                          for (int j = 0;
                                              j < getCartHistoryList.length;
                                              j++) {
                                            if (getCartHistoryList[j].time ==
                                                orderTime[i]) {
                                              addMore.putIfAbsent(
                                                  getCartHistoryList[j].id!,
                                                  () => CartModel.fromJson(
                                                      jsonDecode(jsonEncode(
                                                          getCartHistoryList[
                                                              j]))));
                                            }
                                          }
                                          Get.find<CartController>().setItems =
                                              addMore;
                                          Get.find<CartController>()
                                              .addToCartList();
                                          Get.toNamed(
                                              RouteHelper.getCartPage());
                                        },
                                        child: Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: Dimensions.wit15,
                                              vertical: Dimensions.len5),
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: AppColors.mainColor,
                                                  width: 1.0,
                                                  style: BorderStyle.solid),
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      Dimensions.len5)),
                                          child: SmallText(
                                              text: 'Add more...',
                                              color: AppColors.mainColor),
                                        ),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
