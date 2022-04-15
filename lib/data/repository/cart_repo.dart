import 'dart:convert';

import 'package:indulge_kitchen/data/models/cart_model.dart';
import 'package:indulge_kitchen/utils/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartRepo {
  final SharedPreferences preferences;

  CartRepo({required this.preferences});

  List<String> cart = [];
  List<String> cartHistory = [];

  final _cartHistoryList = AppConstants.CART_HISTORY_LIST;
  final _cartList = AppConstants.CART_LIST;

  void addToCartList(List<CartModel> cartItems) {
    // preferences.remove(_cartList);
    // preferences.remove(_cartHistoryList);

    var time = DateTime.now();
    cart = [];

    cartItems.forEach((element) {
      element.time = '$time';
      return cart.add(jsonEncode(element));
    });
    preferences.setStringList(_cartList, cart);
    // getCartList();
  }

  List<CartModel> getCartList() {
    List<String> carts = [];
    if (preferences.containsKey(_cartList)) {
      carts = preferences.getStringList(_cartList)!;
    }
    List<CartModel> cartList = [];
    carts.forEach((element) {
      cartList.add(CartModel.fromJson(jsonDecode(element)));
    });
    return cartList;
  }

  void addToCartHistoryList() {
    if (preferences.containsKey(_cartHistoryList)) {
      cartHistory = preferences.getStringList(_cartHistoryList)!;
    }

    for (int i = 0; i < cart.length; i++) {
      print('history list ${cart[i]}');
      cartHistory.add(cart[i]);
    }
    removeCart();
    preferences.setStringList(_cartHistoryList, cartHistory);
    print('lenght of history list is ${getCartHistoryList().length}');
    for (int j = 0; j < getCartHistoryList().length; j++) {
      print('time of order is ${getCartHistoryList()[j].time}');
    }
  }

  void removeCart() {
    cart = [];
    preferences.remove(_cartList);
  }

  List<CartModel> getCartHistoryList() {
    if (preferences.containsKey(_cartHistoryList)) {
      // cartHistory = [];
      cartHistory = preferences.getStringList(_cartHistoryList)!;
    }
    List<CartModel> cartHistoryList = [];
    cartHistory.forEach((element) =>
        cartHistoryList.add(CartModel.fromJson(jsonDecode(element))));
    return cartHistoryList;
  }
}
