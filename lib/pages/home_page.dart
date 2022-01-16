import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:practical_task/Controllers/cart_controller.dart';
import 'package:practical_task/Controllers/controller.dart';
import 'package:practical_task/Controllers/login_controller.dart';
import 'package:practical_task/Controllers/menu_controller.dart';
import 'package:practical_task/modal/Cart.dart';
import 'package:practical_task/modal/Menu.dart';
import 'package:practical_task/pages/cart_page.dart';
import 'package:practical_task/pages/login.dart';
import 'package:practical_task/utility/app_images.dart';

class HomePage extends StatefulWidget {
  List<MenuResponse>? menuList;
  String? profile_image;
  String? profile_email;
  String? username;
  HomePage({this.menuList,this.profile_image,this.username,this.profile_email});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  // final MyTabController _tabx = Get.put(MyTabController());
  final MenuController productController = Get.put(MenuController());
  RxList<CartItemModel> cartItems = RxList<CartItemModel>([]);
  List<Tab> tabs = [];
  List<int> cartCounter=[];
  AppController appController = Get.find();
  final CartController controller = Get.put(CartController());

  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    productController.getQuantity();

  }


  @override
  Widget build(BuildContext context) {
    return  DefaultTabController(
        length: widget.menuList![0].tableMenuList!.length,
        child: new Scaffold(
            key: _scaffoldKey,
            appBar: new AppBar(
              automaticallyImplyLeading: false,
              backgroundColor: Colors.white,
              leading: InkWell(
                onTap: (){
                  _scaffoldKey.currentState!.openDrawer();
                },
                  child: Icon(Icons.menu_rounded,color: Colors.black,)),
              actions: [
                Obx((
                ()=>InkWell(
                  onTap:(){
                    Get.to(CartPage());
                  },
                  child: Padding(
                    padding:
                    const EdgeInsets.only(left: 0, right: 15, top: 8, bottom: 8),
                    child: Stack(
                      children: [
                        Align(
                            alignment: Alignment.bottomCenter,
                            child: Icon(Icons.shopping_cart_rounded,
                                color: Colors.blue, size: 25)),
                        Visibility(
                          visible: productController.cartQuantity.toString()!='0'?true:false,
                          child: Positioned(
                            top: 8,
                            left: 0,
                            right: 0,
                            child: Container(
                              height: 15,
                              width: 15,
                              margin: EdgeInsets.only(right: 10),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.red,
                              ),
                              child: Center(child: Text(productController.cartQuantity.toString()),
                            ),
                          ),
                          ),
                        )
                      ],
                    ),
                  ),
                )
                )),

              ],
              bottom: new TabBar(
                isScrollable: true,
                labelColor: Colors.grey,
                indicatorColor: Colors.pink,
                tabs: List<Widget>.generate(widget.menuList![0].tableMenuList!.length, (int index){
                  return Container(
                    margin: EdgeInsets.only(bottom: 10.0),
                      child:Text(widget.menuList![0].tableMenuList![index].menuCategory!));
                }),

              ),
            ),
            drawer: Drawer(
              child: Column(
                children: [
                  Container(
                    height: 200,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.only(bottomRight: Radius.circular(10.0),bottomLeft: Radius.circular(10.0))
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 80,
                          width: 80,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                            image: DecorationImage(image: NetworkImage(widget.profile_image!))
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 10),
                          child: Text(widget.username!,style: TextStyle(color: Colors.white,fontWeight: FontWeight.w600,fontSize: 16),),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 10),
                          child: Text(widget.profile_email!,style: TextStyle(color: Colors.white,fontWeight: FontWeight.w600,fontSize: 14),),
                        )
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: (){
                      LoginController loginController = Get.find<LoginController>();
                      loginController.logoutGoogle();
                      loginController.removeUserSession();
                      loginController.isLogIn=false;
                      Get.offAll(LoginPage());

                    },
                    child: Container(
                      margin: EdgeInsets.only(top: 20,left: 10),
                      child: Row(
                        children: [
                          Icon(Icons.logout,color: Colors.grey,),
                          SizedBox(width: 20,),
                          Text("Logout",style: TextStyle(color: Colors.grey,fontSize: 16),),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            body: new TabBarView(
              children: List<Widget>.generate(widget.menuList![0].tableMenuList!.length, (int index){
                return listItems(widget.menuList![0].tableMenuList![index].categoryDishes);

              }),
            )
        ));
  }

  Widget listItems(List<CategoryDishes>? tab_content){
    return Container(
      margin: EdgeInsets.only(left: 8,right: 8,top: 10),
      child: ListView.builder(
          itemCount: tab_content!.length,
          itemBuilder:(context,index){
            if(appController.cartItems.contains(tab_content[index])){
            }
            print(tab_content[index].dishName);
            return Container(
              margin: EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: Colors.grey))
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 2,
                        child: Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Image.asset(tab_content[index].dishType==2?AppImages.type_veg:AppImages.type_nonveg,height: 20,width: 20,),
                                  Container(
                                    margin: EdgeInsets.only(left: 10),
                                      width: 140,
                                      child: Text(tab_content[index].dishName!,style: TextStyle(fontWeight:FontWeight.w600,fontSize: 16),)),
                                ],
                              ),
                              Container(
                                margin: EdgeInsets.only(left: 30,top: 8),
                                  child: Text("INR "+tab_content[index].dishPrice.toString(),style: TextStyle(fontWeight:FontWeight.w600,fontSize: 16),)),

                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: EdgeInsets.only(left: 10),
                                child: Text(tab_content[index].dishCalories.toString()+" calories",style: TextStyle(fontWeight:FontWeight.w600,fontSize: 14),)),
                            // Image.network(tab_content[index].dishImage!,height: 40,width: 40,)
                          ],
                        ),
                      )
                    ],
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                        margin: EdgeInsets.only(left: 30,top: 8),
                        child: Text(tab_content[index].dishDescription.toString(),style: TextStyle(fontWeight:FontWeight.w600,fontSize: 14,color: Colors.grey),)),
                  ),
                  Align(
                    alignment :Alignment.centerLeft,
                    child: Container(
                      height: 30,
                      width:80,
                      margin: EdgeInsets.only(left: 30,top: 20),
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(20)
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
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
                                      CategoryDishes categoryDishes=tab_content[index];
                                      addProduct(categoryDishes);

                                    },
                                    child: Icon(Icons.add,color: Colors.white,)),
                                //Text("${productController.qtyController[index]}",style: TextStyle(color: Colors.white),),
                               Obx(()=>Text("${appController.cartItems.value[index].quantity}",style: TextStyle(color: Colors.white),)),
                                InkWell(
                                    onTap:(){
                                      if(appController.cartItems.value[index].quantity>0){
                                        appController.cartItems.value[index].decrementQuantity();
                                      }

                                    },
                                    child: Icon(Icons.remove,color: Colors.white,)),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                 tab_content[index].addonCat!.isEmpty?
                 Align(
                   alignment: Alignment.centerLeft,
                   child: Container(
                     margin: EdgeInsets.only(top: 10),
                       child: Text("")),
                 ):
                 Align(
                   alignment: Alignment.centerLeft,
                   child: Container(
                       margin: EdgeInsets.only(top: 10,left: 30,bottom: 10),
                       child: Text("Customization Available",style: TextStyle(color: Colors.red),)),
                 )
                ],
              ),
            );
          }
      ),
    );
  }

  addProduct(CategoryDishes categoryDishes) {
    try {
      CartItemModel cartItem =
      appController.cartItems.value.firstWhere((cartItem) {
        return cartItem.product.dishId == categoryDishes.dishId;
      });
      cartItem.incrementQuantity();

    } catch (error) {
      appController.cartItems.add(CartItemModel(
        product: categoryDishes,
        quantity: 1,
      ));
    }
  }

  manage_quantity(List<CategoryDishes> tab_content,index){
    if(cartItems.length<tab_content.length){
      CategoryDishes categoryDishes=tab_content[index];
      CartItemModel cartItemModel= new CartItemModel(product: categoryDishes,quantity: 0);
      cartItems.add(cartItemModel);
    }
  }




}



