import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:indulge_kitchen/utils/dimensions.dart';
import 'package:indulge_kitchen/widgets/big_text.dart';

void showCustomSnackBar(String message,
    {bool isError = true,
    String title = 'Error',
    Color bgColor = Colors.redAccent}) {
  Get.snackbar(
    title,
    message,
    titleText: BigText(
      text: title,
      color: Colors.white,
      size: Dimensions.len10,
    ),
    messageText: Text(
      message,
      style: TextStyle(color: Colors.white, fontSize: Dimensions.len10),
    ),
    colorText: Colors.white,
    snackPosition: SnackPosition.TOP,
    backgroundColor: bgColor,
  );
}
