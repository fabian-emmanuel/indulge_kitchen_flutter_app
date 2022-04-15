import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:indulge_kitchen/data/models/cart_model.dart';
import 'package:indulge_kitchen/data/models/products_model.dart';
import 'package:indulge_kitchen/data/repository/cart_repo.dart';
import 'package:indulge_kitchen/utils/colors.dart';

class CartController extends GetxController {
  final CartRepo cartRepo;

  CartController({required this.cartRepo});

  List<CartModel> storageItems = [];

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
          product: product,
        );
      });

      if (quantity < 1) {
        if (totalQuantity < 1) {
          _items.remove(product.id);
          Get.snackbar(
            "${product.name}",
            "Removed from Cart Successfully!",
            backgroundColor: AppColors.iconColor2,
            colorText: Colors.white,
          );
        }
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
                  product: product,
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
    cartRepo.addToCartList(getItems);
    update();
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

  List<CartModel> get getItems {
    return _items.entries.map((e) => e.value).toList();
  }

  int get totalAmount {
    var totalAmount = 0;
    _items.forEach((key, value) {
      totalAmount += value.price! * value.quantity!;
    });
    return totalAmount;
  }

  List<CartModel> getCartData() {
    setCart = cartRepo.getCartList();
    return storageItems;
  }

  set setCart(List<CartModel> items) {
    storageItems = items;
    print('length of cart items ${storageItems.length}');
    for (int i = 0; i < storageItems.length; i++) {
      _items.putIfAbsent(storageItems[i].product!.id!, () => storageItems[i]);
    }
  }

  void addToHistory() {
    cartRepo.addToCartHistoryList();
    clear();
  }

  void clear() {
    _items = {};
    update();
  }

  List<CartModel> getCartHistoryList(){
    return cartRepo.getCartHistoryList();
  }
}
