import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:lottie/lottie.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../../../routes/app_pages.dart';

class LoginController extends GetxController {
  Future<void> googlelog() async {
    GoogleSignIn _googleSignIn = GoogleSignIn();
    GoogleSignInAccount? ciredenu;
    UserCredential? UserC;
    try {
      await _googleSignIn.signOut();
      await _googleSignIn.signIn().then((value) => ciredenu = value);
      final isSignedIn = await _googleSignIn.isSignedIn();
      if (isSignedIn) {
        final googlouth = await ciredenu!.authentication;
        final credential = GoogleAuthProvider.credential(
          accessToken: googlouth.accessToken,
          idToken: googlouth.idToken,
        );
        await FirebaseAuth.instance
            .signInWithCredential(credential)
            .then((value) => UserC = value);
        Get.offNamed(Routes.HOME);
      } else {
        print("gagal");
      }
      ;
    } catch (error) {
      print(error);
    }
  }

  var auth = FirebaseAuth.instance;
  Future<void> login(String email, String password) async {
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      var user = userCredential.user;
      if (user!.emailVerified) {
        Get.offNamed(Routes.HOME);
      } else {
        Get.dialog(AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          content: LottieBuilder.asset("assets/lottie/sentemail.json"),
          title: Text(
            "Verifikasi email",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 25,
            ),
            textAlign: TextAlign.center,
          ),
          actions: [
            TextButton(onPressed: () => Get.back(), child: Text("Kembali"))
          ],
        ));
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        Get.dialog(AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          content: LottieBuilder.asset("assets/lottie/gagal.json"),
          title: Text(
            "User Belum Terdaftar",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 25,
            ),
            textAlign: TextAlign.center,
          ),
          actions: [
            TextButton(onPressed: () => Get.back(), child: Text("Kembali"))
          ],
        ));
      } else if (e.code == 'wrong-password') {
        Get.dialog(AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          content: LottieBuilder.asset("assets/lottie/gagal.json"),
          title: Text(
            "Password Salah",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 25,
            ),
            textAlign: TextAlign.center,
          ),
          actions: [
            TextButton(onPressed: () => Get.back(), child: Text("Oke"))
          ],
        ));
      }
    }
  }
}
