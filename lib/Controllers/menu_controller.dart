import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:practical_task/Controllers/controller.dart';
import 'package:practical_task/Controllers/login_controller.dart';
import 'package:practical_task/apiInterface/provider.dart';
import 'package:practical_task/modal/Menu.dart';

class MenuController extends GetxController with GetSingleTickerProviderStateMixin {
  var isLoading = true.obs;
  var productList = [].obs;
  var counter='0'.obs;
  AppController appController = Get.find();
  List<MenuResponse> menuList= [];
  RxList<int> qtyController = RxList<int>([]);
  //var qtyController=[].obs;


  @override
  void onInit(){
    fetchProducts();
    super.onInit();
  }

  void fetchProducts() async {
    try {
      isLoading(true);

      var products = await ApiProvider.fetchProducts();
      if (products != null) {
        productList.value = products;
        print(("ENTER API"));
        productList.forEach((element) {
          menuList.add(element);
          print(menuList[0].restaurantName);
        });
      }
    } finally {
      isLoading(false);
    }
  }


  int get cartQuantity {
    return appController.cartItems.length;
  }

  List<CategoryDishes> _catDish=[];

  getQuantity(){
    print("ENTER QTY");
    menuList.forEach((element) {
      _catDish.addAll(element.tableMenuList![0].categoryDishes!);
    });

    if(appController.cartItems.isEmpty){
      for(int i=0;i<_catDish.length;i++){
        qtyController.add(0);
      }
    }
    else{
        for(int i=0;i<=_catDish.length;i++){
          for(int j=0;j<appController.cartItems.length;j++){
          if(_catDish[j].dishId == appController.cartItems[j].product.dishId)
          {
            print(appController.cartItems[j].quantity);
            qtyController.add(appController.cartItems[j].quantity);
          }
          else{
            qtyController.add(0);
          }
        }
      }
    }
  }

}