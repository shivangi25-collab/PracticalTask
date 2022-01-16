import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:practical_task/Controllers/cart_controller.dart';
import 'package:practical_task/modal/Cart.dart';
import 'package:practical_task/utility/app_images.dart';

class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {

  final CartController controller = Get.put(CartController());
  String? dishes,items;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dishes=controller.appController.cartItems.length.toString();
    items=controller.appController.cartItems.length.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: (){
            Get.back();
          },
            child: Icon(Icons.arrow_back,color: Colors.grey,)),
        backgroundColor: Colors.white,
        title: Text("Order Summary",style: TextStyle(color: Colors.grey,fontSize: 16,fontWeight: FontWeight.w600),),
      ),
      body: GetBuilder<CartController>(
        init: CartController(),
        builder: (controller){
          return Stack(
            children: [
              Container(
                margin: EdgeInsets.only(left: 10,right: 10,top: 20,bottom: 60),
                decoration: BoxDecoration(
                    border: Border(bottom: BorderSide(color: Colors.grey))
                ),
                child: Obx(()=>
                  ListView.builder(
                      itemCount:controller.appController.cartItems.length,
                      itemBuilder: (context,index){

                        return Container(
                          margin: EdgeInsets.only(top: 60),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: controller.appController.cartItems.value[index].product.dishType==2?
                            Image.asset(AppImages.type_veg,height: 20,width: 20,):Image.asset(AppImages.type_veg,height: 20,width: 20,)
                                  ),
                                  Expanded(
                                      flex: 3,
                                      child:Text(controller.appController.cartItems.value[index].product.dishName!,style: TextStyle(fontWeight: FontWeight.w600),)
                                  ),
                                  Expanded(
                                      flex: 2,
                                      child:Center(
                                        child: Container(
                                          height: 30,
                                          width: 80,
                                          decoration: BoxDecoration(
                                              color: Colors.green[800],
                                              borderRadius: BorderRadius.circular(20)
                                          ),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              InkWell(
                                                onTap:(){
                                                  controller.appController.cartItems.value[index].incrementQuantity();
                                                },
                                                  child: Icon(Icons.add,color: Colors.white,)),
                                              Obx(()=>this.controller.appController.cartItems.value[index].quantity!=null?Text("${this.controller.appController.cartItems.value[index].quantity.toString()}",style: TextStyle(color: Colors.white),):Text("0",style: TextStyle(color: Colors.white),)),
                                              InkWell(
                                                  onTap:(){
                                                    controller.appController.cartItems.value[index].decrementQuantity();
                                                  },
                                                  child: Icon(Icons.remove,color: Colors.white,)),
                                            ],
                                          ),
                                        ),
                                      )
                                  ),
                                  Expanded(
                                      flex: 2,
                                      child: Container(
                                          margin: EdgeInsets.only(left: 10),
                                          child: Obx(()=>Text("INR "+(controller.appController.cartItems.value[index].product.dishPrice! * controller.appController.cartItems.value[index].quantity).toString(),style: TextStyle(fontSize: 16,color: Colors.black),)),))
                                ],
                              ),
                              Container(
                                  margin: EdgeInsets.only(left: 45,top: 10),
                                  child: Text(("INR "+controller.appController.cartItems.value[index].product.dishPrice.toString()),style: TextStyle(fontWeight: FontWeight.w600),)),
                              Container(
                                  margin: EdgeInsets.only(left: 45,top: 10),
                                  child: Text((controller.appController.cartItems.value[index].product.dishCalories.toString()+" Calories"),style: TextStyle(fontWeight: FontWeight.w600),))
                            ],
                          ),
                        );
                      }),
                ),
              ),
              Column(
                children: [
                  Container(
                    height: 40,
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.only(left: 10,right: 10,top: 10),
                    decoration: BoxDecoration(
                      color: Colors.green[900],
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    child: Center(child: Text(dishes!+'Dishes - '+items!+'Items',style: TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.w600),)),
                  ),
                  Expanded(
                    child: Align(
                      alignment:FractionalOffset.bottomCenter,
                      child: Container(
                        margin: EdgeInsets.only(left: 10,right: 10,bottom: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Total Amount",style: TextStyle(fontWeight: FontWeight.w600,fontSize: 16),),
                            Obx(()=>Text("INR"+controller.total,style: TextStyle(fontSize: 16,color: Colors.lightGreen),)),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              )
            ],
          );
        },
      )
    );
  }
}