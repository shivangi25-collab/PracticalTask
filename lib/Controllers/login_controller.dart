import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:practical_task/Controllers/menu_controller.dart';
import 'package:practical_task/pages/home_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();
  final MenuController productController = Get.find<MenuController>();
  var profile_image,profile_id,user_name;
  bool isLogIn=false;

  @override
  void onInit(){
    checkUserSession();
    super.onInit();
  }

  loginWithGoogle() async {
    try {
      final GoogleSignInAccount? googleSignInAccount =
      await googleSignIn.signIn();
      final GoogleSignInAuthentication googleSignInAuthentication =
      await googleSignInAccount!.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );
      final authResult = await _auth.signInWithCredential(credential);

      final User? user = authResult.user;
      profile_image=user!.photoURL;
      profile_id=user.email;
      user_name=user.displayName;
      addUserSession(user.email.toString(),user_name,profile_image);
      Future.delayed(const Duration(milliseconds: 5000), () {
        Get.to(HomePage(menuList: productController.menuList,username: user_name,profile_email: profile_id,profile_image: profile_image,));
      });
      assert(!user.isAnonymous);
      assert(await user.getIdToken() != null);
      final User? currentUser = _auth.currentUser;
      assert(user.uid == currentUser!.uid);
      return;
    } catch (e) {
      throw (e);
    }
  }

  Future<void> logoutGoogle() async {
    await googleSignIn.signOut();
  }

  addUserSession(String id,String uname,String profile_img) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('LoginID', id);
    prefs.setString('uname', uname);
    prefs.setString('profile_img', profile_img);
  }

  checkUserSession() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? stringValue = prefs.getString('LoginID');
    String? user_name = prefs.getString('uname');
    String? user_image = prefs.getString('profile_img');

    if(stringValue!=null){
      isLogIn=true;
      Future.delayed(const Duration(milliseconds: 5000), () {
        Get.to(HomePage(menuList: productController.menuList,username: user_name,profile_email: stringValue,profile_image: user_image,));
      });
    }
    else{
      loginWithGoogle();
    }
    return stringValue;
  }

  removeUserSession() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove("LoginID");
  }

}