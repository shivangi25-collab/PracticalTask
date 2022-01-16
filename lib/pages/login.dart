import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:practical_task/Controllers/login_controller.dart';
import 'package:practical_task/utility/app_images.dart';

class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);

  final LoginController controller = Get.put(LoginController());
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 200,
              width: 200,
              child: Image.asset(AppImages.firebase_logo),
            ),
            InkWell(
              onTap: (){
                controller.loginWithGoogle();
              },
              child: Container(
                height: 50,
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.only(left: 50,right: 50,top: 30),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  color: Colors.blue,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      height: 35,
                      width: 35,
                      margin: EdgeInsets.only(left: 10),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                          image: DecorationImage(image: AssetImage(AppImages.google_logo),fit: BoxFit.contain)
                      ),

                    ),
                    Expanded(
                      child:Align(
                        alignment: Alignment.center,
                        child: Container(
                          margin: EdgeInsets.only(right: 30),
                          child: Text("Google",style: TextStyle(fontSize: 16,color: Colors.white,fontWeight: FontWeight.w600),),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
