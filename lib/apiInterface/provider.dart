import 'package:dio/dio.dart';
import 'package:practical_task/modal/Menu.dart';
import 'package:http/http.dart' as http;

class ApiProvider{

  // static Future<List<MenuResponse>> fetchProducts() async {
  //   var response =
  //   await http.get(Uri.parse("https://www.mocky.io/v2/5dfccffc310000efc8d2c1ad"));
  //   if (response.statusCode == 200) {
  //     var data = response.body;
  //     print(response.body);
  //     return menuFromJson(data);
  //   } else {
  //     throw Exception();
  //   }
  // }

  static Future<List<MenuResponse>?> fetchProducts() async {
    try{
      var response =await Dio().get('https://www.mocky.io/v2/5dfccffc310000efc8d2c1ad');
      if(response.statusCode == 200){
        print(response);
        var data = response.data;
        return menuFromJson(data);
      }
    }
    catch(e){
      print(e);
      return null;
    }
  }


}