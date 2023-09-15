import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class RisetController extends GetxController {
  var auth = FirebaseAuth.instance;
  Future<void> riset(String Emailc) async {
    await auth
      ..sendPasswordResetEmail(email: Emailc);
  }
}
