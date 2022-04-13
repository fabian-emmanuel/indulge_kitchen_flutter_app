import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:indulge_kitchen/data/models/cart_model.dart';
import 'package:indulge_kitchen/data/models/products_model.dart';
import 'package:indulge_kitchen/data/repository/cart_repo.dart';
import 'package:indulge_kitchen/utils/colors.dart';

class CartController extends GetxController {
  final CartRepo cartRepo;

  CartController({required this.cartRepo});

  Map<int, CartModel> _items = {};
  Map<int, CartModel> get items => _items;

  void addItem(ProductModel product, int quantity) {
    int totalQuantity = 0;
    if (_items.containsKey(product.id)) {
      _items.update(product.id!, (value) {
        totalQuantity = value.quantity! + quantity;
        return CartModel(
          id: value.id,
          name: value.name,
          price: value.price,
          img: value.img,
          quantity: value.quantity! + quantity,
          isExist: true,
          time: DateTime.now().toString(),
        );
      });

      if (quantity <= 0) {
        if (totalQuantity <= 0) {
          _items.remove(product.id);
          Get.snackbar(
            "${product.name}",
            "Removed from Cart Successfully!",
            backgroundColor: AppColors.iconColor2,
            colorText: Colors.white,
          );
          return;
        }
        Get.snackbar(
          "${quantity * -1} ${product.name}",
          "Removed from Cart Successfully!",
          backgroundColor: AppColors.iconColor2,
          colorText: Colors.white,
        );
      }
    } else {
      if (quantity > 0) {
        _items.putIfAbsent(
            product.id!,
            () => CartModel(
                  id: product.id,
                  name: product.name,
                  price: product.price,
                  img: product.img,
                  quantity: quantity,
                  isExist: true,
                  time: DateTime.now().toString(),
                ));
        Get.snackbar(
          "$quantity ${product.name}",
          "Added to Cart Successfully!",
          backgroundColor: AppColors.mainColor,
          colorText: Colors.white,
        );
      } else {
        Get.snackbar(
          "$quantity ${product.name}",
          "Can't add 0 item to Cart!",
          backgroundColor: Colors.redAccent,
          colorText: Colors.white,
        );
      }
    }
  }

  bool existInCart(ProductModel product) {
    return _items.containsKey(product.id) ? true : false;
  }

  int getQuantity(ProductModel product) {
    var quantity = 0;
    if (_items.containsKey(product.id)) {
      _items.forEach((key, value) {
        if (key == product.id) {
          (quantity = value.quantity!);
        }
      });
    }
    return quantity;
  }

  int get totalItems {
    var totalItems = 0;
    _items.forEach((key, value) {
      totalItems += value.quantity!;
    });
    return totalItems;
  }
}
