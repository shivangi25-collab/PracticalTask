import 'package:get/get.dart';
import 'package:practical_task/modal/Menu.dart';

class CartItemModel {
  CartItemModel({
    CategoryDishes? product,
    int? quantity,
  }) {
    this.product = product!;
    this.quantity = quantity!;
  }
  Rx<CategoryDishes> _product = CategoryDishes().obs;
  set product(CategoryDishes value) => _product.value = value;
  CategoryDishes get product => _product.value;

  RxInt _quantity = 0.obs;
  set quantity(int value) => _quantity.value = value;
  int get quantity => _quantity.value;

  incrementQuantity(){
    print('ENter');
    if (this.quantity >= 10) {
      this.quantity = 10;
    } else {
      this.quantity += 1;
    }
  }

  decrementQuantity() {
    if (this.quantity <= 0) {
      this.quantity = 1;
    } else {
      this.quantity -= 1;
    }
  }
}