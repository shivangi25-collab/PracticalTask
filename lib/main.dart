import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:practical_task/Controllers/controller.dart';
import 'package:practical_task/Controllers/menu_controller.dart';
import 'package:practical_task/apiInterface/provider.dart';
import 'package:practical_task/pages/cart_page.dart';
import 'package:practical_task/pages/home_page.dart';
import 'package:practical_task/pages/login.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final AppController appController =Get.put(AppController());
  final MenuController productController = Get.put(MenuController());
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
    );
  }
}


