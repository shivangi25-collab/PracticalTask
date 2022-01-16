import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:practical_task/Controllers/menu_controller.dart';
import 'package:practical_task/pages/home_page.dart';

class LoginController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();
  final MenuController productController = Get.find<MenuController>();
  var profile_image,profile_id,user_name;

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
      assert(!user.isAnonymous);
      assert(await user.getIdToken() != null);
      final User? currentUser = _auth.currentUser;
      assert(user.uid == currentUser!.uid);
      Future.delayed(const Duration(milliseconds: 5000), () {

        Get.to(HomePage(menuList: productController.menuList,username: user_name,profile_email: profile_id,profile_image: profile_image,));
      });
      return;
    } catch (e) {
      throw (e);
    }
  }

  Future<void> logoutGoogle() async {
    await googleSignIn.signOut();
  }

}