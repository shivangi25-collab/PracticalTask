import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:practical_task/Controllers/controller.dart';
import 'package:practical_task/modal/Cart.dart';

class CartController extends GetxController {

  AppController appController = Get.find();
  int dishes=0;

  String get total {
    double fold = appController.cartItems.value.fold(0, (subtotal, cartItem) {
      return subtotal + cartItem.product.dishPrice! * cartItem.quantity;
    });
    return " "+ fold.toStringAsFixed(2);
  }

  deleteItem(CartItemModel cartItemModel) {
    appController.cartItems.removeWhere((cartItem) {
      return cartItem.product.dishId == cartItemModel.product.dishId;
    });
  }

  placeOrder() {
    appController.cartItems.clear();
    Get.back();
    Get.snackbar(
      "Placed",
      "Order placed with success!",
      backgroundColor: Colors.green,
      colorText: Colors.white,
      padding: EdgeInsets.all(15),
      snackPosition: SnackPosition.BOTTOM,
      margin: EdgeInsets.all(25),
      icon: Icon(Icons.check, color: Colors.white, size: 21),
    );
  }
}